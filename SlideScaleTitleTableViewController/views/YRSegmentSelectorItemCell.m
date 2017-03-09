//
//  YRSegmentSelectorItemCell.m
//  pyyx
//
//  Created by xulinfeng on 2017/1/4.
//  Copyright © 2017年 Chunlin Ma. All rights reserved.
//

#import "YRSegmentSelectorItemCell.h"
#import <Masonry/Masonry.h>

@interface YRSegmentSelectorItemCell ()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation YRSegmentSelectorItemCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self _createSubviews];
        [self _configurateSubviewsDefault];
        [self _installConstraints];
    }
    return self;
}

#pragma mark - accessor

- (void)setTitle:(NSString *)title{
    if (_title != title) {
        _title = title;
    }
    [self _updateContentView];
}

- (NSString *)reusableIdentifier{
    return NSStringFromClass([self class]);
}

#pragma mark - private
- (void)_createSubviews{
    self.titleLabel = [UILabel new];
    [self addSubview:[self titleLabel]];
}

- (void)_configurateSubviewsDefault{
    self.titleLabel.font = [UIFont systemFontOfSize:14];
    self.titleLabel.textColor = [UIColor blackColor];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

- (void)_installConstraints{
    [[self titleLabel] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

- (void)_updateContentView{
    self.titleLabel.text = self.title;
    self.titleLabel.font = self.selected ? [UIFont boldSystemFontOfSize:15] : [UIFont systemFontOfSize:15];
    self.titleLabel.textColor = self.selected ? [UIColor greenColor] : [UIColor whiteColor];
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{
    [super setHighlighted:highlighted animated:animated];
    
    [self _updateContentView];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated{
    [super setSelected:selected animated:animated];
    
    [self _updateContentView];
}
- (void)setHighlighted:(BOOL)highlighted progress:(CGFloat)progress animated:(BOOL)animated;{
    [super setHighlighted:highlighted progress:progress animated:animated];
    
//    CGFloat red = (43.0f - 255.0f) * progress + 255.0f;
//    CGFloat green = (221.0f - 255.0f) * progress + 255.0f;
//    CGFloat blue = (115.0f - 255.0f) * progress + 255.0f;
//    CGFloat scale = progress * (2 / 22.) + 20 / 22. ;
    
//    self.titleLabel.textColor = [UIColor colorWithRGB:red green:green blue:blue alpha:1.f];
//    self.titleLabel.layer.transform = CATransform3DIdentity;
//    self.titleLabel.layer.transform = CATransform3DMakeScale(scale, scale, 1.f);
}

#pragma mark - public
+ (CGFloat)horizontalListView:(MMHorizontalListView *)horizontalListView widthWithTitle:(NSString *)title;{
    return [title sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:CGSizeMake(CGFLOAT_MAX, 21)].width + 2;
}

@end
