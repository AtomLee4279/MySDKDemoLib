//
//  KKUserHandler.m
//  KoalaGameKit
//
//  Created by kaola  on 2018/3/8.
//  Copyright © 2018年 kaola . All rights reserved.
//

#import "KKUserHandler.h"

#import "UICKeyChainStore.h"
#import "NSString+UniqueStrings.h"
static NSString * const kKKKeyChainStoreWithService = @"com.koala.kKKeyChainStoreWithService.v1";

@implementation KKUserHandler

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    
    static KKUserHandler *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [super allocWithZone:zone];
    });
    
    return instance;
}

- (id)copy{
    
    return self;
}

#pragma mark - methods

/**
 解析为一个handler，同时返回这个handler
 
 @param keyValues 字典
 @return handler
 */
//+ (instancetype)kk_saveUserInfoAndFetchHandlerWithKeyValues:(id)keyValues {
//
//    //先清除之前保存的handler状态
//    [[KKUserHandler sharedHandler] logoutAllDatas];
//    //字典转模型，注意此时得出来的handler模型对象,其成员“float_menu”将会是一个字典的数组
//    KKUserHandler *handler = [self kk_modelWithKeyValues:keyValues];
//    //handleFloatMenu里进一步处理handler对象内的“float_menu”，将字典的数组转换成为KKUserFloat模型的数组
//    [handler handleFloatMenu];
//    [handler saveUser];
//
//    return handler;
//}

/**
 检查是否可以自动登录
 
 @return 1，可以；0，不行
 */
+ (BOOL)kk_checkoutIfCanAutologin {
    
    NSString *username = [KKUserHandler sharedHandler].username;
    if (username.length) {
        
        NSString *pwd = [self kk_fetchPwdFromKeychainWithUsername:username];
        if (pwd.length) {
            
            return YES;
        }
    }
    
    return NO;
}

/**
 检查是否需要弹出实名认证窗口
 
 @return 1，可以；0，不行
 */
+ (BOOL)kk_checkoutIfCanPopupRealNameAuthentication
{
    if ([KKUserHandler sharedHandler].valid.length)
    {
        return YES;
    }
    return NO;
}

/**
 获得当前的user
 
 @return user
 */
- (KKUser *)fetchCurrentUser {
    
    KKUser *user = [KKUser new];
    user.username = self.username;
    user.gametoken = self.gametoken;
    user.uid = self.uid;
    user.sessid = self.sessid;
    user.time = self.time;
    return user;
}

/**
 保存用户信息到本地
 */
- (void)saveUser {
    
    if (self.username.length) {
        
        // 保存用户名到user defaults，并成为最新登录的
        [self saveUsernameToUserDefaults];
    }
    
    if (!self.pwd.length || [self.pwd isEqualToString:@"0"]) {
//        KKLog(@"后台返回密码为：%@", self.pwd ?: @"空");
    }
    
    if (self.pwd.length) {
        
        // 保存pwd到key chain(如果有，才覆盖钥匙串中的值)
        [self savePasswordToKeychain];
    }
}



 //处理浮点数据
-(void)handleFloatMenu{
    if (!self.float_menu.count) {
//        KKLog(@"后台返回浮点数据为空！");
        return;
    }
    //将字典的数组转换成KKUserFloat模型的数组，重新存进float_menu
    [KKUserHandler sharedHandler].float_menu = [KKUserFloat kk_modelArrayWithKeyValuesArray:[KKUserHandler sharedHandler].float_menu];
    NSMutableArray *floatItems = [NSMutableArray array];
    //筛选过滤后台返回的并不存在的浮点功能，按顺序重新封装成新数组
    for (KKUserFloat *flo in [KKUserHandler sharedHandler].float_menu) {
        if ([FLOAT_CHECK containsObject:flo.name] && flo.is_open.boolValue) {
            [flo setFloatProperty];
            [floatItems addObject:flo];
        };
    }
    //新数组重新赋回去float_menu成员属性
    [KKUserHandler sharedHandler].float_menu = floatItems;
}


// 保存用户名到user defaults
- (void)saveUsernameToUserDefaults {
    
    NSUserDefaults *usrDault = [NSUserDefaults standardUserDefaults];
    NSMutableArray *usrArrM = [NSMutableArray array];
    NSArray *usrArr = [usrDault mutableArrayValueForKey:kKKUsersArrayKey];
    if (usrArr.count) {
        // 存过
        [usrArrM addObjectsFromArray:usrArr];
    }
    
    DBLog(@"查询users == %@", usrArrM);
    
    if ([usrArrM containsObject:self.username]) {
        
        // 已经有这个username了，删除掉
        [usrArrM removeObject:self.username];
    };
    
    // 没有这个user，存进去
    [usrArrM insertObject:self.username atIndex:0];
    [usrDault setObject:usrArrM forKey:kKKUsersArrayKey];
    [usrDault synchronize];
    
    DBLog(@"添加后users == %@", [usrDault mutableArrayValueForKey:kKKUsersArrayKey]);
}

// 查出所有登录过的用户名
+ (nullable NSArray<NSString *> *)queryAllHistoryUsernames {
    
    // 从user default里面取username
    NSUserDefaults *usrDf = [NSUserDefaults standardUserDefaults];
    NSArray *usrArr = [usrDf mutableArrayValueForKey:kKKUsersArrayKey];

    return usrArr;
}

// 保存pwd到key chain
- (void)savePasswordToKeychain {
    
    UICKeyChainStore *keychain = [UICKeyChainStore keyChainStoreWithService:kKKKeyChainStoreWithService];
    
    // 钥匙串里保存密码和token
    keychain[KKKeychainPwdKey(self.username)] = self.pwd;
}

/** 保存pwd到key chain */
+ (void)kk_savePasswordToKeychainWithPwd:(NSString *)pwd {
//    KKLog(@"kk_savePasswordToKeychainWithPwd");
    if (!pwd.length || [[KKUserHandler sharedHandler].pwd isEqualToString:pwd]) {
        return;
    }
    
    [KKUserHandler sharedHandler].pwd = pwd;
    [[KKUserHandler sharedHandler] savePasswordToKeychain];
}

/**
 获得username对应的pwd（如果保存过）
 
 @param username 用户名
 @return pwd
 */
+ (NSString *)kk_fetchPwdFromKeychainWithUsername:(nonnull NSString *)username {
    
    UICKeyChainStore *keychain = [UICKeyChainStore keyChainStoreWithService:kKKKeyChainStoreWithService];
    
    NSError *err = nil;
    NSString *pwd = [keychain stringForKey:KKKeychainPwdKey(username) error:&err];
    
    if (err) {
        
        // 取出出错
        DBLog(@"从钥匙串取出密码出错：%@", err);
        return @"";
    }
    
    return pwd;
}

/**
 清除所有用户数据
 */
- (void)logoutAllDatas {
    
    self.username = nil;
    self.pwd = nil;
    self.uid = nil;
    self.sessid = nil;
    self.gametoken = nil;
    self.time = nil;
    self.float_menu = nil;
}

/** 获得所有登录过的用户  */
+ (nonnull NSMutableArray<NSString *> *)kk_fetchAllLoginedUsernames {
    
    NSMutableArray *usrArrM = [NSMutableArray array];
    NSArray *usrArr = [self queryAllHistoryUsernames];
    if (usrArr.count) {
        // 存过
        [usrArrM addObjectsFromArray:usrArr];
    }
    
    DBLog(@"KKUserHandler ::users == %@", usrArrM);
    return usrArrM;
}

/** 删除某个用户  */
+ (void)kk_removeTheUserWithAccount:(NSString *)account error:(NSError **)error {
    
    NSMutableArray *userM = [self kk_fetchAllLoginedUsernames];
    if (![userM containsObject:account]) {
        
        *error = [NSError errorWithDomain:@"Handle Users Domain" code:444 userInfo:@{
                                                                                     @"error_info" : [NSString stringWithFormat:@"%@账户不存在（没有存储记录）",account],
                                                                                     }];
        return;
    }
    // 删除密码信息
    UICKeyChainStore *keychain = [UICKeyChainStore keyChainStoreWithService:kKKKeyChainStoreWithService];
    keychain[KKKeychainPwdKey(account)] = nil;
    
    DBLog(@"账号：%@; 密码：%@", account, keychain[KKKeychainPwdKey(account)]);
    
    // 删除账号
    [userM removeObject:account];
    NSUserDefaults *usrDault = [NSUserDefaults standardUserDefaults];
    [usrDault setObject:userM forKey:kKKUsersArrayKey];
    [usrDault synchronize];
    
    DBLog(@"删除账号（%@）后：%@", account, [self kk_fetchAllLoginedUsernames]);
}


+ (instancetype)sharedHandler {
    
    return [self new];
}

#pragma mark - Getter & Setter
- (NSString *)validUrlString {
    
    return [NSString kk_stringFromBase64String:self.valid];
}
- (NSString *)username {
    
    if (_username) {
        return _username;
    }
    
    // 从user default里面取username
    NSArray *usrArr = [KKUserHandler queryAllHistoryUsernames];
    if (!usrArr.count) {
        
        _username = @"";
        return _username;
    }
    
    _username = usrArr.firstObject;
    
    return _username;
}

@end
