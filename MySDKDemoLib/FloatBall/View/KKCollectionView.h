//
//  KKCollectionView.h
//  FloatBallDemo
//
//  Created by xiao on 2018/3/15.
//  Copyright © 2018年 kaola . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KKCollectionView : UICollectionView

@property(nonatomic, copy) void (^didSelectItemAtIndexPathAction)(KKCollectionView *view, NSInteger index);

+ (instancetype)collectionViewWithOrderLeft:(BOOL)orderLeft;

+ (CGSize)viewSizeWithModel:(id)model;


@end
