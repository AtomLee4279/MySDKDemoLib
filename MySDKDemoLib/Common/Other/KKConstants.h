//
//  KKConstants.h
//  KoalaGameKit
//
//  Created by kaola  on 2018/3/8.
//  Copyright © 2018年 kaola . All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark - notis

/** 通知：去更新弹出框的约束（有的网页需要模态出一个web，框的frame会发生难看的改变） */
extern NSString * const KKNotiUpdateWindowContrainsNoti;

/** 通知：去更新弹出框的高度（有些网页的高度比较高，竖屏的情况下，会需要更新框的高度） */
extern NSString * const KKNotiUpdateWindowHeightNoti;

/** 通知：去登录(由于自动登录失败等原因，需要弹出登录框，让用户手动登录) */
extern NSString * const KKNotiGotoLoginNoti;

/** 通知：登录成功 */
extern NSString * const KKNotiLoginSuccessNoti;

/** 通知：登出成功 */
extern NSString * const KKNotiLogoutSuccessNoti;

/** 通知：去切换账号 */
extern NSString * const KKNotiGotoLogoutNoti;

/** 通知：去播放自定义的navigate过场动画trans */
extern NSString * const KKNotiGotoPlayTransNoti;

/** 通知消息类型：切换账号的类型key */
extern NSString * const kKKNotiGotoLogoutTypeKey;

/** 通知消息类型的值：切换账号的类型的value: 用户选择退出账号 */
extern NSString * const KKNotiGotoLogoutTypeValueLogout;

/** 通知消息类型的值：切换账号的类型的value: 用户取消自动登录 */
extern NSString * const KKNotiGotoLogoutTypeValueCancelAutologin;

#pragma mark - 一些常量
/** 初始化失败的最大次数，超过这个次数，就直接回调给接入方  */
extern NSInteger const KKInitFailedMaxTime;

/** 悬浮球弹出动画持续时间  */
extern NSTimeInterval const KKFloatBallAnimationDuration;

/** 缩放动画持续时间  */
extern NSTimeInterval const KKNormalEnlargeAnimationDuration;

/** 登录动画持续时间  */
extern NSTimeInterval const KKNormalLoginAnimationDuration;

/** 自动登录动画持续时间  */
extern NSTimeInterval const KKAutoLoginAnimationDuration;


#pragma mark - result

/** 网络错误 code */
extern NSString * const kKKResultNetworkWrongCode;

/** 网络错误 msg */
extern NSString * const kKKResultNetworkWrongMsg;

/** 登录成功标示的key */
extern NSString * const kKKNotiLoginSuccessCodeKey;

/** 登录成功返回的数据的key：result对象，data是一个u */
extern NSString * const kKKNotiLoginSuccessResultKey;

/** 通知：制服出结果 */
extern NSString * const KKNotiSettleBillResultNoti;

/** 制服结果code的key */
extern NSString * const kKKNotiSettleBillCodeKey;

/** 制服结果res的key */
extern NSString * const kKKNotiSettleBillResKey;

/** 播放自定制navigate过场动画的key */
extern NSString * const KKNotiPlayTransKey;

/** 发送通知 */
static inline void KKNotiPost(NSString * const noti_name, NSDictionary *userInfo) {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:noti_name object:NULL userInfo:userInfo];
}

/** 移除通知 */
static inline void KKNotiRemove(NSString * const noti_name, id from_obj) {
    
    [[NSNotificationCenter defaultCenter] removeObserver:from_obj name:noti_name object:NULL];
}

/** 发送登录成功的通知 */ //使用有点多
//static inline void KKNotiPostLoginSuccessNoti(KKResult * result) {
//    
//    KKNotiPost(KKNotiLoginSuccessNoti, @{
//                                         kKKNotiLoginSuccessCodeKey : @(1),
//                                         kKKNotiLoginSuccessResultKey : result,
//                                         });
//}


