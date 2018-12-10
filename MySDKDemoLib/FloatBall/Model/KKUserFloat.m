//
//  KKUserFloat.m
//  KoalaGameKit
//
//  Created by 李一贤 on 2018/8/6.
//  Copyright © 2018年 kaola . All rights reserved.
//

#import "KKUserFloat.h"
//用户中心
NSString *const KKFloatUser = @"userfloat";
//客服
NSString *const KKFloatService = @"servicefloat";
//攻略
NSString *const KKFloatGongLue = @"gongluefloat";
//平台
NSString *const KKFloatPlatform = @"orderfloat";
//隐藏
NSString *const KKFloatHide = @"hidefloat";





@implementation KKUserFloat



-(void)setFloatProperty
{
    
    if ([self.name isEqualToString:KKFloatUser]) {
        self.icon = res_float_user;
        self.highlightIcon = res_float_user_down;
        self.tag = KKFloatItemActionTagUserCenter;
    }
    else if ([self.name isEqualToString:KKFloatService]) {
        self.icon = res_float_service;
        self.highlightIcon = res_float_service_down;
        self.tag = KKFloatItemActionTagService;
    }
    else if ([self.name isEqualToString:KKFloatGongLue]) {
        self.icon = res_float_gl;
        self.highlightIcon = res_float_gl_down;
        self.tag = KKFloatItemActionTagStrategy;
    }
    else if ([self.name isEqualToString:KKFloatPlatform]) {
        self.icon = res_float_platform;
        self.highlightIcon = res_float_platform_down;
        self.tag = KKFloatItemActionTagPlatform;
    }
    else if ([self.name isEqualToString:KKFloatHide]) {
        self.icon = res_float_hide;
        self.highlightIcon = res_float_hide_down;
        self.tag = KKFloatItemActionTagHide;
    }
}

@end
