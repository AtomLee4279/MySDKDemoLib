//
//  MySDKInitController.h
//  MySDKDemoKit
//
//  Created by 李一贤 on 2018/7/6.
//  Copyright © 2018年 李一贤. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MySDKNetWorkController.h"

@interface MySDKInitController : NSObject<MySDKNetWorkDelegate>

+ (instancetype)shareInstance;

-(void)mySDKInit;
@end
