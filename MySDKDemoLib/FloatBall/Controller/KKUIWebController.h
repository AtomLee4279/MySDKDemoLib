//
//  KKUIWebController.h
//  KoalaGameKit
//
//  Created by kaola  on 2018/3/10.
//  Copyright © 2018年 kaola . All rights reserved.
// UIWebView controller

#import <UIKit/UIKit.h>
#import <JavaScriptCore/JavaScriptCore.h>

@interface KKUIWebController : UIViewController <UIWebViewDelegate>

@property(nonatomic, strong, readonly) UIWebView *webView;
@property(nonatomic, strong, readonly) UIButton *backBtn;
@property(nonatomic, copy) void(^backBtnDidClickAction)(UIButton *btn);

/** 是否自适应web view的高度; 默认是NO  */
@property(nonatomic, assign) BOOL isFitWebHeight;

/** web load之前的判断  */
@property(nonatomic, copy) BOOL (^webViewShouldStartLoadWithRequestAction)(UIWebView *web, NSURLRequest *request, UIWebViewNavigationType navigationType);

/** 包裹 view，白色背景，有圆角  */
@property(nonatomic, strong, readonly) UIView * _Nonnull containerView;

/** js中对应的方法注入：在子线程执行的～ */
@property(nonatomic, copy) NSDictionary<NSString *, void(^)(NSArray *arguments)> *jsFunctionHandlers;

/** js中注入对象 */
@property(nonatomic, copy) NSDictionary<NSString *, id<JSExport>> *jsObjectHandlers;

/**
 加载网页
 
 @param urlstring url string
 */
- (void)loadWebWithUrlString:(NSString *)urlstring;

/** 设置web需要展示的高度  */
- (CGFloat)kk_webHeightNeeded;

/** 给子views添加约束，使用默认的约束就使用【super setupViews】 调用  */
- (void)setupViews;

@end
