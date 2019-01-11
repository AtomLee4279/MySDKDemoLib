//
//  UIColor+ColorChange.m
//  Tennis
//
//  Created by 李一贤 on 2018/7/17.
//  Copyright © 2018年 李一贤. All rights reserved.
//源代码参考
//作者：iOS_凯
//链接：https://www.jianshu.com/p/79e4dd8a44bc
//來源：简书
//简书著作权归作者所有，任何形式的转载都请联系作者获得授权并注明出处。

#import <UIKit/UIKit.h>
#import "UIColor+ColorChange.h"

@implementation UIColor (ColorChange)

//十六进制颜色（#开头）转RGB颜色
+ (UIColor *) colorWithHexString: (id)color{
    //若传入参数为十六进制，则转换为RGB颜色再返回
    if ([color isKindOfClass:[NSString class]]) {
        NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
        
        // String should be 6 or 8 characters
        if ([cString length] < 6) {
            return [UIColor clearColor];
        }
        // 判断前缀
        if ([cString hasPrefix:@"0X"])
            cString = [cString substringFromIndex:2];
        if ([cString hasPrefix:@"#"])
            cString = [cString substringFromIndex:1];
        if ([cString length] != 6)
            return [UIColor clearColor];
        // 从六位数值中找到RGB对应的位数并转换
        NSRange range;
        range.location = 0;
        range.length = 2;
        //R、G、B
        NSString *rString = [cString substringWithRange:range];
        range.location = 2;
        NSString *gString = [cString substringWithRange:range];
        range.location = 4;
        NSString *bString = [cString substringWithRange:range];
        // Scan values
        unsigned int r, g, b;
        [[NSScanner scannerWithString:rString] scanHexInt:&r];
        [[NSScanner scannerWithString:gString] scanHexInt:&g];
        [[NSScanner scannerWithString:bString] scanHexInt:&b];
        
        return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
    }
    //否则若传入参数已经是UIColor类对象（默认传入是orange），则直接返回
        return color;
    
}



@end
