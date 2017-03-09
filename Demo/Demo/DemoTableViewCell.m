//
//  DemoTableViewCell.m
//  Demo
//
//  Created by Marke Jave on 2017/3/9.
//  Copyright © 2017年 Marke Jave. All rights reserved.
//

#import "DemoTableViewCell.h"
#import <Masonry/Masonry.h>

@implementation DemoTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        
        UIView *backgroundView = [UIView new];
        backgroundView.backgroundColor = [UIColor whiteColor];
        backgroundView.layer.cornerRadius = 10;
        
        [[self contentView] addSubview:backgroundView];
        [backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(20, 20, 20, 20));
        }];
    }
    return self;
}

@end
