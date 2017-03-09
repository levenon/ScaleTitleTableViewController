//
//  YRScaleTitleView.m
//  pyyx
//
//  Created by xulinfeng on 2017/1/3.
//  Copyright © 2017年 Chunlin Ma. All rights reserved.
//

#import "YRScaleTitleView.h"
#import <Masonry/Masonry.h>

@interface YRScaleTitleView ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *rightContentView;

@end

@implementation YRScaleTitleView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [self _createSubviews];
        [self _configurateSubviewsDefault];
        [self _installConstraints];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self _updateContentLayout];
}
#pragma mark - accessor

- (void)setAutoresizing:(BOOL)autoresizing{
    if (_autoresizing != autoresizing) {
        _autoresizing = autoresizing;
        
        [self layoutIfNeeded];
    }
}

- (void)setMinHeight:(CGFloat)minHeight{
    if (_minHeight != minHeight){
        _minHeight = minHeight;
        
        [self layoutIfNeeded];
    }
}

- (void)setMaxHeight:(CGFloat)maxHeight{
    if (_maxHeight != maxHeight) {
        _maxHeight = maxHeight;

        [self layoutIfNeeded];
    }
}

#pragma mark - private

- (void)_createSubviews{
    self.titleLabel = [UILabel new];
    self.rightContentView = [UIView new];
    
    [self addSubview:[self titleLabel]];
    [self addSubview:[self rightContentView]];
}

- (void)_configurateSubviewsDefault{
    
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.font = [UIFont boldSystemFontOfSize:36];
    self.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
}

- (void)_installConstraints{
    
    [[self titleLabel] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(16);
        make.bottom.equalTo(self).offset(-11);
        make.height.mas_equalTo(50);
    }];
    
    [[self rightContentView] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-16);
        make.centerY.equalTo(self.titleLabel);
    }];
}

- (void)_updateContentLayout{
    
    CGFloat height = CGRectGetHeight([self bounds]);
    self.titleLabel.layer.transform = CATransform3DIdentity;
    
    if ([self autoresizing]) {
        height = MIN(height, [self maxHeight]);
        height = MAX(height, [self minHeight]);
        CGFloat scale = height / [self maxHeight];
        self.titleLabel.layer.transform = CATransform3DMakeScale(scale, scale, 1.f);
    } else {
        CGRect frame = [self frame];
        self.frame = (CGRect){frame.origin, frame.size.width, [self maxHeight]};
        
        self.titleLabel.layer.transform = CATransform3DIdentity;
    }
}

@end
