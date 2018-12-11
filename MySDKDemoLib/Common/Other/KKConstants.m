//
//  KKConstants.m
//  KoalaGameKit
//
//  Created by kaola  on 2018/3/8.
//  Copyright © 2018年 kaola . All rights reserved.
//

//#import "KKConstants.h"

#pragma mark - notis

/** 通知：去更新弹出框的约束（有的网页需要模态出一个web，框的frame会发生难看的改变） */
NSString * const KKNotiUpdateWindowContrainsNoti = @"com.kaola.KKNotiUpdateWindowContrainsNoti";

/** 通知：去更新弹出框的高度（有些网页的高度比较高，竖屏的情况下，会需要更新框的高度） */
NSString * const KKNotiUpdateWindowHeightNoti = @"com.kaola.KKNotiUpdateWindowHeightNoti";

/** 通知：去登录(由于自动登录失败等原因，需要弹出登录框，让用户手动登录) */
NSString * const KKNotiGotoLoginNoti = @"com.kaola.KKNotiGotoLoginNoti";

/** 登录成功 */
NSString * const KKNotiLoginSuccessNoti = @"com.kaola.KKNotiLoginSuccessNoti";

/** 通知：登出成功 */
NSString * const KKNotiLogoutSuccessNoti = @"com.kaola.KKNotiLogoutSuccessNoti";

/** 通知：去切换账号 */
NSString * const KKNotiGotoLogoutNoti = @"com.kaola.KKNotiGotoLogoutNoti";

/** 通知：去播放自定义的navigate过场动画trans */
NSString * const KKNotiGotoPlayTransNoti = @"com.kaola.KKNotiGotoPlayTransNoti";

/** 通知消息类型：切换账号的类型key */
NSString * const kKKNotiGotoLogoutTypeKey = @"logout_type";

/** 通知消息类型的值：切换账号的类型的value: 用户选择退出账号 */
NSString * const KKNotiGotoLogoutTypeValueLogout = @"logout_value";

/** 通知消息类型的值：切换账号的类型的value: 用户取消自动登录 */
NSString * const KKNotiGotoLogoutTypeValueCancelAutologin = @"logout_cancel_autologin_value";

#pragma mark - 一些常量
/** 初始化失败的最大次数，超过这个次数，就直接回调给接入方  */
NSInteger const KKInitFailedMaxTime = 5;

/** 悬浮球弹出动画持续时间  */
NSTimeInterval const KKFloatBallAnimationDuration = .3f;

/** 缩放动画持续时间  */
NSTimeInterval const KKNormalEnlargeAnimationDuration = .4f;

/** 登录动画持续时间  */
NSTimeInterval const KKNormalLoginAnimationDuration = .4f;

/** 自动登录动画持续时间  */
NSTimeInterval const KKAutoLoginAnimationDuration = .4f;

#pragma mark - result

/** 网络错误 code */
NSString * const kKKResultNetworkWrongCode = @"com.kaola.NetworkWrongCode";

/** 网络错误 msg */
NSString * const kKKResultNetworkWrongMsg = @"网络错误，请检查您的网络～";

/** 登录成功标示的key */
NSString * const kKKNotiLoginSuccessCodeKey = @"login_code";

/** 登录成功返回的数据的key：result对象，data是一个user */
NSString * const kKKNotiLoginSuccessResultKey = @"login_res";

/** 通知：制服失败 */
NSString * const KKNotiSettleBillResultNoti = @"com.kaola.KKNotiSettleBillResultNoti";

/** 制服结果code的key */
NSString * const kKKNotiSettleBillCodeKey = @"bill_code";

/** 制服结果res的key */
NSString * const kKKNotiSettleBillResKey = @"bill_res";

/** 播放自定制navigate过场动画的key */
NSString * const KKNotiPlayTransKey = @"navObj";


