//
//  YRSegmentScaleTitleView.h
//  pyyx
//
//  Created by xulinfeng on 2017/1/3.
//  Copyright © 2017年 Chunlin Ma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YRSegmentSelectorView.h"
#import "YRScaleTitleView.h"

@interface YRSegmentScaleTitleView : UIView

@property (nonatomic, strong, readonly) YRScaleTitleView *scaleTitleView;

@property (nonatomic, strong, readonly) YRSegmentSelectorView *segmentSelectorView;

/**
 * The max value will be used if autoresizing is NO,
 * or the font of titleLabel will be autoresized in range,
 * default is NSMakeRange(64, 80)
 */
@property (nonatomic, assign) CGFloat minHeight;
@property (nonatomic, assign) CGFloat maxHeight;


@property (nonatomic, assign) BOOL autoresizing;

@end
