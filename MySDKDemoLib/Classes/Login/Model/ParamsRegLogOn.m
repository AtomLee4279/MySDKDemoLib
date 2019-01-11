//
//  APIParameters.m
//  MySDKDemoKit
//
//  Created by 李一贤 on 2018/9/14.
//  Copyright © 2018年 李一贤. All rights reserved.
//

#import "ParamsRegLogOn.h"
#import "NSString+UniqueStrings.h"
#import "MySDKInitData.h"

@implementation ParamsRegLogOn

#pragma mark -getter-

- (NSString *)requestId {
    
    return [NSString timestramp];
}


- (NSString *)token {
    
    if (_token) {
        return _token;
    }
    _token = [MySDKInitData new].token;
    return _token;
}

- (NSString *)idfv {
    
    if (_idfv) {
        return _idfv;
    }
    _idfv = [NSString idfv];
    return _idfv;
}

-(NSString*)mobile{
    
    if (_mobile) {
        return _mobile;
    }
    _mobile = [NSString currentDeviceModel];
    return _mobile;
}

-(NSString*)pkversion{
    
    if (_pkversion) {
        return _pkversion;
    }
    NSString *channelWithoutDots = [self.channel stringByReplacingOccurrencesOfString:@"." withString:@""];
    _pkversion = [NSString stringWithFormat:@"%@_%@", channelWithoutDots ?: @"", [NSString cpUniqueVersionString] ?: @""];
    return _pkversion;
}

@end
