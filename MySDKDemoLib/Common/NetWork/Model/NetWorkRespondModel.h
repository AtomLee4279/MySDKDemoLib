//
//  NetWorkRespondModel.h
//  MySDKDemoKit
//
//  Created by 李一贤 on 2018/7/7.
//  Copyright © 2018年 李一贤. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetWorkRespondModel : NSObject

//服务器返回字段，表示网络请求成功后，返回的与sdk流程紧密相关的重要信息
@property(strong,nonatomic) NSDictionary *data;

//服务器返回字段，表示网络请求成功后，某功能操作成功与否的简要提示信息
@property(strong,nonatomic) NSString *msg;

//服务器返回字段，表示网络请求成功，某功能（初始化/登录/支付...）是否操作成功的标志位（1/0）
@property(strong,nonatomic) NSString *result;

//服务器返回字段，表示网络请求失败后，返回的报错信息
@property(strong,nonatomic) NSError *error;


-(instancetype)initWithObject:(id)object;

+(instancetype)netWorkModelWithObject:(id)object;

@end
