//
//  UIButton+KKWebCache.h
//  KoalaGameKit
//
//  Created by kaola  on 2018/4/17.
//  Copyright © 2018年 kaola . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (KKWebCache)

/**
 给btn设置url image
 
 @param urlString url string
 @param state state
 @param placeholder 占位图
 */
- (void)kk_setImageWithURLString:(nullable NSString *)urlString
                        forState:(UIControlState)state
                placeholderImage:(nullable UIImage *)placeholder;


/**
 给btn bg设置url image
 
 @param urlString url string
 @param state state
 @param placeholder 占位图
 */
- (void)kk_setBackgroundImageWithURLString:(nullable NSString *)urlString
                                  forState:(UIControlState)state
                          placeholderImage:(nullable UIImage *)placeholder;

@end
