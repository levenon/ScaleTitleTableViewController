//
//  YRScaleTitleTableViewController.h
//  pyyx
//
//  Created by xulinfeng on 2017/1/3.
//  Copyright © 2017年 Chunlin Ma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YRTableViewController.h"

@class YRScaleTitleView;
@interface YRScaleTitleTableViewController : YRTableViewController

@property (nonatomic, strong, readonly) YRScaleTitleView * titleView;

@property (nonatomic, copy) NSString *tabbarItemTitle;

@end
