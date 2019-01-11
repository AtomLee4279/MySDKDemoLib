//
//  MySDKInitData.m
//  MySDKDemoKit
//
//  Created by 李一贤 on 2018/9/13.
//  Copyright © 2018年 李一贤. All rights reserved.
//

#import "MySDKInitData.h"

@implementation MySDKInitData

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    
    static MySDKInitData *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [super allocWithZone:zone];
    });
    return instance;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {}

@end
