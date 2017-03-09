//
//  YRSegmentCollectionSelectorView.h
//  pyyx
//
//  Created by xulinfeng on 2017/1/4.
//  Copyright © 2017年 Chunlin Ma. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YRSegmentCollectionSelectorView;

@protocol YRSegmentCollectionSelectorViewDataSource <NSObject>

@required
- (NSUInteger)numberOfItemsInSelectorView:(YRSegmentCollectionSelectorView *)selectorView;
- (void)selectorView:(YRSegmentCollectionSelectorView *)selectorView configurateCellAtIndex:(NSUInteger)index cell:(UICollectionViewCell *)cell;

@end

@protocol YRSegmentCollectionSelectorViewDelegate <NSObject>
@optional

- (void)selectorView:(YRSegmentCollectionSelectorView *)selectorView didSelectRowAtIndex:(NSUInteger)index;
- (void)selectorView:(YRSegmentCollectionSelectorView *)selectorView didDeselectRowAtIndex:(NSUInteger)index;
- (void)didCancelInSelectorView:(YRSegmentCollectionSelectorView *)selectorView;

@end

@interface YRSegmentCollectionSelectorView : UIView

@property (nonatomic, assign) CGSize expendItemSize;
@property (nonatomic, assign, readonly) NSUInteger selectedIndex;
@property (nonatomic, weak) id<YRSegmentCollectionSelectorViewDelegate> delegate;
@property (nonatomic, weak) id<YRSegmentCollectionSelectorViewDataSource> dataSource;

- (instancetype)initWithSelectedIndex:(NSUInteger)selectedIndex;

- (void)registerClass:(Class)cellClass forCellWithReuseIdentifier:(NSString *)identifier;

- (void)reloadData;

- (void)expend:(BOOL)expend animated:(BOOL)animated completion:(void (^)())completion;

@end
