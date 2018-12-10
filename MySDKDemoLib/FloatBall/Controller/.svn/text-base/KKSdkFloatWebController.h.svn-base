//
//  KKSdkFloatWebController.h
//  KoalaGameKit
//
//  Created by kaola  on 2018/3/15.
//  Copyright © 2018年 kaola . All rights reserved.
// 悬浮框上面的2个web vc

#import "KKUIWebController.h"

typedef NS_ENUM(NSInteger, KKSdkFloatWebTpye) {
    
    KKSdkFloatWebTpyeUserCentre,
    KKSdkFloatWebTpyeServiceCentre,
};

@protocol JSWebHandlesDelegate <JSExport>

/** 关闭这个web  */
- (void)close;

/** 保存用户名和密码  */
- (void)SavePwd:(NSString *)user :(NSString *)pass :(NSString *)uid;

@end


@interface KKSdkFloatWebController : KKUIWebController <JSWebHandlesDelegate>

@property(nonatomic, copy) NSString *webUrlString;

@end
