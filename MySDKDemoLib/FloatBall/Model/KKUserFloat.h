//
//  KKUserFloat.h
//  KoalaGameKit
//
//  Created by 李一贤 on 2018/8/6.
//  Copyright © 2018年 kaola . All rights reserved.
//

//后台返回的用户浮点模型,额外加上本地对应的浮点配置

#import "KKFloatCollectView.h"
#import <Foundation/Foundation.h>

//“用户中心”
extern NSString *const KKFloatUser;
//“客服”
extern NSString *const KKFloatService;
//“攻略”
extern NSString *const KKFloatGongLue;
//平台
extern NSString *const KKFloatPlatform;
//"隐藏"
extern NSString *const KKFloatHide;

//客户端预设可以开启的浮点功能列表，用于筛选过滤后台返回的并不存在的浮点功能
#define FLOAT_CHECK @[KKFloatUser,KKFloatService,KKFloatGongLue, KKFloatPlatform,KKFloatHide]


@interface KKUserFloat : NSObject

////浮点功能名称
@property(nonatomic,copy)NSString *name;

//浮点开关
@property(nonatomic,copy)NSString *is_open;

//浮点icon
@property(nonatomic,copy) UIImage *icon;

//浮点被点击时icon
@property(nonatomic,copy) UIImage *highlightIcon;

//对应KKFloatCollectView.h里声明的枚举量 KKFloatItemActionTag
@property(nonatomic,assign) KKFloatItemActionTag tag;

//设置浮点的其他客户端配置属性
-(void)setFloatProperty;

@end
