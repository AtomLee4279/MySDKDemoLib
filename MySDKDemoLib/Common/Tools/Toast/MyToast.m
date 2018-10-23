
//
//  MyToast.m
//  MySDKDemoKit
//
//  Created by 李一贤 on 2018/7/9.
//  Copyright © 2018年 李一贤. All rights reserved.
//

#import "MyToast.h"
#import <KSToastView.h>

@implementation MyToast

//弹出一个toast
//message：提示信息
//time：消失过程持续时间
+(void)showAlertMessageWithMessage:(NSString*)message duration:(NSTimeInterval)time
{
    [MyToast ks_setAppearanceTextColor:[UIColor whiteColor]];
    [MyToast ks_setAppearanceOffsetBottom:[self screenBounds].size.height / 2];
    [MyToast ks_showToast:message duration:time?time:2.0f];
    
    
    
}

//获取当前屏幕中present出来的viewcontroller.

+ (UIViewController *)getPresentedViewController
{
    UIViewController *appRootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *topVC = appRootVC;
    if (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
    }
    
    return topVC;
}

+ (CGRect)screenBounds {
    
    UIScreen *screen = [UIScreen mainScreen];
    CGRect screenRect;
    if (![screen respondsToSelector:@selector(fixedCoordinateSpace)] && UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)) {
        screenRect = CGRectMake(screen.bounds.origin.x, screen.bounds.origin.y, screen.bounds.size.height, screen.bounds.size.width);
    } else {
        screenRect = screen.bounds;
    }
    
    return screenRect;
}

@end
