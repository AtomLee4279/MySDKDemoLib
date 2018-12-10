//
//  KKFloatCollectView.h
//  FloatBallDemo
//
//  Created by xiao on 2018/3/15.
//  Copyright © 2018年 kaola . All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, KKFloatItemActionTag) {
    
    KKFloatItemActionTagUserCenter, // 个人中心
    KKFloatItemActionTagService,    // 客服
    KKFloatItemActionTagStrategy,   // 攻略
    KKFloatItemActionTagPlatform,   // 平台
    KKFloatItemActionTagHide,       // 隐藏
};

/** 悬浮球按钮模型，为了偷懒直接写在这里了~  */
@interface KKFloatItem : NSObject

@property(nonatomic, strong) UIImage *icon;
@property(nonatomic, strong) UIImage *highlightIcon; // 高亮时候的图片
@property(nonatomic, assign) KKFloatItemActionTag actionTag;

+ (instancetype)floatItemWithIcon:(UIImage *)icon highlightIcon:(UIImage *)highlightIcon actionTag:(KKFloatItemActionTag)actionTag;

@end

@interface KKFloatCollectView : UICollectionView

/** 每个item被点击事件的处理 */
@property(nonatomic, copy) void (^didSelectItemAtIndexPathAction)(KKFloatCollectView *view, NSInteger index, UIButton *btn);

/** 悬浮球的模型数组 */
@property(nonatomic, strong) NSArray<KKFloatItem *> *floatItems;

+ (instancetype)collectionViewWithOrderLeft:(BOOL)orderLeft floatItems:(NSArray<KKFloatItem *> *)floatItems;

+ (CGSize)viewSizeWithModel:(NSArray<KKFloatItem *> *)model;

@end
