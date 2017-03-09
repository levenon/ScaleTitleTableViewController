//
//  YRSegmentCollectionItemCell.m
//  pyyx
//
//  Created by xulinfeng on 2017/1/4.
//  Copyright © 2017年 Chunlin Ma. All rights reserved.
//

#import "YRSegmentCollectionItemCell.h"

@interface YRSegmentCollectionItemCell ()

@property (nonatomic, strong) UILabel *titleLabel;

@end


@implementation YRSegmentCollectionItemCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [self _createSubviews];
        [self _configurateSubviewsDefault];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.titleLabel.frame = [self bounds];
}

#pragma mark - accessor

- (void)setTitle:(NSString *)title{
    if (_title != title) {
        _title = title;
    }
    self.titleLabel.text = title;
}

- (void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    
    self.titleLabel.font = selected ? [UIFont boldSystemFontOfSize:15] : [UIFont boldSystemFontOfSize:15];
    self.titleLabel.textColor = self.isSelected ? [UIColor greenColor] : [UIColor whiteColor];
}

#pragma mark - private
- (void)_createSubviews{
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:self.titleLabel];
}

- (void)_configurateSubviewsDefault{
    
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
    
    self.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    self.titleLabel.adjustsFontSizeToFitWidth = YES;
    self.titleLabel.minimumScaleFactor = 0.5;
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.backgroundColor = [UIColor grayColor];
    self.titleLabel.layer.cornerRadius = 4;
    self.titleLabel.layer.masksToBounds = YES;
}

@end
