//
//  YRSlideScaleCarouselItemView.h
//  pyyx
//
//  Created by xulinfeng on 2017/1/4.
//  Copyright © 2017年 Chunlin Ma. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YRSlideScaleCarouselItemView;
@protocol YRSlideScaleCarouselItemViewDelegate <UIScrollViewDelegate>

- (CGFloat)slideScaleCarouselItemView:(YRSlideScaleCarouselItemView *)slideScaleCarouselItemView tableView:(UITableView *)tableView heightForCellAtIndex:(NSUInteger)index;
- (UITableViewCell *)slideScaleCarouselItemView:(YRSlideScaleCarouselItemView *)slideScaleCarouselItemView tableView:(UITableView *)tableView cellAtIndex:(NSUInteger)index;

- (void)slideScaleCarouselItemView:(YRSlideScaleCarouselItemView *)slideScaleCarouselItemView didSelectAtIndex:(NSUInteger)index;

- (void)slideScaleCarouselItemView:(YRSlideScaleCarouselItemView *)slideScaleCarouselItemView refreshCompletion:(void (^)(NSArray *dataSource, BOOL hasMore))refreshCompletion;

- (void)slideScaleCarouselItemView:(YRSlideScaleCarouselItemView *)slideScaleCarouselItemView loadMoreCompletion:(void (^)(NSArray *dataSource, BOOL hasMore))loadMoreCompletion;

@end

@interface YRSlideScaleCarouselItemView : UIView<UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>

@property (nonatomic, strong, readonly) UITableView *tableView;

@property (nonatomic, strong) NSArray *dataSource;

@property (nonatomic, weak) id<YRSlideScaleCarouselItemViewDelegate> delegate;

@property (nonatomic, assign) BOOL allowRefresh;
@property (nonatomic, assign) BOOL allowLoadMore;

- (void)prepareForReuse;

- (void)refresh;

- (void)loadMore;

@end
