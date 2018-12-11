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

#import "FloatBallController.h"
#import "FloatLeftExtendView.h"
#import "FloatRightExtendView.h"
#import "KKFloatCollectView.h"

@interface MySDKDemoLib ()

@property(nonatomic, strong) FloatBallController *floatVc;

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

/**
 配置悬浮球
 
 @param viewController vc
 @param isRememberFloatBallLocation 是否记住悬浮球的位置
 */
- (void)setupFloatBallWtihViewController:(UIViewController *)viewController isRememberFloatBallLocation:(BOOL)isRememberFloatBallLocation floatBallInitStyle:(FloatBallStyle)floatBallInitStyle {
    
    // 先看看vc里面有没有这个悬浮球，如果有，就先去掉
    for (UIViewController *vc in viewController.childViewControllers) {
        
        if ([vc isKindOfClass:[FloatBallController class]]) {
            
            FloatBallController *floatVcOLD = (FloatBallController *)vc;
            [floatVcOLD removeTheFloatBall];
        }
    }
    
    // 添加并设置悬浮球
    self.floatVc =
    [FloatBallController fetchFloatBallControllerWithViewController:viewController
                                                             height:KKHEIGHT(60.f)
                                                       interPadding:KKHEIGHT(0.f)
                                              isRemberUserOperation:isRememberFloatBallLocation
                                                         userPrefix:@"a"
                                                     initFloatStyle:floatBallInitStyle];
    // 设置悬浮球的图片
    [self.floatVc.floatView.floatBtn kk_setBackgroundImageWithURLString:nil forState:UIControlStateNormal placeholderImage: res_float_ball];
    [self.floatVc.floatView.floatBtn kk_setBackgroundImageWithURLString:nil forState:UIControlStateHighlighted placeholderImage: res_float_ball_down];
    // 想要等待的时间，减去2；比如想要等9s，就赋值为7
    self.floatVc.floatView.waitTimeInterval = 7.f;
    
    NSArray *float_menu = [KKUserHandler sharedHandler].float_menu;
    NSMutableArray *items = [NSMutableArray array];
    for (KKUserFloat *flo in float_menu) {
        [items addObject:[KKFloatItem floatItemWithIcon:flo.icon highlightIcon:flo.highlightIcon actionTag: flo.tag]];
    }
    
    //    [self kk_setupFloatExtendViewsWithItems: items];
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
