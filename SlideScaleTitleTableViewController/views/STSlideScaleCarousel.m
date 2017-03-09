//
//  STSlideScaleCarousel.m
//  Marke Jave
//
//  Created by Marke Jave on 2017/2/10.
//  Copyright © 2017年 Chunlin Ma. All rights reserved.
//

#import "STSlideScaleCarousel.h"

@interface STSlideScaleCarousel ()

@property (nonatomic, strong) NSMutableDictionary *itemViews;

@end

@implementation STSlideScaleCarousel
@dynamic itemViews;

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [[self itemViews] enumerateKeysAndObjectsUsingBlock:^(id key, UIView *itemView, BOOL *stop) {
        itemView.superview.frame = [self bounds];
        itemView.frame = [self bounds];
    }];
}

@end
