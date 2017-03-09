//
//  STSegmentSelectorView.h
//  Marke Jave
//
//  Created by Marke Jave on 2017/1/3.
//  Copyright © 2017年 Chunlin Ma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMHorizontalListView.h"

@class STSegmentSelectorView;
@protocol STSegmentSelectorViewDelegate <NSObject>

@required
- (NSUInteger)numberOfItemsInSelector:(STSegmentSelectorView *)selector;

- (UIView *)containerViewForExpendInSelector:(STSegmentSelectorView *)selector;

@optional
- (NSString *)selector:(STSegmentSelectorView *)selector titleAtIndex:(NSUInteger)index;

- (void)selector:(STSegmentSelectorView *)selector didSelectAtIndex:(NSUInteger)index;

@end

@interface STSegmentSelectorView : UIView

@property (nonatomic, strong, readonly) MMHorizontalListView *horizontalListView;

@property (nonatomic, strong, readonly) UIButton *expendButton;

@property (nonatomic, weak) id<STSegmentSelectorViewDelegate> delegate;

@property (nonatomic, assign) BOOL allowExpend;

@property (nonatomic, assign) NSUInteger selectedIndex;

- (void)reloadData;

@end
