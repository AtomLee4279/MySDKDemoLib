//
//  MySDKNetWorking.h
//  MySDKDemoKit
//
//  Created by 李一贤 on 2018/7/4.
//  Copyright © 2018年 李一贤. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetWorkRespondModel.h"
#import <AFNetworking.h>

@class MySDKNetWorkController;
@protocol MySDKNetWorkDelegate <NSObject>

@required

-(void)NetWorkRespondSuccessDelegate:(nullable NetWorkRespondModel*)result;

-(void)NetWorkRespondFailDelegate:(nullable NetWorkRespondModel*)result;

@end

@interface MySDKNetWorkController : NSObject

+ (instancetype)shareInstance;

@property(strong, nonatomic) AFHTTPSessionManager *manager;

@property(weak,nonatomic) id<MySDKNetWorkDelegate> delegate;

+(void)requestInitWithParam:(nullable id)param;

+(void)requestRegisterAndLoginWithParam:(nullable id)param;

-(void)NetWorkRespondSuccessWithParam:(nullable id)param;

-(void)NetWorkRespondFailWithParam:(nullable id)param;

@end
