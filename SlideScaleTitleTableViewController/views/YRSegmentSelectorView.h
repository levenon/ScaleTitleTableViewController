//
//  YRSegmentSelectorView.h
//  pyyx
//
//  Created by xulinfeng on 2017/1/3.
//  Copyright © 2017年 Chunlin Ma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMHorizontalListView.h"

@class YRSegmentSelectorView;
@protocol YRSegmentSelectorViewDelegate <NSObject>

@required
- (NSUInteger)numberOfItemsInSelector:(YRSegmentSelectorView *)selector;

- (UIView *)containerViewForExpendInSelector:(YRSegmentSelectorView *)selector;

@optional
- (NSString *)selector:(YRSegmentSelectorView *)selector titleAtIndex:(NSUInteger)index;

- (void)selector:(YRSegmentSelectorView *)selector didSelectAtIndex:(NSUInteger)index;

@end

@interface YRSegmentSelectorView : UIView

@property (nonatomic, strong, readonly) MMHorizontalListView *horizontalListView;

@property (nonatomic, strong, readonly) UIButton *expendButton;

@property (nonatomic, weak) id<YRSegmentSelectorViewDelegate> delegate;

@property (nonatomic, assign) BOOL allowExpend;

@property (nonatomic, assign) NSUInteger selectedIndex;

- (void)reloadData;

@end
