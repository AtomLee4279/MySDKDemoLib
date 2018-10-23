//
//  MySDKLoginController.m
//  MySDKDemoKit
//
//  Created by 李一贤 on 2018/9/13.
//  Copyright © 2018年 李一贤. All rights reserved.
//

#import "MySDKLoginController.h"
#import <MJExtension.h>
#import "NSString+Sign.h"
#import "ParamsRegLogOn.h"
#import "MySDKConfig.h"
@implementation MySDKLoginController

+ (instancetype)shareInstance {
    
    static MySDKLoginController *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //        instance = [super new];
        instance = [[self alloc]init];
        [MySDKNetWorkController shareInstance].delegate = instance;
    });
    return instance;
}

-(void)mySDKLogin
{
    //模型转字典
    ParamsRegLogOn *LoginParams = [ParamsRegLogOn new];
    LoginParams.rltype = @"user";
    LoginParams.uname = @"40045798";
    LoginParams.password = @"ijm_7M4R5P";
    NSDictionary *dict = [LoginParams mj_keyValues];
//    //字符串签名，返回字典格式
    NSDictionary* uploadData = [NSString signDictionaryWithParameters:dict appKey:[MySDKConfig shareInstance].appkey];
    [MySDKNetWorkController requestRegisterAndLoginWithParam:uploadData];
}

-(void)NetWorkRespondSuccessDelegate:(nullable NetWorkRespondModel*)result {
    
    NSLog(@"--MySDKInitController--NetWorkRespondSuccessDelegate");
    
    
    
}

- (void)NetWorkRespondFailDelegate:(nullable NetWorkRespondModel*)result {
    
    NSLog(@"--MySDKInitController--NetWorkRespondFailDelegate");
    //网络问题导致登录化失败
  
    
}

@end
