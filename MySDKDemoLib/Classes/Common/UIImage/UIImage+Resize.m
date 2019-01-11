//
//  UIImage+FKResize.m
//  FoxGameKit
//
//  Created by shun on 2017/10/9.
//  Copyright © 2017年 shunbang. All rights reserved.
//

#import "UIImage+Resize.h"

@implementation UIImage (Resize)

- (instancetype)resizeWithResizeMode:(ResizeMode)resizeMode {
    
    CGFloat imgW = self.size.width;
    CGFloat imgH = self.size.height;
    CGFloat imgCenterX = imgW * .5;
    CGFloat imgCenterY = imgH * .5;
    
    UIEdgeInsets inset = UIEdgeInsetsZero;
    if (resizeMode == ResizeModeDefault) {
        
        // 水平/垂直都拉伸
        inset = UIEdgeInsetsMake(imgCenterY, imgCenterX, imgCenterY - 1, imgCenterX - 1);
    }
    else if (resizeMode == ResizeModeHorizontal) {
        // 水平拉伸
        inset = UIEdgeInsetsMake(0, imgCenterX, 0, imgCenterX - 1);
    }
    else if (resizeMode == ResizeModeVertical) {
        // 垂直拉伸
        inset = UIEdgeInsetsMake(imgCenterY, 0, imgCenterY - 1, 0);
    }
    
    return [self resizeWithCapInsets:inset];
}

- (instancetype)resizeWithCapInsets:(UIEdgeInsets)capInsets {
    
    
    return [self resizableImageWithCapInsets:capInsets resizingMode:UIImageResizingModeStretch];
}

@end
