//
//  KKSizeAssistant.h
//  KoalaGameKit
//
//  Created by kaola  on 2018/3/7.
//  Copyright © 2018年 kaola . All rights reserved.
//

#ifndef KKSizeAssistant_h
#define KKSizeAssistant_h

#import "KKRegisterController.h"

// 适配字体
/// 最小字体
#define KKFONT_MIN_SIZE 12.5
/// 这针对iPhone6为标准适配
#define KKFONT(s)       [UIFont systemFontOfSize:KKFONTSIZE(s)]
#define KKFONT_BOLD(s)   [UIFont boldSystemFontOfSize:KKFONTSIZE(s)]
/// 字体大小转换，<=12的字体不换算
#define KKFONTSIZE(s) ((s<KKFONT_MIN_SIZE)?s:((s)*UIScreenMaxLine()/667.0))

// 适配宽高
/// 这针对iPhone6为标准适配宽度
#define KKWIDTH(R) ((R)*(IS_PAD ? 1.5f : KKWIDTH_FATOR))
/// 这针对iPhone6为标准适配高度
#define KKHEIGHT(R) ((R)*(IS_PAD ? 1.2f : KKHEIGHT_FATOR))

#define KKWIDTH_FATOR UIScreenMinLine()/375.0
#define KKHEIGHT_FATOR UIScreenMaxLine()/667.0
// 使用KKWIDTH_FATOR，降低因子的大小
//#define KKHEIGHT_FATOR KKWIDTH_FATOR
#define IS_PAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)


#define Screen_Width [UIScreen mainScreen].bounds.size.width
#define Screen_Height [UIScreen mainScreen].bounds.size.height


/// screen 最小边长度
static inline CGFloat UIScreenMinLine(void);
/// screen 最大边长度
static inline CGFloat UIScreenMaxLine(void);
/// screen 是否是竖屏
static inline BOOL UIScreenIsPortrait(void);

/// main view的宽度
static inline CGFloat KKMainViewWidth(void);
/// main view的高度
static inline CGFloat KKMainViewHeight(void);
/// main view的Y值
static inline CGFloat KKMainViewY(void);
/// main view的X值
static inline CGFloat KKMainViewX(void);

/// 竖屏时main view最高的高度
static inline CGFloat KKMainViewPortraitMaxHeight(void);

/// 横屏时main view最大的高度
static inline CGFloat KKMainViewLandscapeMaxHeight(void);

/// 密码 key
static inline NSString * KKKeychainPwdKey(NSString *username);

/// 交易凭证uid key
static inline NSString * KKKeyReceiptUidKey(NSString *orderid);

/// 交易凭证 key
static inline NSString * KKKeyReceiptKey(NSString *orderid);

/// screen 最小边长度
static inline CGFloat UIScreenMinLine() {
    
    return (Screen_Width <= Screen_Height) ? Screen_Width : Screen_Height;
}

/// screen 最大边长度
static inline CGFloat UIScreenMaxLine() {
    
    return (Screen_Width <= Screen_Height) ? Screen_Height : Screen_Width;
}

/// screen 是否是竖屏
static inline BOOL UIScreenIsPortrait() {
    
    return Screen_Height > Screen_Width;
}

/// main view的Y值
static inline CGFloat KKMainViewY() {
    
    return (Screen_Height - KKMainViewHeight()) * .5;
}

/// main view的X值
static inline CGFloat KKMainViewX() {
    
    return (Screen_Width - KKMainViewWidth()) * .5;
}

/// 竖屏时main view最高的高度
static inline CGFloat KKMainViewPortraitMaxHeight(void) {
    
    // 注册页面高度最高
    return [[KKRegisterController new] kk_tableHeightNeeded];
}

/// 横屏时main view最大的高度
static inline CGFloat KKMainViewLandscapeMaxHeight(void) {
    
//    return KKMainViewHeight();
    return UIScreenMinLine() - 60.f;
}

/// main view的高度(横屏时，用这个高度)
static inline CGFloat KKMainViewHeight() {
    
    // 分ipad和iphone
    return IS_PAD ? (KKWIDTH(370.f) - 60.f) : (UIScreenMinLine() - 60.f);
}

/// main view的宽度
static inline CGFloat KKMainViewWidth() {
    
    return KKMainViewHeight();
}

/// 密码 key
static inline NSString * KKKeychainPwdKey(NSString *username) {
    
    return [NSString stringWithFormat:@"kl_pwd_v1_%@", username];
}

/// 交易凭证uid key
static inline NSString * KKKeyReceiptUidKey(NSString *orderid) {
    
    return [NSString stringWithFormat:@"kl_uid_v1_%@", orderid];
}

/// 交易凭证 key
static inline NSString * KKKeyReceiptKey(NSString *orderid) {
    
    return [NSString stringWithFormat:@"kl_receipt_v1_%@", orderid];
}


#endif /* KKSizeAssistant_h */
