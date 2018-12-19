//
//  MySDKDemoLib.m
//  MySDKDemoLib
//
//  Created by 李一贤 on 2018/10/23.
//  Copyright © 2018 李一贤. All rights reserved.
//

#import "MySDKDemoLib.h"
#import "NSString+Sign.h"
#import <MJExtension.h>
#import "MySDKInitController.h"
#import "NSString+UniqueStrings.h"
#import "SDKLoginController.h"
#import "AccountRegisterViewController.h"
#import "AccountLoginViewController.h"


@interface MySDKDemoLib ()

@end

@implementation MySDKDemoLib

+ (instancetype)shareInstance {
    
    static MySDKDemoLib *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //        instance = [super new];
        instance = [[self alloc] init];
    });
    return instance;
}

- (void)Kola_Init
{
    
    [MySDKConfig shareInstance].appid = @"100000";
    [MySDKConfig shareInstance].channel = @"appstore100000";
    [MySDKConfig shareInstance].appkey = @"123456";
//    检查初始化参数
    if ([self checkInitParam]) {
        [[MySDKInitController shareInstance] mySDKInit];
    }

   
}

- (BOOL)checkInitParam{
    if (!([MySDKConfig shareInstance].appid&&[MySDKConfig shareInstance].appkey&&[MySDKConfig shareInstance].channel)) {
        Toast(@"appid/appkey/channel不能为空！请检查sdk初始化填入参数", 1.0f);
        return NO;
    }
    return YES;
}


- (void)Kola_Login{
    
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"SDKBundle" ofType:@"bundle"];
    NSBundle *SDKBundle = [NSBundle bundleWithPath:path];
    
    AccountLoginViewController *baseVC = [[AccountLoginViewController alloc] initWithNibName:@"AccountLoginView" bundle:SDKBundle];
    [baseVC setModalTransitionStyle:(UIModalTransitionStyleFlipHorizontal)];
    [baseVC setModalPresentationStyle:UIModalPresentationCustom];
    
    
    UIViewController *viewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    [viewController presentViewController:baseVC animated:YES completion:nil];
    
    
}

@end
