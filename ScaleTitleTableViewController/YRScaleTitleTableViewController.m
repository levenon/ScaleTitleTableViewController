//
//  YRScaleTitleTableViewController.m
//  pyyx
//
//  Created by xulinfeng on 2017/1/3.
//  Copyright © 2017年 Chunlin Ma. All rights reserved.
//

#import "YRScaleTitleTableViewController.h"
#import "YRScaleTitleView.h"

@interface YRScaleTitleTableViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) YRScaleTitleView * titleView;

@property (nonatomic, assign, readonly) UITableViewStyle style;

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation YRScaleTitleTableViewController
@dynamic tableView, style;

- (instancetype)init{
    if (self = [super init]) {
        self.automaticallyAdjustsScrollViewInsets = NO;
        self.tableView = ({
            UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:[self style]];
            tableView.delegate = self;
            tableView.dataSource = self;
            tableView;
        });
    }
    return self;
}

- (void)loadView{
    [super loadView];
    
    self.tableView.frame = [[self view] bounds];
    [[self view] addSubview:[self tableView]];
    [[self view] addSubview:[self titleView]];
}

#pragma mark - accessor

- (YRScaleTitleView *)titleView{
    if (!_titleView) {
        _titleView = [[YRScaleTitleView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth([[self view] bounds]), 79)];
        _titleView.autoresizing = YES;
        _titleView.minHeight = 79;
        _titleView.maxHeight = 109;
        _titleView.titleLabel.text = [self title];
        _titleView.backgroundColor = [UIColor colorWithRed:7/255. green:18/255. blue:71/255. alpha:1];
    }
    return _titleView;
}

- (void)setTabbarItemTitle:(NSString *)tabbarItemTitle{
    if (_tabbarItemTitle != tabbarItemTitle) {
        _tabbarItemTitle = tabbarItemTitle;
        
        self.tabBarItem.title = tabbarItemTitle;
    }
}

- (UIEdgeInsets)contentInset{
    return UIEdgeInsetsMake(self.titleView.maxHeight, 0, 0, 0);
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView;{
    CGFloat contentOffsetY = scrollView.contentOffset.y;
    CGFloat titleViewHeight = [[self titleView] maxHeight] - contentOffsetY;
    
    titleViewHeight = MIN([[self titleView] maxHeight], titleViewHeight);
    titleViewHeight = MAX([[self titleView] minHeight], titleViewHeight);
    
    CGRect frame = [[self titleView] frame];
    self.titleView.frame = (CGRect){frame.origin, frame.size.width, titleViewHeight};
}

@end
