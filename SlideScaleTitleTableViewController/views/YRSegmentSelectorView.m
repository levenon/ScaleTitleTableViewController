//
//  YRSegmentSelectorView.m
//  pyyx
//
//  Created by xulinfeng on 2017/1/3.
//  Copyright © 2017年 Chunlin Ma. All rights reserved.
//

#import "YRSegmentSelectorView.h"
#import "YRSegmentSelectorItemCell.h"
#import "YRSegmentCollectionSelectorView.h"
#import "YRSegmentCollectionItemCell.h"
#import <Masonry/Masonry.h>

@interface YRSegmentSelectorView ()<MMHorizontalListViewDelegate, MMHorizontalListViewDataSource, YRSegmentCollectionSelectorViewDelegate, YRSegmentCollectionSelectorViewDataSource>

@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, strong) MMHorizontalListView *horizontalListView;

@property (nonatomic, strong) YRSegmentCollectionSelectorView *expendSelectorView;

@property (nonatomic, strong) UIButton *expendButton;

@end

@implementation YRSegmentSelectorView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self _createSubviews];
        [self _configurateSubviewsDefault];
        [self _installConstraints];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
//    self.gradientLayer.frame = [[self maskView] bounds];
}

#pragma mark - accessor

- (void)setAllowExpend:(BOOL)allowExpend{
    self.expendButton.hidden = !allowExpend;
}

- (BOOL)allowExpend{
    return ![[self expendButton] isHidden];
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex{
    if (_selectedIndex != selectedIndex) {
        _selectedIndex = selectedIndex;
        
        [[self horizontalListView] selectCellAtIndex:selectedIndex animated:YES];
    }
}

#pragma mark - delegate operator
- (NSUInteger)numberOfItems;{
    if ([[self delegate] respondsToSelector:@selector(numberOfItemsInSelector:)]) {
        return [[self delegate] numberOfItemsInSelector:self];
    }
    return 0;
}

- (UIView *)containerView;{
    if ([[self delegate] respondsToSelector:@selector(containerViewForExpendInSelector:)]) {
        return [[self delegate] containerViewForExpendInSelector:self];
    }
    return nil;
}

- (NSString *)titleAtIndex:(NSUInteger)index;{
    if ([[self delegate] respondsToSelector:@selector(selector:titleAtIndex:)]) {
        return [[self delegate] selector:self titleAtIndex:index];
    }
    return nil;
}

- (void)didSelectAtIndex:(NSUInteger)index;{
    _selectedIndex = index;
    
    if ([[self delegate] respondsToSelector:@selector(selector:didSelectAtIndex:)]) {
        [[self delegate] selector:self didSelectAtIndex:index];
    }
}

- (YRSegmentCollectionSelectorView *)newSegmentCollectionSelectorView{
    NSInteger column = 3 + (CGRectGetWidth([[UIScreen mainScreen] bounds]) > 320);
    CGFloat itemWidth = (CGRectGetWidth([self bounds]) - 32 - (column - 1) * 6 ) / column;
    
    YRSegmentCollectionSelectorView *segmentCollectionSelectorView = [[YRSegmentCollectionSelectorView alloc] initWithSelectedIndex:[self selectedIndex]];
    segmentCollectionSelectorView.alpha = 0.f;
    segmentCollectionSelectorView.delegate = self;
    segmentCollectionSelectorView.dataSource = self;
    segmentCollectionSelectorView.expendItemSize = CGSizeMake(itemWidth, 41);
    [segmentCollectionSelectorView registerClass:[YRSegmentCollectionItemCell class] forCellWithReuseIdentifier:NSStringFromClass([YRSegmentCollectionItemCell class])];
    
    return segmentCollectionSelectorView;
}

#pragma mark - private

- (void)_createSubviews{
    
    self.maskView = [UIView new];
//    self.gradientLayer = [CAGradientLayer layer];
    self.expendButton = [UIButton new];
    self.contentView = [UIView new];
    self.horizontalListView = [MMHorizontalListView new];
    
    [self addSubview:[self contentView]];
    [[self contentView] addSubview:[self horizontalListView]];
    
    [self addSubview:[self maskView]];
    [self addSubview:[self expendButton]];
}

- (void)_configurateSubviewsDefault{
    
    self.contentView.layer.masksToBounds = YES;
    
    self.horizontalListView.delegate = self;
    self.horizontalListView.dataSource = self;
    self.horizontalListView.cellSpacing = 20;
    self.horizontalListView.autoScrollPosition = MMHorizontalListViewPositionCenter;
    self.horizontalListView.layer.masksToBounds = NO;

//    self.gradientLayer.colors = @[(__bridge id)[[UIColor colorWithWhite:0 alpha:0] CGColor], (__bridge id)[[UIColor colorWithWhite:0 alpha:1] CGColor]];
//    self.gradientLayer.startPoint = CGPointMake(0.0f, 0.0f);
//    self.gradientLayer.endPoint = CGPointMake(1.0f, 0.0f);
//    
//    self.maskView.backgroundColor = [UIColor blueColor];
    
    self.expendButton.titleLabel.font = [UIFont systemFontOfSize:20];
    
    [[self expendButton] setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [[self expendButton] setTitle:@"∨" forState:UIControlStateNormal];
    [[self expendButton] addTarget:self action:@selector(didClickExpendButton:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)_installConstraints{
    
    [[self contentView] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(16);
        make.top.bottom.equalTo(self);
    }];
    
    [[self horizontalListView] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(0, 0, 0, 20));
    }];
    
    [[self maskView] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.equalTo(self.contentView);
        make.width.mas_equalTo(42);
    }];
    
    [[self expendButton] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView.mas_right);
        make.right.equalTo(self).offset(-16);
        make.top.bottom.equalTo(self);
        make.width.mas_equalTo(22);
    }];
}

- (void)_updateCategoryOverlayerDisplay:(BOOL)display{
    if (display) {
        UIView *containerView = [self containerView];
        CGRect rectInContainerView = [self convertRect:[self bounds] toView:containerView];
        self.expendSelectorView = [self newSegmentCollectionSelectorView];
        self.expendSelectorView.frame = (CGRect){rectInContainerView.origin, CGRectGetWidth(rectInContainerView), CGRectGetHeight([containerView bounds]) - CGRectGetMinY(rectInContainerView)};
        
        [containerView addSubview:[self expendSelectorView]];
        [[self expendSelectorView] reloadData];
    
        self.userInteractionEnabled = NO;
        [UIView animateWithDuration:0.1 animations:^{
            self.expendSelectorView.alpha = 1.f;
        } completion:^(BOOL finished) {
            self.userInteractionEnabled = YES;
            [[self expendSelectorView] expend:YES animated:YES completion:nil];
        }];;
    } else {
        self.userInteractionEnabled = NO;
        [[self expendSelectorView] expend:NO animated:YES completion:^{
            [UIView animateWithDuration:0.1 animations:^{
                self.expendSelectorView.alpha = 0.f;
            } completion:^(BOOL finished) {
                self.userInteractionEnabled = YES;
                [[self expendSelectorView] removeFromSuperview];
            }];
        }];
    }
}

#pragma mark - actions

- (IBAction)didClickExpendButton:(UIButton *)sender{
    [self _updateCategoryOverlayerDisplay:![sender isSelected]];
}

#pragma mark - public

- (void)reloadData;{
    [self layoutIfNeeded];
    
    [[self horizontalListView] reloadData];
}

#pragma mark - MMHorizontalListViewDelegate, MMHorizontalListViewDataSource

- (NSInteger)MMHorizontalListViewNumberOfCells:(MMHorizontalListView *)horizontalListView;{
    return [self numberOfItems];
}

- (CGFloat)MMHorizontalListView:(MMHorizontalListView *)horizontalListView widthForCellAtIndex:(NSInteger)index;{
    return [YRSegmentSelectorItemCell horizontalListView:horizontalListView widthWithTitle:[self titleAtIndex:index]];
}

- (MMHorizontalListViewCell *)MMHorizontalListView:(MMHorizontalListView *)horizontalListView cellAtIndex:(NSInteger)index;{
    YRSegmentSelectorItemCell *cell = (YRSegmentSelectorItemCell *)[horizontalListView dequeueCellWithReusableIdentifier:NSStringFromClass([YRSegmentSelectorItemCell class])];
    if (!cell) {
        cell = [[YRSegmentSelectorItemCell alloc] initWithFrame:CGRectMake(0, 0, 0, 21)];
    }
    cell.title = [self titleAtIndex:index];
    
    return cell;
}
    
- (void)MMHorizontalListView:(MMHorizontalListView *)horizontalListView didSelectCellAtIndex:(NSInteger)index;{
    [self didSelectAtIndex:index];
}

#pragma YRSegmentCollectionSelectorViewDataSource, YRSegmentCollectionSelectorViewDelegate

- (NSUInteger)numberOfItemsInSelectorView:(YRSegmentCollectionSelectorView *)selectorView;{
    return [self numberOfItems];
}

- (void)selectorView:(YRSegmentCollectionSelectorView *)selectorView configurateCellAtIndex:(NSUInteger)index cell:(YRSegmentCollectionItemCell *)cell;{
    cell.title = [self titleAtIndex:index];
}

- (void)selectorView:(YRSegmentCollectionSelectorView *)selectorView didSelectRowAtIndex:(NSUInteger)index;{
    [[self horizontalListView] selectCellAtIndex:index animated:YES];
    [self didSelectAtIndex:index];
    
    [self _updateCategoryOverlayerDisplay:NO];
}

- (void)didCancelInSelectorView:(YRSegmentCollectionSelectorView *)selectorView;{
    [self _updateCategoryOverlayerDisplay:NO];
}


@end
