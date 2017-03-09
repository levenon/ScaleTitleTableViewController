//
//  YRSegmentSelectorItemCell.h
//  pyyx
//
//  Created by xulinfeng on 2017/1/4.
//  Copyright © 2017年 Chunlin Ma. All rights reserved.
//
#import "MMHorizontalListViewCell.h"

@class MMHorizontalListView;
@interface YRSegmentSelectorItemCell : MMHorizontalListViewCell

@property (nonatomic, strong) NSString *title;

+ (CGFloat)horizontalListView:(MMHorizontalListView *)horizontalListView widthWithTitle:(NSString *)title;

@end
