//
//  APIParameters.h
//  MySDKDemoKit
//
//  Created by 李一贤 on 2018/9/14.
//  Copyright © 2018年 李一贤. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "APICommonParams.h"


//一键注册/账号密码登录API
@interface ParamsRegLogOn:APICommonParams

//时间戳
@property (copy ,nonatomic) NSString *requestId;

//初始化返回的token
@property (copy ,nonatomic) NSString *token;

//注册登录类型，phone - 手机号, user - 用户名, visitor - 游客
@property (copy ,nonatomic) NSString *rltype;

//账号密码登录时，必须
@property (copy ,nonatomic) NSString *uname;

//账号密码登录时，必须
@property (copy ,nonatomic) NSString *password;

//手机号登录时，必须
@property (copy ,nonatomic) NSString *mobile;

//手机登录时，必须
@property (copy ,nonatomic) NSString *verify_code;

//IDFV
@property (copy ,nonatomic) NSString *idfv;

//浏览器信息
@property (copy ,nonatomic) NSString *user_agent;

//设备系统详细信息
@property (copy ,nonatomic) NSString *systeminfo;

@end





