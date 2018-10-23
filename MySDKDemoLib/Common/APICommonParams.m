//
//  APICommonParams.m
//  MySDKDemoKit
//
//  Created by 李一贤 on 2018/9/14.
//  Copyright © 2018年 李一贤. All rights reserved.
//

#import "APICommonParams.h"
#import "MySDKConfig.h"
#import "NSString+UniqueStrings.h"


@implementation APICommonParams

#pragma mark -getter-

-(NSString *)appid{
    
    if (_appid) {
        return _appid;
    }
    
    _appid = [MySDKConfig shareInstance].appid;
    return _appid;
}

- (NSString *)udid {
    
    if (_udid) {
        return _udid;
    }
    _udid = [NSString uuid];
    return _udid;
}

- (NSString *)channel {
    
    if (_channel) {
        return _channel;
    }
    _channel = [MySDKConfig shareInstance].channel;
    return _channel;
}

- (NSString *)advchannel {
    //注意此处不要用懒加载
    _advchannel = [NSString advchannel:NULL];
    return _advchannel;
}

@end
