//
//  YRSlideScaleCarousel.m
//  pyyx
//
//  Created by xulinfeng on 2017/2/10.
//  Copyright © 2017年 Chunlin Ma. All rights reserved.
//

#import "YRSlideScaleCarousel.h"

@interface YRSlideScaleCarousel ()

@property (nonatomic, strong) NSMutableDictionary *itemViews;

@end

@implementation YRSlideScaleCarousel
@dynamic itemViews;

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [[self itemViews] enumerateKeysAndObjectsUsingBlock:^(id key, UIView *itemView, BOOL *stop) {
        itemView.superview.frame = [self bounds];
        itemView.frame = [self bounds];
    }];
}

@end
