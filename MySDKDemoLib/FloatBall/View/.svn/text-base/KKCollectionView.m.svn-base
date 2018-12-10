//
//  KKCollectionView.m
//  FloatBallDemo
//
//  Created by xiao on 2018/3/15.
//  Copyright © 2018年 kaola . All rights reserved.
//

#import "KKCollectionView.h"

static CGFloat itemWidth = 44.f;
static CGFloat itemHeight = 44.f;

@interface KKCollectionView () <UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate>

@property(nonatomic, assign) BOOL isOrderLeft;

@end

@implementation KKCollectionView

+ (instancetype)collectionViewWithOrderLeft:(BOOL)orderLeft {
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.itemSize = CGSizeMake(itemWidth, itemHeight);
    
    KKCollectionView *instance = [[self alloc] initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:layout];
    instance.bounces = NO;
    instance.dataSource = instance;
    instance.delegate = instance;
    instance.isOrderLeft = orderLeft;
    
    [instance setupSelf];
    
    return instance;
}

- (void)setupSelf {
    
    [self registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
}

+ (CGSize)viewSizeWithModel:(id)model {
    
    return CGSizeMake(itemWidth * 3 + 1, itemHeight);
}

#pragma mark - <UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 3;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *item = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
    if (indexPath.item * 2) {
        item.backgroundColor = [UIColor redColor];
    }
    else {
        
        item.backgroundColor = [UIColor brownColor];
    }
    
    return item;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.didSelectItemAtIndexPathAction) {
        self.didSelectItemAtIndexPathAction(self, indexPath.item);
    }
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    
    return CGFLOAT_MIN;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    
    return CGFLOAT_MIN;
}


@end
