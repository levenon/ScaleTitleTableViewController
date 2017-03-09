//
//  ScaleTitleViewController.m
//  Demo
//
//  Created by xulinfeng on 2017/3/9.
//  Copyright © 2017年 xulinfeng. All rights reserved.
//

#import "ScaleTitleViewController.h"
#import "DemoTableViewCell.h"

@interface ScaleTitleViewController ()

@end

@implementation ScaleTitleViewController

- (instancetype)init{
    if (self = [super init]) {
        self.title = @"标题";
    }
    return self;
}

- (void)loadView{
    [super loadView];
    
    self.tableView.rowHeight = 120;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.view.backgroundColor = [UIColor colorWithRed:7/255. green:18/255. blue:71/255. alpha:1];
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    [[self tableView] reloadData];
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DemoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([DemoTableViewCell class])];
    if (!cell) {
        cell = [[DemoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([DemoTableViewCell class])];
    }
    return cell;
}

@end
