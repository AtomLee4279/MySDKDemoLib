//
//  NSString+UniqueStrings.m
//  KoalaGameKit
//
//  Created by kaola  on 2018/3/6.
//  Copyright © 2018年 kaola . All rights reserved.
//

#import "NSString+UniqueStrings.h"
#import <AdSupport/AdSupport.h>
#import <sys/socket.h> // Per msqr
#import <sys/sysctl.h>
#import <net/if.h>
#import <net/if_dl.h>

#define ARRAY_SIZE(a) sizeof(a)/sizeof(a[0])
#define USER_APP_PATH @"/User/Applications/"

@implementation NSString (UniqueStrings)

+ (NSString *)uuid {
    
    NSString *udid = [[NSUserDefaults standardUserDefaults] objectForKey:@"jimiudid"];
    if (udid && ![udid isEqualToString:@""])
    {
        return udid;
    }
    CFUUIDRef puuid = CFUUIDCreate( nil );
    CFStringRef uuidString = CFUUIDCreateString( nil, puuid );
    NSString * result = (NSString *)CFBridgingRelease(CFStringCreateCopy( NULL, uuidString));
    [[NSUserDefaults standardUserDefaults] setObject:result forKey:@"jimiudid"];
    CFRelease(puuid);
    CFRelease(uuidString);
    return result;
}

+ (NSString *)idfa {
    
    NSString *idfa = [[NSUserDefaults standardUserDefaults] objectForKey:@"jimiidfa"];
    if (idfa && ![idfa isEqualToString:@""])
    {
        return idfa;
    }
    NSString *result = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    [[NSUserDefaults standardUserDefaults] setObject:result forKey:@"jimiidfa"];
    return result;
}


+ (NSString *)idfv {
    
    NSString *idfv = [[NSUserDefaults standardUserDefaults] objectForKey:@"jimiidfv"];
    if (idfv && ![idfv isEqualToString:@""])
    {
        return idfv;
    }
    NSString *result = [UIDevice currentDevice].identifierForVendor.UUIDString;
    [[NSUserDefaults standardUserDefaults] setObject:result forKey:@"jimiidfv"];
    return result;
}

+ (NSString *)systeminfo {
    
    NSString *systeminfo = [[NSUserDefaults standardUserDefaults] objectForKey:@"jimisysteminfo"];
    if (systeminfo && ![systeminfo isEqualToString:@""])
    {
        return systeminfo;
    }
    NSString *result = [NSString stringWithFormat:@"%@%@",[UIDevice currentDevice].systemName,[UIDevice currentDevice].systemVersion];
    [[NSUserDefaults standardUserDefaults] setObject:result forKey:@"jimisysteminfo"];
    return result;
}

//后台需求：在初始化网络请求成功时返回的广告渠道号字段,传入此参数保存
+ (NSString *)advchannel:(NSString* _Nullable)arg {
    
    // 从本地取值
    NSString *advchannel = [[NSUserDefaults standardUserDefaults] objectForKey:@"advchannel"];
    advchannel = advchannel ?: @"";
    
    // advchannel有值，且跟原来的值不同才会覆盖
    if (arg.length&&![arg isEqualToString:advchannel]){
        advchannel = arg;
        [[NSUserDefaults standardUserDefaults] setObject:arg forKey:@"advchannel"];
    }
    
    return advchannel;
}

static const char encodingTable[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";

+ (NSString *)stringFromBase64String:(NSString *)base64String {
    
    if (base64String && ![base64String isEqualToString:@""]) {
        //取项目的bundleIdentifier作为KEY   改动了此处
        //NSString *key = [[NSBundle mainBundle] bundleIdentifier];
        NSData *data = [self dataWithBase64EncodedString:base64String];
        //IOS 自带DES解密 Begin    改动了此处
        //data = [self DESDecrypt:data WithKey:key];
        //IOS 自带DES加密 End
        return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    else {
        return @"";
    }
}

/******************************************************************************
 函数名称 : + (NSData *)dataWithBase64EncodedString:(NSString *)string
 函数描述 : base64格式字符串转换为文本数据
 输入参数 : (NSString *)string
 输出参数 : N/A
 返回参数 : (NSData *)
 备注信息 :
 ******************************************************************************/
+ (NSData *)dataWithBase64EncodedString:(NSString *)string
{
    if (string == nil)
        [NSException raise:NSInvalidArgumentException format:nil];
    if ([string length] == 0)
        return [NSData data];
    
    static char *decodingTable = NULL;
    if (decodingTable == NULL)
    {
        decodingTable = malloc(256);
        if (decodingTable == NULL)
            return nil;
        memset(decodingTable, CHAR_MAX, 256);
        NSUInteger i;
        for (i = 0; i < 64; i++)
            decodingTable[(short)encodingTable[i]] = i;
    }
    
    const char *characters = [string cStringUsingEncoding:NSASCIIStringEncoding];
    if (characters == NULL)     //  Not an ASCII string!
        return nil;
    char *bytes = malloc((([string length] + 3) / 4) * 3);
    if (bytes == NULL)
        return nil;
    NSUInteger length = 0;
    
    NSUInteger i = 0;
    while (YES)
    {
        char buffer[4];
        short bufferLength;
        for (bufferLength = 0; bufferLength < 4; i++)
        {
            if (characters[i] == '\0')
                break;
            if (isspace(characters[i]) || characters[i] == '=')
                continue;
            buffer[bufferLength] = decodingTable[(short)characters[i]];
            if (buffer[bufferLength++] == CHAR_MAX)      //  Illegal character!
            {
                free(bytes);
                return nil;
            }
        }
        
        if (bufferLength == 0)
            break;
        if (bufferLength == 1)      //  At least two characters are needed to produce one byte!
        {
            free(bytes);
            return nil;
        }
        
        //  Decode the characters in the buffer to bytes.
        bytes[length++] = (buffer[0] << 2) | (buffer[1] >> 4);
        if (bufferLength > 2)
            bytes[length++] = (buffer[1] << 4) | (buffer[2] >> 2);
        if (bufferLength > 3)
            bytes[length++] = (buffer[2] << 6) | buffer[3];
    }
    
    bytes = realloc(bytes, length);
    return [NSData dataWithBytesNoCopy:bytes length:length];
}

+ (NSString *)currentDeviceModel {
    
    int mib[2];
    size_t len;
    char *machine;
    
    mib[0] = CTL_HW;
    mib[1] = HW_MACHINE;
    sysctl(mib, 2, NULL, &len, NULL, 0);
    machine = malloc(len);
    sysctl(mib, 2, machine, &len, NULL, 0);
    
    NSString *platform = [NSString stringWithCString:machine encoding:NSASCIIStringEncoding];
    free(machine);
    return platform;
}


/** 获取标示当前游戏包一个字符串
 生成规则：游戏的版本号（去小数点）+ 连接符号（“_”） + 游戏build版本号（去小数点）；
 */
+ (NSString *)cpUniqueVersionString {
    
    NSMutableString *verM = [NSMutableString string];
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    // 游戏名称
//    NSString *gameName = infoDictionary[@"CFBundleDisplayName"];
//    [verM appendFormat:@"%@_", [gameName stringWithoutDots] ?: @""];
    
    // 版本号
    NSString *shortVer = infoDictionary[@"CFBundleShortVersionString"];
    [verM appendFormat:@"%@_",  [shortVer stringWithoutDots] ?: @""];
    
    // build
    NSString *buildVer = infoDictionary[@"CFBundleVersion"];
    [verM appendFormat:@"%@",  [buildVer stringWithoutDots] ?: @""];
    
    return verM;
}


- (NSString *)stringWithoutDots {
    
    return [self stringByReplacingOccurrencesOfString:@"." withString:@""];
}

const char* jailbreak_tool_pathes[] = {
    "/Applications/Cydia.app",
    "/Library/MobileSubstrate/MobileSubstrate.dylib",
    "/bin/bash",
    "/usr/sbin/sshd",
    "/etc/apt"
};

char* printEnv(void)
{
    char *env = getenv("DYLD_INSERT_LIBRARIES");
    return env;
}


/**
 是否越狱

 @return 越狱为1，否则为0
 */
+ (NSString *)isJailBreak
{
    for (int i=0; i<ARRAY_SIZE(jailbreak_tool_pathes); i++) {
        if ([[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithUTF8String:jailbreak_tool_pathes[i]]]) {
            //            NSLog(@"The device is jail broken!");
            return @"1";
        }
    }
    // 判断cydia的URL scheme URL scheme是可以用来在应用中呼出另一个应用，是一个资源的路径，这个方法也就是在判定是否存在cydia这个应用。
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"cydia://"]]) {
        return @"1";
    }
    //读取系统所有应用的名称 这个是利用不越狱的机器没有这个权限来判定的
    if ([[NSFileManager defaultManager] fileExistsAtPath:USER_APP_PATH]) {
        return @"1";
    }
    //读取环境变量 这个DYLD_INSERT_LIBRARIES环境变量，在非越狱的机器上应该是空，越狱的机器上基本都会有Library/MobileSubstrate/MobileSubstrate.dylib
    if (printEnv()) {
        return @"1";
    }
    //    NSLog(@"The device is NOT jail broken!");
    return @"0";
}

/**
 时间戳
 
 @return 时间戳
 */
+ (NSString *)timestramp {
    
    NSDate *datenow = [NSDate date];
    NSString *timeSp = [NSString stringWithFormat:@"%ld",(long)[datenow timeIntervalSince1970]];
    return timeSp;
}

/** W X: */
+ (NSString *)kk_winxinzfString {
    
    NSData *decodedData = [[NSData alloc] initWithBase64EncodedString:@"d2VpeGluOg==" options:0];
    NSString *decodedString = [[NSString alloc] initWithData:decodedData encoding:NSUTF8StringEncoding];
    
    return decodedString;
}

/** A L: */
+ (NSString *)kk_alipayzfString {
    
    NSData *decodedData = [[NSData alloc] initWithBase64EncodedString:@"YWxpcGF5Og==" options:0];
    NSString *decodedString = [[NSString alloc] initWithData:decodedData encoding:NSUTF8StringEncoding];
    
    return decodedString;
}

+ (NSString *)kk_stringFromBase64String:(NSString *)base64String {
    
    NSData *decodedData = [[NSData alloc] initWithBase64EncodedString:base64String options:0];
    NSString *decodedString = [[NSString alloc] initWithData:decodedData encoding:NSUTF8StringEncoding];
    
    return decodedString;
}

@end
