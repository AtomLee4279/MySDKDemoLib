//
//  MySDKInitData.h
//  MySDKDemoKit
//
//  Created by 李一贤 on 2018/9/13.
//  Copyright © 2018年 李一贤. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MySDKInitData : NSObject

@property(copy, nonatomic) NSString *customer_qq;
@property(copy, nonatomic) NSString *fpwd; // 3.0之后返回“帮助”+锚点
//2.0另增的忘记密码url字段 ： 应该是没有返回，也没有用到
@property(copy, nonatomic) NSString *forgotpwd;
@property(copy, nonatomic) NSString *is_test;
/** 是否开启浮点，1开启，0不开启  */
@property(copy, nonatomic) NSString *open_float;
@property(copy, nonatomic) NSString *sessid;
@property(copy, nonatomic) NSString *token;
@property(copy, nonatomic) NSString *xieyi;
@property(copy, nonatomic) NSString *help;
@property(copy, nonatomic) NSString *privacy;
@property(copy, nonatomic) NSString *comp_name;
@property(copy, nonatomic) NSString *plat_url;


/** fr中所有的logo用这个  */
@property(copy, nonatomic) NSString *logo_img;

/** 悬浮球的图片  */
@property(copy, nonatomic) NSString *float_img;

/** 攻略  */
@property(copy, nonatomic) NSString *strategy_site;

/** fr中下载完成的logo的image  */
@property(strong, nonatomic) UIImage *logoImage;

@end
