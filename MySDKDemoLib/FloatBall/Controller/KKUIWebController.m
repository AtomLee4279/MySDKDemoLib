//
//  KKUIWebController.m
//  KoalaGameKit
//
//  Created by kaola  on 2018/3/10.
//  Copyright © 2018年 kaola . All rights reserved.
//

#import "KKUIWebController.h"

//#import "UIView+ActivityIndicatorView.h"
//#import "UIView+BlurEffect.h"

#import <JavaScriptCore/JavaScriptCore.h>
#import <Masonry.h>

@interface KKUIWebController () {
    
    UIWebView *_webView;
    UIView * _Nonnull _containerView;
    UIButton *_backBtn;
}

/** 缓存web的高度：目前其实不用缓存了，后面再去掉～  */
@property(nonatomic, strong) NSMutableDictionary<NSString *, NSNumber *> *webHeightsM;

@end

@implementation KKUIWebController

- (void)dealloc {
    
    DBLog(@"----- delloc --[%@]--", self.class);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupViews];
}

- (void)setupViews {
    
    self.view.backgroundColor = [UIColor clearColor];
    self.containerView.backgroundColor = [UIColor clearColor];
    self.webView.backgroundColor = [UIColor clearColor];
    self.webView.opaque = false;
    
    // 设置webview的所有子view的背景色为clear
    for (UIView *scrol in self.webView.subviews) {
        Class ScrollCls = NSClassFromString(@"_UIWebViewScrollView");
        Class Cls = NSClassFromString(@"UIWebBrowserView");
        if ([scrol isKindOfClass:ScrollCls]) {
            for (UIView *sub in scrol.subviews) {
                if ([sub isKindOfClass:Cls]) {
                    sub.backgroundColor = [UIColor clearColor];
                }
            }
        }
    }
    
    weakSelf();
    CGFloat tableH = [self kk_webHeightNeeded];
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        
//        make.leading.top.trailing.equalTo(weakSelf.view);
//        make.height.mas_equalTo([weakSelf kk_webHeightNeeded]);
        make.leading.trailing.equalTo(weakSelf.view);
        make.centerY.equalTo(weakSelf.view);
        make.height.mas_equalTo(tableH);
    }];
    
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(weakSelf.containerView);
    }];
    
    self.webView.scrollView.bounces = NO;
    self.webView.scalesPageToFit = YES;
    self.containerView.layer.masksToBounds = YES;
    self.containerView.layer.cornerRadius = 10.f;
}

- (void)backBtnDidClick:(UIButton *)btn {
    
    if (self.backBtnDidClickAction) {
        self.backBtnDidClickAction(btn);
    }
}

/** 设置web需要展示的高度  */
- (CGFloat)kk_webHeightNeeded; {
    
    // web并没有很好的适应界面，如果高度过大，web不会自适应
    return IS_PAD ? KKWIDTH(100.f) : KKMainViewHeight();
}

/**
 加载网页
 
 @param urlstring url string
 */
- (void)loadWebWithUrlString:(NSString *)urlstring {
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlstring] cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:10.f];
    [self.webView loadRequest:request];
    self.webView.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIWebViewDelegate
//@optional
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    DBLog(@"--- shouldStartLoadWithRequest:{%@}", request.URL.absoluteString);

    [self.webView kk_startAnimating];
    
    if (self.webViewShouldStartLoadWithRequestAction) {
        return self.webViewShouldStartLoadWithRequestAction(webView, request, navigationType);
    }
    
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    
    DBLog(@"--- webViewDidStartLoad:{%@}", webView.request.URL.absoluteString);
    
    [self.webView kk_startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    DBLog(@"--- webViewDidFinishLoad: {%@}", webView.request.URL.absoluteString);
    
    [self.webView kk_stopAnimating];
    
    // 跟新高度
    [self kk_setupWebHeightWithWebView:webView];
    
    // 注入不响应长按的JS方法
    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitTouchCallout='none';"];
    
    [self setupJSHandlersWithWebView:webView];
    [self setupJSObjectsWithWithWebView:webView];
    
//    for (UIView *scrol in self.webView.subviews) {
//        DBLog(@"web view sub view: %@", scrol);
//        Class ScrollCls = NSClassFromString(@"_UIWebViewScrollView");
//        Class Cls = NSClassFromString(@"UIWebBrowserView");
//        if ([scrol isKindOfClass:ScrollCls]) {
//            for (UIView *sub in scrol.subviews) {
//                DBLog(@"web view sub: %@", sub);
//                if ([sub isKindOfClass:Cls]) {
//                    sub.backgroundColor = [UIColor clearColor];
//                    for (CALayer *lay in sub.layer.sublayers) {
//                        lay.backgroundColor = [UIColor clearColor].CGColor;
//                    }
//                }
//            }
//        }
//    }
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
    DBLog(@"--- didFailLoadWithError: error: {%@}", error);
    
    [self.webView kk_stopAnimating];
}

#pragma mark - methods

/** 更新web的高度  */
- (void)kk_setupWebHeightWithWebView:(UIWebView *)webView {
    
    if (!self.isFitWebHeight) {
        return;
    }
    
    CGFloat oldHeight = [[self.webHeightsM objectForKey:webView.request.URL.absoluteString] floatValue];
    if (oldHeight) {
        
        // 取得缓存中的web高度
        [self kk_updateWebHeightWithWebHeight:oldHeight];
        return;
    }
    
    // 获取web view的高度：这个可以获取自适应高度
    CGFloat webHeight = [[self.webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight"] floatValue];
    DBLog(@"获得web的高度：%@", @(webHeight));
    if (webHeight != [self kk_webHeightNeeded]) {
        
        // 如果是横屏，且高度大于最大高度，高度就要设置为最大高度
        if (!UIScreenIsPortrait() && (webHeight > KKMainViewLandscapeMaxHeight())) {
            
            webHeight = KKMainViewLandscapeMaxHeight();
        }
        else if (UIScreenIsPortrait() && (webHeight > (Screen_Height - KKHEIGHT(120.f)))) {
            
            // 如果是竖屏，web高度太高（超出了屏幕），则高度变为：
            webHeight = (Screen_Height - KKHEIGHT(120.f));
        }
        
        // 更新高度
        [self kk_updateWebHeightWithWebHeight:webHeight];
    }
    
    if (webHeight) {
        
        // 缓存高度
        [self.webHeightsM setObject:@(webHeight) forKey:webView.request.URL.absoluteString];
    }
}

/** 跟新高度  */
- (void)kk_updateWebHeightWithWebHeight:(CGFloat)webHeight {
    
    // 更新web的高度
    [self.containerView mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.height.mas_equalTo(webHeight);
    }];
    
    weakSelf();
    [UIView animateWithDuration:.3f animations:^{
        
        [weakSelf.containerView layoutIfNeeded];
        
    } completion:^(BOOL finished) {
        
        // 如果高度大于最高的container高度，并且是竖屏，发出要更新高度的通知（竖屏里面最高的是注册界面（原生的注册页面））
        // 如果是横屏，最大高度已经不能改变了（横屏最大能展示的高度）
        if (UIScreenIsPortrait() && (webHeight > KKMainViewPortraitMaxHeight())) {
            
            // 去更新高度
            NSDictionary *usrinfo = @{
                                      @"is_portrait" : @(1),
                                      @"height"   : @(webHeight),
                                      };
//            KKNotiPost(KKNotiUpdateWindowHeightNoti, usrinfo);
        }
    }];
}

/** 注入对象  */
- (void)setupJSObjectsWithWithWebView:(UIWebView *)webView {
 
    if (!self.jsObjectHandlers) {
        return;
    }
    
    JSContext *context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    
    [self.jsObjectHandlers enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull jsObjName, id<JSExport>  _Nonnull ocObj, BOOL * _Nonnull stop) {
        
        context[jsObjName] = ocObj;
    }];
}

/** 注入方法  */
- (void)setupJSHandlersWithWebView:(UIWebView *)webView {
    
    if (!self.jsFunctionHandlers) {
        return;
    }
    
    JSContext *context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    
    [self.jsFunctionHandlers enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull jsFuncName, void (^ _Nonnull jsFuncBlock)(NSArray *), BOOL * _Nonnull stop) {
        
        context[jsFuncName] = ^{
            
            NSArray *arg = [JSContext currentArguments];
            DBLog(@"%@ ags : %@", jsFuncName, arg);
            
            if (jsFuncBlock) {
                // 这里是子线程执行的哦～
                jsFuncBlock(arg);
            }
        };
    }];
}


#pragma mark - Getter & Setter
- (UIWebView *)webView {
    
    if (_webView) {
        return _webView;
    }
    
    _webView = [[UIWebView alloc] init];
    [self.containerView addSubview:_webView];
    
    return _webView;
}

- (UIButton *)backBtn {
    
    weakSelf();
    KK_MakeAndReturnPropertyInstance(_backBtn, UIButton, ^(UIButton *prop) {
        
        [weakSelf.containerView addSubview:prop];
        [prop setImage:res_back forState:UIControlStateNormal];
        prop.contentMode = UIViewContentModeScaleAspectFit;
        
        [prop mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.leading.equalTo(weakSelf.containerView).offset(KKWIDTH(20.f));
            make.centerY.equalTo(weakSelf.webView.mas_top).offset(KKHEIGHT(25.f));
            make.size.mas_equalTo(CGSizeMake(KKWIDTH(25.f), KKHEIGHT(25.f)));
        }];
        [prop addTarget:self action:@selector(backBtnDidClick:) forControlEvents:UIControlEventTouchUpInside];
    });
}

- (UIView *)containerView {
    
    weakSelf();
    KK_MakeAndReturnPropertyInstance(_containerView, UIView, ^(UIView *prop) {
        
        [prop blurEffectWithStyle:UIBlurEffectStyleExtraLight];
        [weakSelf.view addSubview:prop];
    });
}

- (NSMutableDictionary<NSString *,NSNumber *> *)webHeightsM {
    
    if (_webHeightsM) {
        return _webHeightsM;
    }
    
    _webHeightsM = [NSMutableDictionary<NSString *,NSNumber *> dictionary];
    
    return _webHeightsM;
}

@end
