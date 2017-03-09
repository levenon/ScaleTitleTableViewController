//
//  STScaleTitleView.h
//  Marke Jave
//
//  Created by Marke Jave on 2017/1/3.
//  Copyright © 2017年 Chunlin Ma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface STScaleTitleView : UIView

@property (nonatomic, strong, readonly) UILabel *titleLabel;
@property (nonatomic, strong, readonly) UIView *rightContentView;

/**
 * The max value will be used if autoresizing is NO,
 * or the font of titleLabel will be autoresized in range,
 * default is NSMakeRange(64, 80)
 */
@property (nonatomic, assign) CGFloat minHeight;
@property (nonatomic, assign) CGFloat maxHeight;

@property (nonatomic, assign) BOOL autoresizing;

@end
