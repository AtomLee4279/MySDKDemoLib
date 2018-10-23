//
//  APICommonParams.h
//  MySDKDemoKit
//
//  Created by 李一贤 on 2018/9/14.
//  Copyright © 2018年 李一贤. All rights reserved.
//

#import <Foundation/Foundation.h>

//请求后台API的公共参数模型
 
@interface APICommonParams : NSObject

//应用ID
@property (copy ,nonatomic) NSString *appid;

//设备号；实际上上传的的是uuid
@property (copy ,nonatomic) NSString *udid;

//渠道标识，对应plist文件中的ver字段
@property (copy ,nonatomic) NSString *channel;

//广告渠道标识，首次初始化返回，没有传空字符串
@property (copy ,nonatomic) NSString *advchannel;

@end
