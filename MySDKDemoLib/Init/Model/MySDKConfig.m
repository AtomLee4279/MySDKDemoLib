//
//  MySDKConfig.m
//  MySDKDemoKit
//
//  Created by 李一贤 on 2018/7/5.
//  Copyright © 2018年 李一贤. All rights reserved.
//

#import "MySDKConfig.h"
#import "NSString+UniqueStrings.h"


@interface MySDKConfig ()
//设备号；实际上上传的的是uuid
@property(copy, nonatomic) NSString *udid;

//设备平台1-andriod , 2-ios
@property(copy, nonatomic) NSString *device_type;

//sdk版本号 如：2.1
@property(copy, nonatomic) NSString *sdkver;

//pkver格式：channel_版本号(去小数点)_build号（去小数点）eg.qzsgIOS_101_12(权战三国，v1.0.1，build是1.2)
@property(copy, nonatomic) NSString *pkver;

//请求时间戳秒级10位
@property(copy, nonatomic) NSString *requestId;

//手机系统版本号，如11.2
@property(copy, nonatomic) NSString *systemver;

//idfa:客户端不能确保能获取得到。每次卸载重装都能确保值相同，用户重置还原系统/隐私里还原广告标识符之后，该值会改变；禁用了广告追踪之后，客户端将无法获取，实际拿到的将是一个虚假的默认值
@property(copy, nonatomic) NSString *idfa;

//IOS越狱机器，1未越狱，0越狱
@property(copy, nonatomic) NSString *iscrack;

//手机类型，如arm64，x86
@property(copy, nonatomic) NSString *phone_type;
//idfv:客户端能确保无论怎样都能获取得到。但是每次卸载重装之后都会不一样
@property(copy, nonatomic) NSString *idfv;

//后台需求：在初始化网络请求成功时返回的广告渠道号字段,传入此参数保存
@property(copy,nonatomic)  NSString *advchannel;

@end

@implementation MySDKConfig

//单例
+ (instancetype)shareInstance{
    static MySDKConfig *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //        instance = [super new];
        instance = [[self alloc]init];
    });
    return instance;
}

-(void)test{
    NSLog(@"");
    
}

#pragma mark -- Getter&Setter

- (NSString *)udid {
    
    if (_udid) {
        return _udid;
    }
    
    _udid = [NSString uuid];
    return _udid;
}

- (NSString *)device_type {
    
    if (_device_type) {
        return _device_type;
    }
    _device_type = @"2";
    return _device_type;
}

- (NSString *)sdkver {
    
    if (_sdkver) {
        return _sdkver;
    }
    
    _sdkver = [[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"] stringByAppendingFormat:@".1"];
    
    return _sdkver;
}

- (NSString *)pkver {
    
    if (_pkver) {
        return _pkver;
    }
    
    NSString *channelWithoutDots = [self.channel stringByReplacingOccurrencesOfString:@"." withString:@""];
    _pkver = [NSString stringWithFormat:@"%@_%@", channelWithoutDots ?: @"", [NSString cpUniqueVersionString] ?: @""];
    
    return _pkver;
}

- (NSString *)requestId {
    
    NSDate *datenow = [NSDate date];
    NSString *timeSp = [NSString stringWithFormat:@"%ld",(long)[datenow timeIntervalSince1970]];
    return timeSp;
}

- (NSString *)systemver {
    
    if (_systemver) {
        return _systemver;
    }
    
    UIDevice *device = [UIDevice currentDevice];
    _systemver = device.systemVersion;
    return _systemver;
}

- (NSString *)idfa {
    
    if (_idfa) {
        return _idfa;
    }
    
    _idfa = [NSString idfa];
    return _idfa;
}

- (NSString *)iscrack {
    
    if (_iscrack) {
        return _iscrack;
    }
    NSString *isJB = [NSString isJailBreak];
    _iscrack = [NSString stringWithFormat:@"%@", isJB.boolValue ? @"1" : @"0"];
    return _iscrack;
}

- (NSString *)phone_type {
    
    if (_phone_type) {
        return _phone_type;
    }
    _phone_type = [NSString currentDeviceModel];
    return _phone_type;
}

- (NSString *)idfv {
    
    if (_idfv) {
        return _idfv;
    }
    
    _idfv = [NSString idfv];
    return _idfv;
}

- (NSString *)advchannel{
    
    _advchannel = [NSString advchannel:NULL];
    return _advchannel;
}


@end
