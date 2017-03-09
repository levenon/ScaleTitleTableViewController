//
//  STSegmentScaleTitleView.m
//  Marke Jave
//
//  Created by Marke Jave on 2017/1/3.
//  Copyright © 2017年 Marke Jave. All rights reserved.
//

#import "STSegmentScaleTitleView.h"

const CGFloat STSegmentSelectorViewHeight = 21 + 17;

@interface STSegmentScaleTitleView ()

@property (nonatomic, strong) STScaleTitleView *scaleTitleView;

@property (nonatomic, strong) STSegmentSelectorView *segmentSelectorView;
@end

@implementation STSegmentScaleTitleView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self _createSubviews];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGSize size = self.frame.size;
    self.scaleTitleView.frame = (CGRect){0, 0, size.width, size.height - STSegmentSelectorViewHeight};
    self.segmentSelectorView.frame = CGRectMake(0, size.height - STSegmentSelectorViewHeight, size.width, 21);
    
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
    self.scaleTitleView.minHeight = minHeight - STSegmentSelectorViewHeight;
}

- (CGFloat)minHeight{
    return self.scaleTitleView.minHeight + STSegmentSelectorViewHeight;
}

- (void)setMaxHeight:(CGFloat)maxHeight{
    self.scaleTitleView.maxHeight = maxHeight - STSegmentSelectorViewHeight;
}

- (CGFloat)maxHeight{
    return self.scaleTitleView.maxHeight + STSegmentSelectorViewHeight;
}

#pragma mark - private

- (void)_createSubviews{
    
    CGSize size = self.frame.size;
    self.scaleTitleView = [[STScaleTitleView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height - STSegmentSelectorViewHeight)];
    self.segmentSelectorView = [[STSegmentSelectorView alloc] initWithFrame:CGRectMake(0, size.height - STSegmentSelectorViewHeight, size.width, 21)];
    
    [self addSubview:[self scaleTitleView]];
    [self addSubview:[self segmentSelectorView]];
}

@end
