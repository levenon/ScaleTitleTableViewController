//
//  STScaleTitleTableViewController.h
//  Marke Jave
//
//  Created by Marke Jave on 2017/1/3.
//  Copyright © 2017年 Marke Jave. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STTableViewController.h"

@class STScaleTitleView;
@interface STScaleTitleTableViewController : STTableViewController

@property (nonatomic, strong, readonly) STScaleTitleView * titleView;

@property (nonatomic, copy) NSString *tabbarItemTitle;

@end
