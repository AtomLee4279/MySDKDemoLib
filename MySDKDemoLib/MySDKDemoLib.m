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
#import "MySDKLoginController.h"
#import "LoginView.h"

@implementation MySDKDemoLib

+ (instancetype)shareInstance {
    
    static MySDKDemoLib *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //        instance = [super new];
        instance = [[self alloc]init];
    });
    return instance;
}

- (void)Kola_Init
{
    //检查初始化参数
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
    
    
//    [[MySDKLoginController shareInstance] mySDKLogin];
    UIViewController *viewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    UIStoryboard *user = [UIStoryboard storyboardWithName:@"MySDKDemoLibStoryBoard" bundle:nil];
//    UIViewController *userVC = [user instantiateViewControllerWithIdentifier:@"MySDKDemoLibStoryBoard"];
    UIViewController *userVC = [user instantiateInitialViewController];
    [userVC setModalTransitionStyle:(UIModalTransitionStyleFlipHorizontal)];
    
    [viewController presentViewController:userVC animated:YES completion:nil];
    
}

@end
