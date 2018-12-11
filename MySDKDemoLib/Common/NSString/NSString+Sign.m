//
//  NSString+Sign.m
//  KoalaGameKit
//
//  Created by kaola  on 2018/3/6.
//  Copyright © 2018年 kaola . All rights reserved.
//

#import "NSString+Sign.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (Sign)


/**
 获得签名后的字典

 @param parameters 待签的字典
 @param appKey 签名用的key
 @return 签名后的字典
 */
+ (NSDictionary *)signDictionaryWithParameters:(NSDictionary *)parameters appKey:(NSString *)appKey {
    
    NSMutableDictionary *dictM = [NSMutableDictionary dictionaryWithDictionary:parameters];
    [dictM setObject:[self signWithParameters:parameters appKey:appKey] forKey:@"sign"];
    return dictM;
}


/**
 获得签名的字符串

 @param parameters 需要签名的字典
 @param appKey 签名的key
 @return 签过名的字符串
 */
+ (NSString *)signWithParameters:(NSDictionary *)parameters appKey:(NSString *)appKey {
    
    //字母排序
    NSArray *sections=[[parameters allKeys] sortedArrayUsingSelector:@selector(compare:)];
    
    NSMutableString *paramerStr = [NSMutableString string];
    
    NSMutableString *valueStr = [NSMutableString string];
    
    for (NSString *key in sections)
    {
        NSString *value = [parameters objectForKey:key];
        NSString *keyAndValue = [NSString stringWithFormat:@"%@=%@&",key,value];
        [valueStr appendString:value];
        [paramerStr appendString:keyAndValue];
    }
    [valueStr appendString: appKey];
    // 这里加了个%编码，反而不对了；去掉%编码可以。。
//    NSString *encodeStr = [valueStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    return [self md5:valueStr];
}

+ (NSString *)md5:(NSString *)str {
    const char *cStr = [str UTF8String];
    unsigned char result[32];
    CC_MD5( cStr, (unsigned)strlen(cStr), result );
    return [[NSString stringWithFormat:
             @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             result[0], result[1], result[2], result[3],
             result[4], result[5], result[6], result[7],
             result[8], result[9], result[10], result[11],
             result[12], result[13], result[14], result[15]] lowercaseString];
}

@end
