//
//  KKUserHandler.h
//  KoalaGameKit
//
//  Created by kaola  on 2018/3/8.
//  Copyright © 2018年 kaola . All rights reserved.
// 处理用户信息

#import <Foundation/Foundation.h>

#import "KKUser.h"
#import "KKUserFloat.h"

@interface KKUserHandler : NSObject

@property(nonatomic, copy) NSString * _Nullable uid;
@property(nonatomic, copy) NSString * _Nullable sessid;
@property(nonatomic, copy) NSString * _Nullable gametoken;
@property(nonatomic, copy) NSString * _Nullable username;
@property(nonatomic, copy) NSString * _Nullable pwd;
@property(nonatomic, copy) NSString * _Nullable time;
@property(nonatomic,copy)  NSString * _Nullable valid;
@property(nonatomic,copy)  NSArray  * _Nullable float_menu;


+ (nonnull instancetype)sharedHandler;

/** 实名认证的url string,对self.valid进行base64解密  */
@property(nonatomic, copy,readonly) NSString *validUrlString;

/**
 解析为一个handler，保存用户信息，最后才返回这个handler

 @param keyValues 字典
 @return handler
 */
+ (nonnull instancetype)kk_saveUserInfoAndFetchHandlerWithKeyValues:(id)keyValues;


/**
 检查是否可以自动登录

 @return 1，可以；0，不行
 */
+ (BOOL)kk_checkoutIfCanAutologin;

/**
 检查是否需要弹出实名认证窗口
 
 @return 1，可以；0，不行
 */
+ (BOOL)kk_checkoutIfCanPopupRealNameAuthentication;

/**
 获得当前的user

 @return user
 */
- (nullable KKUser *)fetchCurrentUser;


/**
 获得username对应的pwd（如果保存过）

 @param username 用户名
 @return pwd
 */
+ (nullable NSString *)kk_fetchPwdFromKeychainWithUsername:(nonnull NSString *)username;

/** 保存pwd到key chain：除了一键注册，其他都不返回密码了，所以需要单独处理保持密码 */
+ (void)kk_savePasswordToKeychainWithPwd:(NSString *)pwd;

/** 保存用户信息到本地  */
- (void)saveUser;

/** 处理浮点数据**/
-(void)handleFloatMenu;

/** 清除当前用户所有的数据 */
- (void)logoutAllDatas;

/** 获得所有登录过的用户  */
+ (nonnull NSMutableArray<NSString *> *)kk_fetchAllLoginedUsernames;

/** 删除某个用户  */
+ (void)kk_removeTheUserWithAccount:(NSString *)account error:(NSError **)error;


@end


