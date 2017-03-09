//
//  YRSegmentScaleTitleView.m
//  pyyx
//
//  Created by xulinfeng on 2017/1/3.
//  Copyright © 2017年 Chunlin Ma. All rights reserved.
//

#import "YRSegmentScaleTitleView.h"

const CGFloat YRSegmentSelectorViewHeight = 21 + 17;

@interface YRSegmentScaleTitleView ()

@property (nonatomic, strong) YRScaleTitleView *scaleTitleView;

@property (nonatomic, strong) YRSegmentSelectorView *segmentSelectorView;
@end

@implementation YRSegmentScaleTitleView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self _createSubviews];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGSize size = self.frame.size;
    self.scaleTitleView.frame = (CGRect){0, 0, size.width, size.height - YRSegmentSelectorViewHeight};
    self.segmentSelectorView.frame = CGRectMake(0, size.height - YRSegmentSelectorViewHeight, size.width, 21);
    
    self.scaleTitleView.alpha =(size.height - [self minHeight]) / ([self maxHeight] - [self minHeight]);
}

#pragma mark - accessor

- (void)setAutoresizing:(BOOL)autoresizing{
    self.scaleTitleView.autoresizing = autoresizing;
}

- (BOOL)autoresizing{
    return self.scaleTitleView.autoresizing;
}

- (void)setMinHeight:(CGFloat)minHeight{
    self.scaleTitleView.minHeight = minHeight - YRSegmentSelectorViewHeight;
}

- (CGFloat)minHeight{
    return self.scaleTitleView.minHeight + YRSegmentSelectorViewHeight;
}

- (void)setMaxHeight:(CGFloat)maxHeight{
    self.scaleTitleView.maxHeight = maxHeight - YRSegmentSelectorViewHeight;
}

- (CGFloat)maxHeight{
    return self.scaleTitleView.maxHeight + YRSegmentSelectorViewHeight;
}

#pragma mark - private

- (void)_createSubviews{
    
    CGSize size = self.frame.size;
    self.scaleTitleView = [[YRScaleTitleView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height - YRSegmentSelectorViewHeight)];
    self.segmentSelectorView = [[YRSegmentSelectorView alloc] initWithFrame:CGRectMake(0, size.height - YRSegmentSelectorViewHeight, size.width, 21)];
    
    [self addSubview:[self scaleTitleView]];
    [self addSubview:[self segmentSelectorView]];
}

@end
