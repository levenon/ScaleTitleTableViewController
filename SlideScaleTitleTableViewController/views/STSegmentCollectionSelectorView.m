//
//  STSegmentCollectionSelectorView.m
//  Marke Jave
//
//  Created by Marke Jave on 2017/1/4.
//  Copyright © 2017年 Chunlin Ma. All rights reserved.
//

#import "STSegmentCollectionSelectorView.h"
#import <Masonry/Masonry.h>

@interface STSegmentCollectionSelectorView ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, assign) NSUInteger selectedIndex;
@property (nonatomic, strong) NSMutableDictionary<NSString *, Class> *reusableCellClasses;
@property (nonatomic, assign) NSInteger numberOfItems;

@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIButton *arrowButton;

@property (nonatomic, assign, readonly) CGFloat collectionViewHeight;
@property (nonatomic, strong, readonly) UICollectionViewLayout *collectionViewLayout;

@end

@implementation STSegmentCollectionSelectorView

- (instancetype)initWithSelectedIndex:(NSUInteger)selectedIndex{
    if (self = [super init]) {
        self.selectedIndex = selectedIndex;
        
        [self _creatSubviews];
        [self _configurateSubviewDefault];
        [self _installConstraints];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.selectedIndex = 0;
        
        [self _creatSubviews];
    }
    return self;
}

#pragma mark - accessor

- (UICollectionViewLayout *)collectionViewLayout{
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = self.expendItemSize;
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.minimumLineSpacing = 6;
    layout.minimumInteritemSpacing = 6;
    return layout;
}

- (CGFloat)collectionViewHeight{
    
    NSInteger columns = (CGRectGetWidth([self bounds]) - 26) / ([self expendItemSize].width + 6);
    NSInteger rows = self.numberOfItems / columns + (self.numberOfItems % columns != 0);
    
    return rows * self.expendItemSize.height + (rows - 1) * 6;
}

#pragma mark - private

- (void)_creatSubviews{
    self.reusableCellClasses = [NSMutableDictionary dictionary];
    
    self.backgroundView = [UIView new];
    self.contentView = [UIView new];
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:[self collectionViewLayout]];
    self.arrowButton = [UIButton new];

    [self addSubview:[self backgroundView]];
    [self addSubview:[self contentView]];
    [self addSubview:[self collectionView]];
    [self addSubview:[self arrowButton]];
}

- (void)_configurateSubviewDefault{
    
    self.layer.masksToBounds = YES;
    
    self.backgroundView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
    [[self backgroundView] addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClickBackgroundView:)]];
    
    self.contentView.backgroundColor = [UIColor colorWithRed:7/255. green:18/255. blue:71/255. alpha:1];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor clearColor];
    
    [[self collectionView] registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([UICollectionViewCell class])];
    
    [[self arrowButton] setImage:[UIImage imageNamed:@"img_category_up_arrow"] forState:UIControlStateNormal];
    [[self arrowButton] addTarget:self action:@selector(didClickArrowButton:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)_installConstraints{
    
    [[self backgroundView] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [[self collectionView] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(16);
        make.right.equalTo(self.contentView).offset(-16);
        make.top.equalTo(self.contentView).offset(8);
    }];
    
    [[self arrowButton] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.top.equalTo(self.collectionView.mas_bottom).offset(8);
        make.bottom.equalTo(self.contentView).offset(-10);
        make.height.mas_equalTo(6);
    }];
    
    [self _updateHiddenContentConstraints];
}

- (void)_updateDisplayContentConstraints{
    CGFloat contentHeight = [self collectionViewHeight] + 8 + 24;
    
    [[self contentView] mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self);
        make.height.mas_equalTo(contentHeight);
    }];
}

- (void)_updateHiddenContentConstraints{
    CGFloat contentHeight = [self collectionViewHeight] + 8 + 24;
    
    [[self contentView] mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self).offset(-contentHeight);
        make.height.mas_equalTo(contentHeight);
    }];
}

- (void)_cancel{
    if ([self delegate] && [[self delegate] respondsToSelector:@selector(didCancelInSelectorView:)]) {
        [[self delegate] didCancelInSelectorView:self];
    }
}

#pragma mark - UICollectionViewDelegate and UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.numberOfItems;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[[[self reusableCellClasses] allKeys] firstObject] forIndexPath:indexPath];
    [[self dataSource] selectorView:self configurateCellAtIndex:[indexPath row] cell:cell];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if ([self delegate] && [[self delegate] respondsToSelector:@selector(selectorView:didSelectRowAtIndex:)]) {
        [[self delegate] selectorView:self didSelectRowAtIndex:[indexPath row]];
    }
    
    self.selectedIndex = [indexPath row];
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    if ([self delegate] && [[self delegate] respondsToSelector:@selector(selectorView:didDeselectRowAtIndex:)]) {
        [[self delegate] selectorView:self didDeselectRowAtIndex:[indexPath row]];
    }
}

#pragma mark public

- (void)reloadData{
    if (self.dataSource == nil) {
        return;
    }
    self.numberOfItems = [self.dataSource numberOfItemsInSelectorView:self];
    self.collectionView.collectionViewLayout = [self collectionViewLayout];
    
    [[self collectionView] reloadData];
    if ([self selectedIndex] < [self numberOfItems]) {
        [[self collectionView] selectItemAtIndexPath:[NSIndexPath indexPathForRow:[self selectedIndex] inSection:0] animated:YES scrollPosition:UICollectionViewScrollPositionNone];
    }
}

- (void)registerClass:(Class)cellClass forCellWithReuseIdentifier:(NSString *)identifier{
    self.reusableCellClasses[identifier] = cellClass;
    
    [[self collectionView] registerClass:cellClass forCellWithReuseIdentifier:identifier];
}

- (void)expend:(BOOL)expend animated:(BOOL)animated completion:(void (^)())completion;{
    if (expend) {
        [self _updateHiddenContentConstraints];
    }
    [self layoutIfNeeded];
    void (^transform)() = ^{
        if (expend) {
            [self _updateDisplayContentConstraints];
        } else {
            [self _updateHiddenContentConstraints];
        }
        [self layoutIfNeeded];
    };
    void (^transformCompletion)(BOOL finished) = ^(BOOL finished){
        if (completion) {
            completion();
        }
    };
    if (animated) {
        [UIView animateWithDuration:0.15 animations:transform completion:transformCompletion];
    } else {
        transform();
        transformCompletion(YES);
    }
}

#pragma mark action

- (IBAction)didClickBackgroundView:(UITapGestureRecognizer *)tapGestureRecognizer{
    [self _cancel];
}

- (IBAction)didClickArrowButton:(id)sender{
    [self _cancel];
}

@end
