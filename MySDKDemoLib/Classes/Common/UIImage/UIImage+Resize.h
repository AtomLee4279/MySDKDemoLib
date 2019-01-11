//
//  UIImage+Resize.h
//  FoxGameKit
//
//  Created by shun on 2017/10/9.
//  Copyright © 2017年 shunbang. All rights reserved.
// 返回resize的图片

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, ResizeMode) {
    ResizeModeDefault,    // 水平方向和垂直方向都拉伸
    ResizeModeHorizontal, //水平方向
    ResizeModeVertical,   //垂直方向
};

@interface UIImage (Resize)

- (instancetype)resizeWithResizeMode:(ResizeMode)resizeMode;

@end
