//
//  MySDKInitController.m
//  MySDKDemoKit
//
//  Created by 李一贤 on 2018/7/6.
//  Copyright © 2018年 李一贤. All rights reserved.
//

#import "MySDKInitController.h"
#import "NSString+Sign.h"
#import <MJExtension.h>
#import "MySDKConfig.h"
#import "MySDKDemoLib.h"
#import "NSString+UniqueStrings.h"
#import "MySDKInitData.h"
@implementation MySDKInitController

+ (instancetype)shareInstance {

    static MySDKInitController *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //        instance = [super new];
        instance = [[self alloc]init];
        [MySDKNetWorkController shareInstance].delegate = instance;
    });
    return instance;
}


-(void)mySDKInit
{
    //模型转字典
    NSDictionary *dict = [[MySDKConfig shareInstance] mj_keyValues];
    //字符串签名，返回字典格式
    NSDictionary* uploadData = [NSString signDictionaryWithParameters:dict appKey:[MySDKConfig shareInstance].appkey];
    [MySDKNetWorkController requestInitWithParam:uploadData];
}

-(void)NetWorkRespondSuccessDelegate:(nullable NetWorkRespondModel*)result {
    
    NSLog(@"--MySDKInitController--NetWorkRespondSuccessDelegate");
    //初始化成功
    if ([result.result boolValue]&&[[MySDKDemoLib shareInstance].delegate respondsToSelector:@selector(KolaDidInitFinish:)]){
        [[MySDKInitData new] setValuesForKeysWithDictionary:result.data];
        //如需要，则更新手机存的advchannel值
        [NSString advchannel:result.data[@"advchannel"]];
    // 初始化返回的数据，不必要给cp看到。
        result.data = nil;
        [[MySDKDemoLib shareInstance].delegate KolaDidInitFinish:result.mj_keyValues];
     
    }
    //初始化失败:具体看情况
    if (![result.result boolValue]) {
        
        if ([[MySDKDemoLib shareInstance].delegate respondsToSelector:@selector(KolaHandleFail:andDtail:)]){
            
            [[MySDKDemoLib shareInstance].delegate KolaHandleFail:@"init-fail" andDtail:result.mj_keyValues];
            
        }
    }
    
    
}

- (void)NetWorkRespondFailDelegate:(nullable NetWorkRespondModel*)result {
    
    NSLog(@"--MySDKInitController--NetWorkRespondFailDelegate");
    //网络问题导致初始化失败
    if ([[MySDKDemoLib shareInstance].delegate respondsToSelector:@selector(KolaHandleFail:andDtail:)]){
        
        [[MySDKDemoLib shareInstance].delegate KolaHandleFail:@"init-fail：NetWork-Fail" andDtail:result.mj_keyValues];
        
    }
    
}


@end
