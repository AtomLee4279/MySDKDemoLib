//
//  UIView+BlurEffect.m
//  KoalaGameStaticLib
//
//  Created by kaola  on 2018/8/20.
//  Copyright © 2018年    . All rights reserved.
//

#import "UIView+BlurEffect.h"
#import "UIImage+Resize.h"

@implementation UIView (BlurEffect)

/** 给view添加毛玻璃效果  */
- (void)blurEffectWithStyle:(UIBlurEffectStyle)style {
    
    weakSelf();
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:style];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    [self addSubview:effectView];
    [effectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf);
    }];
    
    // 蓝色边框
    UIImageView *bgView = [[UIImageView alloc] init];
    [self addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf);
    }];
    
    bgView.image = [res_bg_image resizeWithResizeMode:ResizeModeDefault];
}

@end
