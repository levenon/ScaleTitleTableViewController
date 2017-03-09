//
//  YRSlideScaleTitleTableViewController.m
//  pyyx
//
//  Created by xulinfeng on 2017/1/3.
//  Copyright © 2017年 Chunlin Ma. All rights reserved.
//

#import "YRSlideScaleTitleTableViewController.h"

const CGFloat YRSegmentScaleTitleViewHeight = 146;

@implementation YRSlideScaleTitleModel

- (instancetype)init{
    if (self = [super init]) {
        self.page = 1;
        self.hasMore = YES;
    }
    return self;
}

- (NSArray *)dataSource{
    if (!_dataSource) {
        _dataSource = @[];
    }
    return _dataSource;
}

@end

@interface YRSlideScaleTitleTableViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIView *backgroundView;

@property (nonatomic, strong) YRSegmentScaleTitleView * titleView;

@property (nonatomic, strong) YRSlideScaleCarousel *containerView;

@property (nonatomic, assign) UITableViewStyle style;

@property (nonatomic, assign) CGPoint dragBeginContentOffset;

@end

@implementation YRSlideScaleTitleTableViewController

- (instancetype)initWithStyle:(UITableViewStyle)style;{
    if (self = [self init]) {
        self.style = style;
        [self initialize];
    }
    return self;
}

- (instancetype)init{
    if (self = [super init]) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    return self;
}

- (void)initialize{
    
}

- (void)loadView{
    [super loadView];
    
    [[self view] addSubview:[self backgroundView]];
    [[self view] addSubview:[self titleView]];
    [[self view] addSubview:[self containerView]];
}

- (CGFloat)tableView:(UITableView *)tableView itemIndex:(NSUInteger)itemIndex heightForCellAtIndex:(NSUInteger)dataIndex;{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView itemIndex:(NSUInteger)itemIndex cellAtIndex:(NSUInteger)dataIndex;{
    return nil;
}

- (void)didSelectAtItemIndex:(NSUInteger)itemIndex;{
}

- (void)didSelectAtItemIndex:(NSUInteger)itemIndex dataIndex:(NSUInteger)dataIndex;{
    
}

- (void)loadAtItemIndex:(NSUInteger)itemIndex append:(BOOL)append completion:(void (^)(NSArray *dataSource, NSUInteger page, BOOL hasMore))completion;{
    
}

- (void)reloadData;{
    [[[self titleView] segmentSelectorView] reloadData];
    [[self containerView] reloadData];
}

#pragma mark - private

- (void)_refreshCurrentItemViewIfNeeds{
    YRSlideScaleCarouselItemView *itemView = (YRSlideScaleCarouselItemView *)[[self containerView] itemViewAtIndex:[self currentIndex]];
    YRSlideScaleTitleModel *model = [self dataSourceEnable] ? [self dataSource][[self currentIndex]] : nil;
    if (itemView && model && ![[model dataSource] ?: @[] count] && [model hasMore]) {
        [itemView refresh];
    } else if (itemView && model && [[model dataSource] ?: @[] count]) {
        [[itemView tableView] reloadData];
    }
}

- (void)_updateSelectedIndex:(NSInteger)index{
    _currentIndex = index;
    self.titleView.segmentSelectorView.selectedIndex = index;
    
    [self didSelectAtItemIndex:index];
}

- (void)_updateTitleViewHeight:(CGFloat)titleViewHeight{
    CGRect frame = [[self titleView] frame];
    self.titleView.frame = (CGRect){frame.origin, frame.size.width, titleViewHeight};
    self.containerView.frame = CGRectMake(0, titleViewHeight, CGRectGetWidth([[self view] bounds]), CGRectGetHeight([[self view] bounds]) - titleViewHeight);
}

#pragma mark - accessor

- (BOOL)dataSourceEnable{
    return [self currentIndex] < [[self dataSource] count];
}

- (UIView *)backgroundView{
    if (!_backgroundView) {
        _backgroundView = [[UIView alloc] initWithFrame:[[self view] bounds]];
    }
    return _backgroundView;
}

- (YRSegmentScaleTitleView *)titleView{
    if (!_titleView) {
        _titleView = [[YRSegmentScaleTitleView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth([[self view] bounds]), YRSegmentScaleTitleViewHeight)];
        _titleView.backgroundColor = [UIColor clearColor];
        _titleView.minHeight = YRSegmentScaleTitleViewHeight;
        _titleView.maxHeight = YRSegmentScaleTitleViewHeight;
        
        _titleView.scaleTitleView.titleLabel.text = [self title];
        _titleView.scaleTitleView.backgroundColor = [UIColor clearColor];
        
        _titleView.segmentSelectorView.delegate = self;
        _titleView.segmentSelectorView.backgroundColor = [UIColor clearColor];
        _titleView.segmentSelectorView.horizontalListView.backgroundColor = [UIColor clearColor];
        _titleView.segmentSelectorView.horizontalListView.showsHorizontalScrollIndicator = NO;
        _titleView.segmentSelectorView.horizontalListView.contentInset = UIEdgeInsetsMake(0, 0, 0, 20);
    }
    return _titleView;
}

- (YRSlideScaleCarousel *)containerView{
    if (!_containerView) {
        _containerView = [[YRSlideScaleCarousel alloc] initWithFrame:CGRectMake(0, YRSegmentScaleTitleViewHeight, CGRectGetWidth([[self view] bounds]), CGRectGetHeight([[self view] bounds]) - YRSegmentScaleTitleViewHeight)];
        _containerView.bounces = NO;
        _containerView.delegate = self;
        _containerView.dataSource = self;
        _containerView.pagingEnabled = YES;
        _containerView.type = iCarouselTypeLinear;
        _containerView.backgroundColor = [UIColor clearColor];
    }
    return _containerView;
}

- (NSArray<YRSlideScaleTitleModel *> *)dataSource{
    if (!_dataSource) {
        _dataSource = @[];
    }
    return _dataSource;
}

- (YRSlideScaleCarouselItemView *)carousel:(iCarousel *)carousel itemViewAtIndex:(NSUInteger)index{
    YRSlideScaleCarouselItemView *itemView = [[YRSlideScaleCarouselItemView alloc] initWithFrame:[carousel bounds]];
    
    itemView.delegate = self;
    itemView.allowRefresh = YES;
    itemView.tableView.tableHeaderView = [UIView new];
    itemView.tableView.tableFooterView = [UIView new];
    itemView.tableView.contentInset = [self contentInset];
    itemView.tableView.backgroundColor = [UIColor clearColor];
    itemView.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    return itemView;
}

- (MMHorizontalListView *)horizontalListView{
    return [[[self titleView] segmentSelectorView] horizontalListView];
}

- (void)setCurrentIndex:(NSUInteger)currentIndex{
    _currentIndex = currentIndex;
    
    [[self containerView] scrollToItemAtIndex:currentIndex animated:YES];
    [[self horizontalListView] selectCellAtIndex:currentIndex animated:YES];
}

#pragma mark - iCarouselDelegate, iCarouselDataSource

- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel;{
    return [[self dataSource] count];
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(YRSlideScaleCarouselItemView *)view;{
    YRSlideScaleTitleModel *model = [self dataSource][index];
    if (!view) {
        view = [self carousel:carousel itemViewAtIndex:index];
    } else {
        [view prepareForReuse];
    }
    view.dataSource = [[model dataSource] copy];
    view.allowLoadMore = [model hasMore];
    
    return view;
}

- (void)carouselDidEndScrollingAnimation:(iCarousel *)carousel{
    [self _refreshCurrentItemViewIfNeeds];
}

- (void)carouselDidScroll:(iCarousel *)carousel{
    NSInteger currentIndex = [carousel currentItemIndex];;
    if ([self currentIndex] != NSNotFound && [[self dataSource] count]) {
        CGFloat progress = ([carousel scrollOffset] - [self currentIndex]);
        [[self horizontalListView] updateIndex:[self currentIndex] progress:progress];
        
        if (![carousel isDragging] && ![carousel isDecelerating] && currentIndex != [self currentIndex]) {
            [self _updateSelectedIndex:currentIndex];
        }
    }
}

- (void)carouselDidEndDecelerating:(iCarousel *)carousel;{
    NSInteger currentIndex = [carousel currentItemIndex];
    NSInteger selectedIndex = [self currentIndex];
    if (selectedIndex != NSNotFound) {
        if (currentIndex != selectedIndex) {
            [self _updateSelectedIndex:currentIndex];
        } else {
            [[self horizontalListView] updateIndex:selectedIndex progress:0];
        }
    }
}

#pragma mark - YRSlideScaleCarouselItemViewDelegate

- (CGFloat)slideScaleCarouselItemView:(YRSlideScaleCarouselItemView *)slideScaleCarouselItemView tableView:(UITableView *)tableView heightForCellAtIndex:(NSUInteger)index;{
    NSUInteger itemIndex = [[self containerView] indexOfItemView:slideScaleCarouselItemView];
    return [self tableView:tableView itemIndex:itemIndex heightForCellAtIndex:index];
}

- (UITableViewCell *)slideScaleCarouselItemView:(YRSlideScaleCarouselItemView *)slideScaleCarouselItemView tableView:(UITableView *)tableView  cellAtIndex:(NSUInteger)index;{
    NSUInteger itemIndex = [[self containerView] indexOfItemView:slideScaleCarouselItemView];
    
    return [self tableView:tableView itemIndex:itemIndex cellAtIndex:index];
}

- (void)slideScaleCarouselItemView:(YRSlideScaleCarouselItemView *)slideScaleCarouselItemView didSelectAtIndex:(NSUInteger)index;{
    NSUInteger itemIndex = [[self containerView] indexOfItemView:slideScaleCarouselItemView];
    
    [self didSelectAtItemIndex:itemIndex dataIndex:index];
}

- (void)slideScaleCarouselItemView:(YRSlideScaleCarouselItemView *)slideScaleCarouselItemView refreshCompletion:(void (^)(NSArray *dataSource, BOOL hasMore))refreshCompletion;{
    NSUInteger itemIndex = [[self containerView] indexOfItemView:slideScaleCarouselItemView];
    YRSlideScaleTitleModel *model = [self dataSource][itemIndex];
    
    [self loadAtItemIndex:itemIndex append:NO completion:^(NSArray *dataSource, NSUInteger page, BOOL hasMore) {
        model.dataSource = dataSource;
        model.hasMore = hasMore;
        model.page = page;
        
        if (refreshCompletion && [[self containerView] indexOfItemView:slideScaleCarouselItemView] != NSNotFound) {
            refreshCompletion(dataSource, hasMore);
        }
    }];
}

- (void)slideScaleCarouselItemView:(YRSlideScaleCarouselItemView *)slideScaleCarouselItemView loadMoreCompletion:(void (^)(NSArray *dataSource, BOOL hasMore))loadMoreCompletion;{
    NSUInteger itemIndex = [[self containerView] indexOfItemView:slideScaleCarouselItemView];
    YRSlideScaleTitleModel *model = [self dataSource][itemIndex];
    
    [self loadAtItemIndex:itemIndex append:YES completion:^(NSArray *dataSource, NSUInteger page, BOOL hasMore) {
        model.dataSource = [[model dataSource] arrayByAddingObjectsFromArray:dataSource];
        model.hasMore = hasMore;
        model.page = page;
        
        if (loadMoreCompletion) {
            loadMoreCompletion(dataSource, hasMore);
        }
    }];
}

#pragma mark - YRSegmentSelectorViewDelegate

- (NSUInteger)numberOfItemsInSelector:(YRSegmentSelectorView *)selector;{
    return [[self dataSource] count];
}

- (UIView *)containerViewForExpendInSelector:(YRSegmentSelectorView *)selector;{
    return [self view];
}

- (NSString *)selector:(YRSegmentSelectorView *)selector titleAtIndex:(NSUInteger)index;{
    YRSlideScaleTitleModel *model = [self dataSource][index];
    return [model title];
}

- (void)selector:(YRSegmentSelectorView *)selector didSelectAtIndex:(NSUInteger)index;{
    _currentIndex = index;
    
    [[self containerView] scrollToItemAtIndex:index animated:YES];
    [self didSelectAtItemIndex:index];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView;{
    self.dragBeginContentOffset = [scrollView contentOffset];
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    if ([[self titleView] minHeight] == [[self titleView] maxHeight]) {
        return;
    }
    
    CGFloat titleViewHeight = 0.f;
    if (velocity.y != 0) {
        titleViewHeight = velocity.y > 0 ? [[self titleView] minHeight] : [[self titleView] maxHeight];
    } else {
        CGFloat currentTitleViewHeight = [[self titleView] frame].size.height;
        
        titleViewHeight = fabs([[self titleView] maxHeight] - currentTitleViewHeight) < fabs([[self titleView] minHeight] - currentTitleViewHeight) ? [[self titleView] maxHeight] : [[self titleView] minHeight];
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        [self _updateTitleViewHeight:titleViewHeight];
    }];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView;{
    if ([scrollView isDragging] && [[self titleView] minHeight] != [[self titleView] maxHeight]) {
        CGFloat contentOffsetY = scrollView.contentOffset.y - [self dragBeginContentOffset].y;
        CGFloat titleViewHeight = [[self titleView] frame].size.height - contentOffsetY;
        
        titleViewHeight = MIN([[self titleView] maxHeight], titleViewHeight);
        titleViewHeight = MAX([[self titleView] minHeight], titleViewHeight);
        
        [self _updateTitleViewHeight:titleViewHeight];
    }
}

@end
