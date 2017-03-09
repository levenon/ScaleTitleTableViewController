//
//  STSegmentSelectorItemCell.h
//  Marke Jave
//
//  Created by Marke Jave on 2017/1/4.
//  Copyright © 2017年 Chunlin Ma. All rights reserved.
//
#import "MMHorizontalListViewCell.h"

@class MMHorizontalListView;
@interface STSegmentSelectorItemCell : MMHorizontalListViewCell

@property (nonatomic, strong) NSString *title;

+ (CGFloat)horizontalListView:(MMHorizontalListView *)horizontalListView widthWithTitle:(NSString *)title;

@end
