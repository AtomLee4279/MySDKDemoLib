//
//  KKSdkFloatWebController.m
//  KoalaGameKit
//
//  Created by kaola  on 2018/3/15.
//  Copyright © 2018年 kaola . All rights reserved.
//

#import "KKSdkFloatWebController.h"

#import "KKUserHandler.h"

#import "UIView+ActivityIndicatorView.h"

/** 后台返回的“qq”后面包含QQ号的链接 */
static NSString * const LinkWithQQ = @"koala://qq//";

/*客户端自行拼接的跳转去QQ客户端的链接*/
static NSString * const LinkToQQ = @"mqq://im/chat?chat_type=wpa&uin=%@&version=1&src_type=web";

@interface KKSdkFloatWebController ()
@end

@implementation KKSdkFloatWebController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationController setNavigationBarHidden:YES];
    
    // 清除缓存
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    
    // 自适应高度
    self.isFitWebHeight = YES;
    
    if (!self.webUrlString.length) {
        [KKToast kk_showToast:@"url为空，无法加载..."];
        weakSelf();
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.navigationController dismissViewControllerAnimated:YES completion:NULL];
        });
        return;
    }
    
    [self loadWebWithUrlString:self.webUrlString];
    self.webView.dataDetectorTypes = UIDataDetectorTypeAll;
    
    weakSelf();
    // 处理切换账号事件
    void(^jsHandleBlock)(NSArray *ags) = ^ (NSArray *ags) {

        DBLog(@"js中，当前线程：%@", [NSThread currentThread]);
        
        // js中是子线程执行的
        // ios9.x情况下，会崩溃；更高版本的系统貌似没事。。不会崩溃。。
        dispatch_async(dispatch_get_main_queue(), ^{
            
            DBLog(@"当前线程 -- 主线程：%@", [NSThread currentThread]);
            
            [weakSelf dismissViewControllerAnimated:NO completion:NULL];
            
            // 去切换账号
            DBLog(@"去切换账号");
            KKNotiPost(KKNotiGotoLogoutNoti, @{
                                               kKKNotiGotoLogoutTypeKey : KKNotiGotoLogoutTypeValueLogout,
                                               });
        });
    };
    self.jsFunctionHandlers = @{
                                @"logout" : jsHandleBlock,
                                };
    
    // 处理立即进入游戏，和保存用户名和密码事件
    self.jsObjectHandlers = @{
                                @"WebJs" : self,
                                };
}

#pragma mark - js export
/** 关闭这个web  */
- (void)close {
    
    DBLog(@"web : 立即进入游戏");
    
    if (self.navigationController) {
        
        [self.navigationController dismissViewControllerAnimated:YES completion:NULL];
    }
    else {
        
        [self dismissViewControllerAnimated:YES completion:NULL];
    }
    
}

/** 保存用户名和密码  */
- (void)SavePwd:(NSString *)user :(NSString *)pass :(NSString *)uid {
    
    DBLog(@"web : 保存用户名和密码");
    
    [KKUserHandler sharedHandler].username = user;
    [KKUserHandler sharedHandler].pwd = pass;
    [[KKUserHandler sharedHandler] saveUser];
}

#pragma mark - UIWebViewDelegate
//@optional
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    DBLog(@"--- shouldStartLoadWithRequest:{%@}", request.URL.absoluteString);
    
    // 清除缓存
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    
    [self.webView kk_startAnimating];
    
    if ([[request.URL scheme] isEqualToString:@"tel"]) {
        
        [self.webView kk_stopAnimating];
    }
    //点击了qq号码的一系列操作
    NSRange range = [request.URL.absoluteString rangeOfString:LinkWithQQ];
    if (range.location == NSNotFound) {
    } else {
        //用来接收临时消息的客服QQ号码(注意此QQ号需开通QQ推广功能,否则陌生人向他发送消息会失败)
        NSString *QQ = [request.URL.absoluteString substringFromIndex:(range.location)+(range.length)];
        NSString *url = [NSString stringWithFormat:LinkToQQ,QQ];
        // 这里不判断了：因为有些cp可能不愿意添加白名单，不管添没添加，都让他跳吧。
//        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:url]]){
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
//        }
        [self.webView kk_stopAnimating];
        return NO;
    }
    if ([request.URL.absoluteString isEqualToString:@"koala://close"]) {

        if (self.navigationController) {
            
            [self.navigationController dismissViewControllerAnimated:YES completion:NULL];
        } else {
            
            [self dismissViewControllerAnimated:YES completion:NULL];
        }
        [self.webView kk_stopAnimating];
        return NO;
    }
    else if ([request.URL.absoluteString isEqualToString:@"koala://back"]) {
        
        if (self.navigationController) {
            [self.navigationController popViewControllerAnimated:YES];
        }
        else {
            [self dismissViewControllerAnimated:YES completion:NULL];
        }
        
        return NO;
    }
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
