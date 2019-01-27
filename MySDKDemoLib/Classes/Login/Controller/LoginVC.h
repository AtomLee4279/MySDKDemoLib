//
//  LoginVC.h
//  MySDKDemoLib
//
//  Created by 李一贤 on 2019/1/1.
//  Copyright © 2019 李一贤. All rights reserved.
//

#import "BaseVC.h"
#import "MySDKNetWorkController.h"
#import "HistoryAccountsVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface LoginVC : BaseVC<MySDKNetWorkDelegate,HistoryAccountsDelegate>

@end

NS_ASSUME_NONNULL_END
