//
//  UIColor+ColorChange.h
//  Tennis
//
//  Created by 李一贤 on 2018/7/17.
//  Copyright © 2018年 李一贤. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIColor (ColorChange)

//十六进制颜色（#开头）转RGB颜色
+ (UIColor *) colorWithHexString: (id)color;

@end
