//
//  KKMacros.h
//  KoalaGameKit
//
//  Created by kaola  on 2018/3/6.
//  Copyright © 2018年 kaola . All rights reserved.
//

#ifndef KKMacros_h
#define KKMacros_h
// 1. 安卓；2. iOS；旧版传1，这里暂时传1吧，等后台通知
#define KKDeviceTYPE  @"1"


#define weak(obj, weakName) __weak typeof(obj) weakName = obj
#define weakSelf() weak(self, weakSelf)

/* 角度转弧度 */
#define KK_DEGREES_TO_RADIANS(angle) \
((angle) / 180.0 * M_PI)

// 几个节省代码的宏
#define KK_ReturnProperty(_propName, codes) if (_propName) { \
return _propName;\
}\
codes;\
return _propName;

#define KK_CreateProperty(_propName, ClsName) _propName = [ClsName new];

#define KK_ReturnPropertyInstance(_propName, ClsName, codes) KK_ReturnProperty(_propName, {KK_CreateProperty(_propName, ClsName);codes;})

static inline void KKSetupProperty(id prop, void(^block)(id prop)) {
    
    block(prop);
}

#define KK_MakeAndReturnPropertyInstance(_propName, ClsName, block) KK_ReturnPropertyInstance(_propName, ClsName, KKSetupProperty(_propName, block))


#endif /* KKMacros_h */
