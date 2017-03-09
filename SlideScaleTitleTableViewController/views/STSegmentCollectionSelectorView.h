//
//  STSegmentCollectionSelectorView.h
//  Marke Jave
//
//  Created by Marke Jave on 2017/1/4.
//  Copyright © 2017年 Chunlin Ma. All rights reserved.
//

#import <UIKit/UIKit.h>

@class STSegmentCollectionSelectorView;

@protocol STSegmentCollectionSelectorViewDataSource <NSObject>

@required
- (NSUInteger)numberOfItemsInSelectorView:(STSegmentCollectionSelectorView *)selectorView;
- (void)selectorView:(STSegmentCollectionSelectorView *)selectorView configurateCellAtIndex:(NSUInteger)index cell:(UICollectionViewCell *)cell;

@end

@protocol STSegmentCollectionSelectorViewDelegate <NSObject>
@optional

- (void)selectorView:(STSegmentCollectionSelectorView *)selectorView didSelectRowAtIndex:(NSUInteger)index;
- (void)selectorView:(STSegmentCollectionSelectorView *)selectorView didDeselectRowAtIndex:(NSUInteger)index;
- (void)didCancelInSelectorView:(STSegmentCollectionSelectorView *)selectorView;

@end

@interface STSegmentCollectionSelectorView : UIView

@property (nonatomic, assign) CGSize expendItemSize;
@property (nonatomic, assign, readonly) NSUInteger selectedIndex;
@property (nonatomic, weak) id<STSegmentCollectionSelectorViewDelegate> delegate;
@property (nonatomic, weak) id<STSegmentCollectionSelectorViewDataSource> dataSource;

- (instancetype)initWithSelectedIndex:(NSUInteger)selectedIndex;

- (void)registerClass:(Class)cellClass forCellWithReuseIdentifier:(NSString *)identifier;

- (void)reloadData;

- (void)expend:(BOOL)expend animated:(BOOL)animated completion:(void (^)())completion;

@end
