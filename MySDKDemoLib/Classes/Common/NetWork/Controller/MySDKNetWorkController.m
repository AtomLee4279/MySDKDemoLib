//
//  MySDKNetWorking.m
//  MySDKDemoKit
//
//  Created by 李一贤 on 2018/7/4.
//  Copyright © 2018年 李一贤. All rights reserved.
//

#import "MySDKNetWorkController.h"
//#import "MySDK.h"
#import "MySDKConfig.h"
#import "NSString+Sign.h"
//#import "KKDebug.h"
#import <MJExtension.h>
#import <AFNetworking.h>

// 正式服 -- 最新2018.05.30开始使用
static NSString * const myBaseURLString = @"https://api.lynaqi.cn";

/** 初始化 */
static NSString * const Init_URL = @"App/Basic/Init";

/** 一键注册：注册登陆 */
static NSString * const RegLogOn_URL = @"App/Accounts/RegLogOn";

@interface MySDKNetWorkController()

@property(strong, nonatomic) AFHTTPSessionManager *manager;

@end

@implementation MySDKNetWorkController

#pragma mark - method

+ (instancetype)shareInstance {
    
    static MySDKNetWorkController *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        instance = [[self alloc]init];
    });
    return instance;
}

//初始化
//param:参数
+(void)requestInitWithParam:(nullable id)param{
    
    DBLog(@"init，上传的参数：%@", param);
    [[MySDKNetWorkController new].manager POST:Init_URL parameters:param progress:NULL success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NetLog(@"init#网络请求,\n返回数据：%@",responseObject);
        //服务器返回的对象转成客户端定义的network模型
        NetWorkRespondModel *result = [NetWorkRespondModel netWorkModelWithObject:responseObject];
        //把网络请求成功结果返回给功能模块
        [[MySDKNetWorkController shareInstance] NetWorkRespondSuccessWithParam:result];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NetLog(@"\n#init#网络请求失败！请检查网络：%@",[error mj_keyValues]);
        //服务器返回的对象转成客户端定义的network模型
        NetWorkRespondModel *result = [NetWorkRespondModel netWorkModelWithObject:error];
        //把网络请求失败结果返回给功能模块
        [[MySDKNetWorkController shareInstance] NetWorkRespondFailWithParam:result];
        
    }];
    
}

//登录
//param:参数
+(void)requestRegisterAndLoginWithParam:(nullable id)param{
    
    DBLog(@"reg&logOn，上传的参数：%@", param);
    [[MySDKNetWorkController new].manager POST:RegLogOn_URL parameters:param progress:NULL success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NetLog(@"RegLogin#网络请求,\n返回数据：%@",responseObject);
        //服务器返回的对象转成客户端定义的network模型
        NetWorkRespondModel *result = [NetWorkRespondModel netWorkModelWithObject:responseObject];
        //把网络请求成功结果返回给功能模块
        [[MySDKNetWorkController shareInstance] NetWorkRespondSuccessWithParam:result];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NetLog(@"\n#RegLogin#网络请求失败！请检查网络：%@",[error mj_keyValues]);
        //服务器返回的对象转成客户端定义的network模型
        NetWorkRespondModel *result = [NetWorkRespondModel netWorkModelWithObject:error];
        //把网络请求失败结果返回给功能模块
        [[MySDKNetWorkController shareInstance] NetWorkRespondFailWithParam:result];
        
    }];
    
}




//把网络请求成功的结果返回给实现了代理方法的功能模块
-(void)NetWorkRespondSuccessWithParam:(nullable id)param{
    if ([self.delegate respondsToSelector:@selector(NetWorkRespondSuccessDelegate:)]) {
        [self.delegate NetWorkRespondSuccessDelegate:param];
    }
}

////把网络请求失败的结果返回给实现了代理方法的功能模块
-(void)NetWorkRespondFailWithParam:(nullable id)param{
    if ([self.delegate respondsToSelector:@selector(NetWorkRespondFailDelegate:)]) {
        [self.delegate NetWorkRespondFailDelegate:param];
    }
}


#pragma mark - Getter & Setter
- (AFHTTPSessionManager *)manager {
    
    if (_manager) {
        return _manager;
    }
    
    _manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:myBaseURLString]];
    _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    _manager.requestSerializer.timeoutInterval = 30.f;
    return _manager;
}



@end

