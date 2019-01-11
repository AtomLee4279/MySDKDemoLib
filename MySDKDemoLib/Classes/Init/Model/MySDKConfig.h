//
//  MySDKConfig.h
//  MySDKDemoKit
//
//  Created by 李一贤 on 2018/7/5.
//  Copyright © 2018年 李一贤. All rights reserved.
//

#import <Foundation/Foundation.h>

//请求初始化时上传的数据的模型
@interface MySDKConfig : NSObject

//单例
+ (instancetype)shareInstance;

//应用id
@property(copy,nonatomic) NSString* _Nonnull appid;
//签名的key
@property(copy,nonatomic) NSString* _Nonnull appkey;
//渠道名称
@property(copy,nonatomic) NSString* _Nonnull channel;
//

@end


