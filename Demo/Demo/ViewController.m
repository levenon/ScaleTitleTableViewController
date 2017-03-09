//
//  ViewController.m
//  Marke Jave
//
//  Created by Marke Jave on 2017/1/3.
//  Copyright © 2017年 Marke Jave. All rights reserved.
//

#import <Masonry/Masonry.h>

#import "ViewController.h"
#import "MMHorizontalListView.h"
#import "DemoTableViewCell.h"

@interface ViewController ()

@property (nonatomic, strong) NSArray *categories;

@property (nonatomic, strong) UIButton *firstButton;
@property (nonatomic, strong) UIButton *secondButton;

@property (nonatomic, strong, readonly) UIView *buttonsContentView;

@property (nonatomic, strong, readonly) MMHorizontalListView *horizontalListView;

@end

@implementation ViewController

- (instancetype)init{
    if (self = [super init]) {
        self.title = @"标题";
    }
    return self;
}

- (void)loadView{
    [super loadView];
    
    self.view.backgroundColor = [UIColor colorWithRed:7/255. green:18/255. blue:71/255. alpha:1];
    
    [[self buttonsContentView] addSubview:[self firstButton]];
    [[self buttonsContentView] addSubview:[self secondButton]];
    
    [self _installConstraints];
    
    self.titleView.minHeight = 67;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self _mockRemoteCategories];
}

- (void)loadAtItemIndex:(NSUInteger)itemIndex append:(BOOL)append completion:(void (^)(NSArray *dataSource, NSUInteger page, BOOL hasMore))completion;{
    STSlideScaleTitleModel *model = [self dataSource][itemIndex];
    NSString *category = [self categories][itemIndex];
    
    [self _mockDetailWithCategoryID:category append:append currentPage:[model page] completion:completion];
}

- (CGFloat)tableView:(UITableView *)tableView itemIndex:(NSUInteger)itemIndex heightForCellAtIndex:(NSUInteger)dataIndex;{
    return 120;
}

- (UITableViewCell *)tableView:(UITableView *)tableView itemIndex:(NSUInteger)itemIndex cellAtIndex:(NSUInteger)dataIndex;{
    DemoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([DemoTableViewCell class])];
    if (!cell) {
        cell = [[DemoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([DemoTableViewCell class])];
    }
    return cell;
}

- (void)didSelectAtItemIndex:(NSUInteger)itemIndex{
    [super didSelectAtItemIndex:itemIndex];
    
    NSString *category = [self categories][itemIndex];
}

- (void)didSelectAtItemIndex:(NSUInteger)itemIndex dataIndex:(NSUInteger)dataIndex;{
    [super didSelectAtItemIndex:itemIndex dataIndex:dataIndex];
 
    STSlideScaleTitleModel *slideScaleTitleModel = [self dataSource][itemIndex];
    id object = [slideScaleTitleModel dataSource][dataIndex];
}

#pragma mark - accessor

- (UIEdgeInsets)contentInset{
    return UIEdgeInsetsMake(0, 0, 44 + 5.5, 0);
}

- (UIView *)buttonsContentView{
    return [[[self titleView] scaleTitleView] rightContentView];
}

- (UIButton *)firstButton{
    if (!_firstButton) {
        _firstButton = [UIButton new];
        _firstButton.titleLabel.font = [UIFont systemFontOfSize:24];
        
        [_firstButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_firstButton setTitle:@"A" forState:UIControlStateNormal];
        [_firstButton addTarget:self action:@selector(didClickButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _firstButton;
}

- (UIButton *)secondButton{
    if (!_secondButton) {
        _secondButton = [UIButton new];
        _secondButton.titleLabel.font = [UIFont systemFontOfSize:24];
        
        [_secondButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_secondButton setTitle:@"B" forState:UIControlStateNormal];
        [_secondButton addTarget:self action:@selector(didClickButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _secondButton;
}

- (MMHorizontalListView *)horizontalListView{
    return [[[self titleView] segmentSelectorView] horizontalListView];
}

- (NSArray *)categories{
    if (!_categories) {
        _categories = @[];
    }
    return _categories;
}

- (NSArray *)dataSourceWithCategories:(NSArray *)categories;{
    NSMutableArray *dataSource = [NSMutableArray array];
    for (NSString * category in categories) {
        STSlideScaleTitleModel *model = [STSlideScaleTitleModel new];
        model.title = category;
        
        [dataSource addObject:model];
    }
    return dataSource;
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

#pragma mark - private

- (void)_installConstraints{
    
    [[self firstButton] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self.buttonsContentView);
        make.size.mas_equalTo(CGSizeMake(24, 20));
    }];
    
    [[self secondButton] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.firstButton.mas_right).offset(16);
        make.right.top.bottom.equalTo(self.buttonsContentView);
        make.size.mas_equalTo(CGSizeMake(24, 20));
    }];
}

- (void)_mockRemoteCategories{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self _handleRemoteCategories:@[@"分类", @"分类", @"分类", @"分类", @"分类"]];
    });
}

- (void)_handleRemoteCategories:(NSArray *)categories{
    self.categories = categories;
    
    [self _clearAndReloadData];
    [self _setupDefaultSelectSetting];
}

- (void)_mockDetailWithCategoryID:(NSString *)categoryID append:(BOOL)append currentPage:(NSInteger)currentPage completion:(void (^)(NSArray *dataSource, NSUInteger page, BOOL hasMore))completion{
    
    NSInteger page = append * currentPage + 1;
    dispatch_async(dispatch_get_main_queue(), ^{
        NSArray *objects = @[@"test", @"test", @"test", @"test", @"test", @"test", @"test", @"test", @"test", @"test"];
        
        completion(objects, page, append);
    });
}

- (void)_setupDefaultSelectSetting{
    
    self.currentIndex = 2;
}

- (void)_clearAndReloadData{
    self.dataSource = [self dataSourceWithCategories:[self categories]];
    
    [self reloadData];
}

#pragma mark - actions

- (IBAction)didClickButton:(id)sender{
}


@end
