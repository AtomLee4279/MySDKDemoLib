//
//  NSString+Sign.h
//  KoalaGameKit
//
//  Created by kaola  on 2018/3/6.
//  Copyright © 2018年 kaola . All rights reserved.
// 签名

#import <Foundation/Foundation.h>

@interface NSString (Sign)

/**
 获得签名后的字典
 
 @param parameters 待签的字典
 @param appKey 签名用的key
 @return 签名后的字典
 */
+ (NSDictionary *)signDictionaryWithParameters:(NSDictionary *)parameters appKey:(NSString *)appKey;


/**
 获得签名的字符串
 
 @param parameters 需要签名的字典
 @param appKey 签名的key
 @return 签过名的字符串
 */
+ (NSString *)signWithParameters:(NSDictionary *)parameters appKey:(NSString *)appKey;


+ (NSString *)md5:(NSString *)str;

@end
