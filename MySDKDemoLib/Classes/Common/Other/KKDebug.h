//
//  KKDebug.h
//  KoalaGameKit
//
//  Created by kaola  on 2018/3/5.
//  Copyright © 2018年 kaola . All rights reserved.
//

#ifndef KKDebug_h
#define KKDebug_h

// 打开或者关闭Debug Log: 生成动态库之前 测试用，不对外公开
#define OPEN_LOG @"主动关闭Log ： 把这一行注释掉"

#ifdef OPEN_LOG // 开启log
#define DBLog(fmt,...) NSLog((@"【方法名】：%s\n""#Koala DEBUG# " fmt), __func__, ##__VA_ARGS__)
#define NetLog(fmt,...) NSLog((@"【方法名】：%s\n""#Koala NET# " fmt),  __func__,##__VA_ARGS__)
#else // 关闭log
#define DBLog(fmt,...)
#define NetLog(fmt,...)
#endif

// 对外公开的log，由cp来决定是否打印（这里主要用于打印主要流程和必要的错误提示等）
extern BOOL DEBUG_FOR_CP;
#define KKLog(fmt,...) if (DEBUG_FOR_CP) NSLog((@"# === Koala log === # " fmt), ##__VA_ARGS__)


#endif /* KKDebug_h */
