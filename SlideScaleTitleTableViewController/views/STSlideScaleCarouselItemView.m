//
//  STSlideScaleCarouselItemView.m
//  Marke Jave
//
//  Created by Marke Jave on 2017/1/4.
//  Copyright © 2017年 Chunlin Ma. All rights reserved.
//

#import "STSlideScaleCarouselItemView.h"
#import <Masonry/Masonry.h>
#import <MJRefresh/MJRefresh.h>

@interface STSlideScaleCarouselItemView ()

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation STSlideScaleCarouselItemView{
    NSArray *_dataSource;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [self _createSubviews];
        [self _installConstraints];
    }
    return self;
}

- (void)willMoveToSuperview:(UIView *)newSuperview{
    [super willMoveToSuperview:newSuperview];
    
    self.tableView.delegate = newSuperview ? self : nil;
    self.tableView.dataSource = newSuperview ? self : nil;
}

- (void)prepareForReuse;{
    self.dataSource = nil;
    [[self tableView] reloadData];
}

- (void)refresh {
    if ([[self delegate] respondsToSelector:@selector(slideScaleCarouselItemView:refreshCompletion:)]) {
        [[self delegate] slideScaleCarouselItemView:self refreshCompletion:^(NSArray *dataSource, BOOL hasMore) {
            [self _handleRemoteDataSource:dataSource append:NO hasMore:hasMore];
        }];
    }
}

- (void)loadMore {
    if ([[self delegate] respondsToSelector:@selector(slideScaleCarouselItemView:loadMoreCompletion:)]) {
        [[self delegate] slideScaleCarouselItemView:self loadMoreCompletion:^(NSArray *dataSource, BOOL hasMore) {
            [self _handleRemoteDataSource:dataSource append:YES hasMore:hasMore];
        }];
    }
}

#pragma mark - private

- (void)_createSubviews {
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    
    [self addSubview:[self tableView]];
}

- (void)_installConstraints{
    
    [[self tableView] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

- (void)_handleRemoteDataSource:(NSArray *)dataSource append:(BOOL)append hasMore:(BOOL)hasMore {
    NSMutableArray *localDataSource = [[self dataSource] mutableCopy];
    if (append) {
        [localDataSource addObjectsFromArray:dataSource];
    } else {
        localDataSource.array = dataSource;
    }
    self.dataSource = localDataSource;
    self.allowLoadMore = hasMore;
    
    if ([self allowLoadMore]) {
        if (![[self tableView] mj_footer]) {
            self.tableView.mj_footer = [MJRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(didTriggerLoadMore:)];
        }
    } else {
        self.tableView.mj_footer = nil;
    }
    [[[self tableView] mj_footer] endRefreshing];
    [[[self tableView] mj_header] endRefreshing];
    
    [self _reloadData];
}

- (void)_reloadData{
    if ([self superview] && [[self tableView] delegate] && [[self tableView] dataSource]) {
        [[self tableView] reloadData];
    }
}

#pragma mark - accessor

- (NSArray *)dataSource{
    if (!_dataSource) {
        _dataSource = @[];
    }
    return _dataSource;
}

- (void)setAllowRefresh:(BOOL)allowRefresh{
    _allowRefresh = allowRefresh;
    
    if (allowRefresh) {
        if (![[self tableView] mj_header]) {
            self.tableView.mj_header = [MJRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(didTriggerRefresh:)];
        }
    } else {
        [[[self tableView] mj_header] endRefreshing];
        self.tableView.mj_header = nil;
    }
}

#pragma mark - actions

- (IBAction)didTriggerRefresh:(id)sender{
    [self refresh];
}

- (IBAction)didTriggerLoadMore:(id)sender{
    [self loadMore];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self dataSource] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [[self delegate] slideScaleCarouselItemView:self tableView:tableView heightForCellAtIndex:[indexPath row]];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [[self delegate] slideScaleCarouselItemView:self tableView:tableView cellAtIndex:[indexPath row]];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if ([[self delegate] respondsToSelector:@selector(slideScaleCarouselItemView:didSelectAtIndex:)]) {
        [[self delegate] slideScaleCarouselItemView:self didSelectAtIndex:[indexPath row]];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if ([[self delegate] respondsToSelector:@selector(scrollViewDidScroll:)]) {
        [[self delegate] scrollViewDidScroll:scrollView];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView;{
    if ([[self delegate] respondsToSelector:@selector(scrollViewWillBeginDragging:)]) {
        [[self delegate] scrollViewWillBeginDragging:scrollView];
    }
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    if ([[self delegate] respondsToSelector:@selector(scrollViewWillEndDragging:withVelocity:targetContentOffset:)]) {
        [[self delegate] scrollViewWillEndDragging:scrollView withVelocity:velocity targetContentOffset:targetContentOffset];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate;{
    if ([[self delegate] respondsToSelector:@selector(scrollViewDidEndDragging:willDecelerate:)]) {
        [[self delegate] scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
    }
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView;{
    if ([[self delegate] respondsToSelector:@selector(scrollViewWillBeginDecelerating:)]) {
        [[self delegate] scrollViewWillBeginDecelerating:scrollView];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView;{
    if ([[self delegate] respondsToSelector:@selector(scrollViewDidEndDecelerating:)]) {
        [[self delegate] scrollViewDidEndDecelerating:scrollView];
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView;{
    if ([[self delegate] respondsToSelector:@selector(scrollViewDidEndScrollingAnimation:)]) {
        [[self delegate] scrollViewDidEndScrollingAnimation:scrollView];
    }
}

@end
