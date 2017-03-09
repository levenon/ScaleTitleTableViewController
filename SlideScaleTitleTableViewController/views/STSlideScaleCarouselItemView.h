//
//  STSlideScaleCarouselItemView.h
//  Marke Jave
//
//  Created by Marke Jave on 2017/1/4.
//  Copyright © 2017年 Chunlin Ma. All rights reserved.
//

#import <UIKit/UIKit.h>

@class STSlideScaleCarouselItemView;
@protocol STSlideScaleCarouselItemViewDelegate <UIScrollViewDelegate>

- (CGFloat)slideScaleCarouselItemView:(STSlideScaleCarouselItemView *)slideScaleCarouselItemView tableView:(UITableView *)tableView heightForCellAtIndex:(NSUInteger)index;
- (UITableViewCell *)slideScaleCarouselItemView:(STSlideScaleCarouselItemView *)slideScaleCarouselItemView tableView:(UITableView *)tableView cellAtIndex:(NSUInteger)index;

- (void)slideScaleCarouselItemView:(STSlideScaleCarouselItemView *)slideScaleCarouselItemView didSelectAtIndex:(NSUInteger)index;

- (void)slideScaleCarouselItemView:(STSlideScaleCarouselItemView *)slideScaleCarouselItemView refreshCompletion:(void (^)(NSArray *dataSource, BOOL hasMore))refreshCompletion;

- (void)slideScaleCarouselItemView:(STSlideScaleCarouselItemView *)slideScaleCarouselItemView loadMoreCompletion:(void (^)(NSArray *dataSource, BOOL hasMore))loadMoreCompletion;

@end

@interface STSlideScaleCarouselItemView : UIView<UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>

@property (nonatomic, strong, readonly) UITableView *tableView;

@property (nonatomic, strong) NSArray *dataSource;

@property (nonatomic, weak) id<STSlideScaleCarouselItemViewDelegate> delegate;

@property (nonatomic, assign) BOOL allowRefresh;
@property (nonatomic, assign) BOOL allowLoadMore;

- (void)prepareForReuse;

- (void)refresh;

- (void)loadMore;

@end
