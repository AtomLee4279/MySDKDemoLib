//
//  MyToast.h
//  MySDKDemoKit
//
//  Created by 李一贤 on 2018/7/9.
//  Copyright © 2018年 李一贤. All rights reserved.
//逐渐消失的toast，自行封装

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <KSToastView.h>
@interface MyToast : KSToastView

+(void)showAlertMessageWithMessage:(NSString*)message duration:(NSTimeInterval)time;

+(UIViewController *)getPresentedViewController;


@end
