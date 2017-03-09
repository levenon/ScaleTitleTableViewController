//
//  STSlideScaleTitleTableViewController.h
//  Marke Jave
//
//  Created by Marke Jave on 2017/1/3.
//  Copyright © 2017年 Chunlin Ma. All rights reserved.
//

#import "STSlideScaleCarouselItemView.h"
#import "STSegmentScaleTitleView.h"
#import "STSlideScaleCarousel.h"

@interface STSlideScaleTitleModel : NSObject

@property (nonatomic, strong) NSString *title;

@property (nonatomic, strong) NSArray *dataSource;

@property (nonatomic, assign) NSUInteger page;

@property (nonatomic, assign) BOOL hasMore;

@end

@interface STSlideScaleTitleTableViewController : UIViewController<iCarouselDelegate, iCarouselDataSource, STSlideScaleCarouselItemViewDelegate, STSegmentSelectorViewDelegate, UIScrollViewDelegate>

- (instancetype)initWithStyle:(UITableViewStyle)style;

@property (nonatomic, strong) NSArray<STSlideScaleTitleModel *> *dataSource;

@property (nonatomic, assign) NSUInteger currentIndex;

@property (nonatomic, strong, readonly) UIView *backgroundView;

@property (nonatomic, strong, readonly) STSlideScaleCarousel *containerView;

// The default content-inset for tableView
@property (nonatomic, assign, readonly) UIEdgeInsets contentInset;

@property (nonatomic, strong, readonly) STSegmentScaleTitleView * titleView;

- (void)initialize;

- (CGFloat)tableView:(UITableView *)tableView itemIndex:(NSUInteger)itemIndex heightForCellAtIndex:(NSUInteger)dataIndex;

- (UITableViewCell *)tableView:(UITableView *)tableView itemIndex:(NSUInteger)itemIndex cellAtIndex:(NSUInteger)dataIndex;

- (void)didSelectAtItemIndex:(NSUInteger)itemIndex;
- (void)didSelectAtItemIndex:(NSUInteger)itemIndex dataIndex:(NSUInteger)dataIndex;

// It require to load more if append is YES, or to refresh.
- (void)loadAtItemIndex:(NSUInteger)itemIndex append:(BOOL)append completion:(void (^)(NSArray *dataSource, NSUInteger page, BOOL hasMore))completion;

#pragma mark - public
- (void)reloadData;

@end
