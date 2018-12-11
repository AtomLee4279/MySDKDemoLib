//
//  NSString+UniqueStrings.h
//  KoalaGameKit
//
//  Created by kaola  on 2018/3/6.
//  Copyright © 2018年 kaola . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSString (UniqueStrings)

+ (NSString *)uuid;

+ (NSString *)idfa;

+ (NSString *)idfv;

+ (NSString *)systeminfo;

+ (NSString *)currentDeviceModel;

+ (NSString *)stringFromBase64String:(NSString *)base64String;

//后台需求：在初始化网络请求成功时返回的广告渠道号字段,传入此参数保存
+ (NSString *)advchannel:(NSString* _Nullable)arg;

/** 获取标示当前游戏包一个字符串
 生成规则：游戏的版本号（去小数点）+ 连接符号（“_”） + 游戏build版本号（去小数点）；
 */
+ (NSString *)cpUniqueVersionString;


/**
 是否越狱
 
 @return 越狱为1，否则为0
 */
+ (NSString *)isJailBreak;


/**
 时间戳

 @return 时间戳
 */
+ (NSString *)timestramp;


/** W X: */
+ (NSString *)kk_winxinzfString;


/** A L: */
+ (NSString *)kk_alipayzfString;

+ (NSString *)kk_stringFromBase64String:(NSString *)base64String;

@end
