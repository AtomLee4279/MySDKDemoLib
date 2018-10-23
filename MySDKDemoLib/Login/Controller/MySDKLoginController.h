//
//  MySDKLoginController.h
//  MySDKDemoKit
//
//  Created by 李一贤 on 2018/9/13.
//  Copyright © 2018年 李一贤. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MySDKNetWorkController.h"


@interface MySDKLoginController : NSObject<MySDKNetWorkDelegate>

+ (instancetype)shareInstance;

-(void)mySDKLogin;


@end
