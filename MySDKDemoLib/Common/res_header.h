#ifndef res_header_h

#define res_header_h

// 生成的.bundle文件的文件名
#define BundleName @"SDKBundle"

#define KK_ImageNamed(imageName) [UIImage imageNamed:[NSString stringWithFormat:@"%@.bundle/%@", BundleName, imageName]]



#define res_login_logo KK_ImageNamed(@"账号")
#define res_login_refresh KK_ImageNamed(@"刷新")
#define res_login_pwd KK_ImageNamed(@"密码")
#define res_login_delete KK_ImageNamed(@"删除")
#define res_back KK_ImageNamed(@"返回")

#define res_float_ball KK_ImageNamed(@"浮标")
#define res_float_ball_down KK_ImageNamed(@"浮标拖动")
#define res_float_bg KK_ImageNamed(@"背景4X4")
#define res_float_user KK_ImageNamed(@"个人中心")
#define res_float_user_down KK_ImageNamed(@"个人中心点击")
#define res_float_service KK_ImageNamed(@"客服")
#define res_float_service_down KK_ImageNamed(@"客服点击")
#define res_float_gl KK_ImageNamed(@"攻略")
#define res_float_gl_down KK_ImageNamed(@"攻略点击")
#define res_float_platform KK_ImageNamed(@"平台")
#define res_float_platform_down KK_ImageNamed(@"float30/平台点击")
#define res_float_hide KK_ImageNamed(@"隐藏")
#define res_float_hide_down KK_ImageNamed(@"隐藏点击")
#define res_float_split KK_ImageNamed(@"分割线")

#define res_bg_image KK_ImageNamed(@"边框")
















#endif
