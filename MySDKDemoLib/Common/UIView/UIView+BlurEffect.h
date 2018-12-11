//
//  UIView+BlurEffect.h
//  KoalaGameStaticLib
//
//  Created by kaola  on 2018/8/20.
//  Copyright © 2018年    . All rights reserved.
// 毛玻璃效果

#import <UIKit/UIKit.h>

@interface UIView (BlurEffect)

/** 给view添加毛玻璃效果 + 蓝色边框  */
- (void)blurEffectWithStyle:(UIBlurEffectStyle)style;

@end
