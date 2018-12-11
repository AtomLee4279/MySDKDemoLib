//
//  AccountLoginViewController.m
//  SDKBundle
//
//  Created by 李一贤 on 2018/12/9.
//  Copyright © 2018 李一贤. All rights reserved.
//

#import "AccountRegisterViewController.h"
#import "AccountLoginViewController.h"
#import "AutoLoginController.h"
#import "TitleViewCell.h"
#import "InputViewCell.h"
#import "AgreementCell.h"
#import "CreateAccountCell.h"
#import "LoginBtnCell.h"

#import "FloatBallController.h"
#import "FloatLeftExtendView.h"
#import "FloatRightExtendView.h"
#import "KKFloatCollectView.h"



@interface AccountLoginViewController ()

@property(nonatomic, strong) FloatBallController *floatVc;

@property(nonatomic,strong) KKSwitchAccountsView *switchAccountsView;

@end

@implementation AccountLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self regNib];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

/**
 *  注册nib
 */
- (void)regNib {
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"SDKBundle" ofType:@"bundle"];
    NSBundle *SDKBundle = [NSBundle bundleWithPath:path];
    [self.tableView registerNib:[UINib nibWithNibName:@"TitleViewCell" bundle:SDKBundle] forCellReuseIdentifier:@"TitleViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"InputViewCell" bundle:SDKBundle] forCellReuseIdentifier:@"InputViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"AgreementCell" bundle:SDKBundle] forCellReuseIdentifier:@"AgreementCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"CreateAccountCell" bundle:SDKBundle] forCellReuseIdentifier:@"CreateAccountCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"LoginBtnCell" bundle:SDKBundle] forCellReuseIdentifier:@"LoginBtnCell"];
    
}
    

#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 6;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row==0) {
        Class cls = [TitleViewCell class];
        TitleViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"TitleViewCell"];
        cell.backBtn.hidden = YES;
        cell.titleLabel.text = @"用户登录";
        return cell;
    }
//
    if (indexPath.row==1) {
        Class cls = [InputViewCell class];
        InputViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"InputViewCell"];

        UIImage *logo = [UIImage imageNamed:[NSString stringWithFormat:@"%@.bundle/%@", @"SDKBundle", @"账号"]];
        UIImage *btnImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@.bundle/%@", @"SDKBundle", @"下拉"]];
        cell.logo.image = logo;
        [cell.rightBtn setImage:btnImage forState:UIControlStateNormal];
        [cell.rightBtn addTarget:self action:@selector(historyAccount:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
//
    if (indexPath.row==2) {
        Class cls = [InputViewCell class];
        InputViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"InputViewCell"];
        UIImage *logo = [UIImage imageNamed:[NSString stringWithFormat:@"%@.bundle/%@", @"SDKBundle", @"密码"]];
        UIImage *btnImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@.bundle/%@", @"SDKBundle", @"删除"]];
        cell.logo.image = logo;
        [cell.rightBtn setImage:btnImage forState:UIControlStateNormal];
        [cell.rightBtn addTarget:self action:@selector(showPwd:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
////    注册新账号
    if (indexPath.row==3) {
        Class cls = [CreateAccountCell class];
        CreateAccountCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CreateAccountCell"];
        [cell.createAccountBtn addTarget:self action:@selector(newAccount:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
//隐私政策：约束待调整
    if (indexPath.row==4) {
        Class cls = [AgreementCell class];
        AgreementCell * cell = [tableView dequeueReusableCellWithIdentifier:@"AgreementCell"];
        [cell.checkBtn addTarget:self action:@selector(checkBtnDidClick:) forControlEvents:UIControlEventTouchUpInside];
        [cell.detailBtn addTarget:self action:@selector(detailBtnDidClick:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }

    if (indexPath.row==5) {
        Class cls = [LoginBtnCell class];
        LoginBtnCell * cell = [tableView dequeueReusableCellWithIdentifier:@"LoginBtnCell"];
        [cell.loginBtn addTarget:self action:@selector(loginBtnDidClick:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
    return [UITableViewCell new];
}



- (void)historyAccount:(UIButton *)btn {
    
    NSLog(@"===historyAccount===");
}

- (void)showPwd:(UIButton *)btn {
    
    NSLog(@"===showPwd===");
    
}

- (void)newAccount:(UIButton *)btn {
    
    NSLog(@"===newAccount===");
    UIViewController *viewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    NSString *path = [[NSBundle mainBundle] pathForResource:@"SDKBundle" ofType:@"bundle"];
    NSBundle *SDKBundle = [NSBundle bundleWithPath:path];
    
    AccountRegisterViewController *baseVC = [[AccountRegisterViewController alloc] initWithNibName:@"AccountRegisterView" bundle:SDKBundle];
    [baseVC setModalTransitionStyle:(UIModalTransitionStyleFlipHorizontal)];
    [baseVC setModalPresentationStyle:UIModalPresentationCustom];
    
    [self dismissViewControllerAnimated:YES completion:^{
        [viewController presentViewController:baseVC animated:YES completion:nil];
    }];
}

- (void)checkBtnDidClick:(UIButton *)btn {
    
    NSLog(@"===checkBtnDidClick===");
}


- (void)detailBtnDidClick:(UIButton *)btn {
    
    NSLog(@"===detailBtnDidClick===");
    btn.selected = !btn.selected;
    [self swtchBtnDidClick:btn]; // 按钮小动画
    DBLog(@"切换账号");
    if (btn.isSelected) {
        
        [self.view addSubview:self.switchAccountsView];
        KKSwitchAccountsView *switchView = self.switchAccountsView;
        switchView.layer.anchorPoint = CGPointMake(0.5f, 0.f);
        self.switchAccountsView.layer.transform = CATransform3DMakeScale(1.f, 0.1f, 0.f);
        
        [UIView animateWithDuration:.3f animations:^{
            
            switchView.layer.transform = CATransform3DMakeAffineTransform(CGAffineTransformIdentity);
            
        } completion:^(BOOL finished) {
            
            DBLog(@"切换账号 动画做完了");
            switchView.transform = CGAffineTransformIdentity;
        }];
    }
    else {
        KKSwitchAccountsView *switchView = self.switchAccountsView;
        switchView.layer.transform = CATransform3DMakeScale(1.f, 1.f, 0.f);
        [UIView animateWithDuration:.3f animations:^{
            
            switchView.layer.transform = CATransform3DMakeScale(1.f, 0.01f, 0.f);
            
        } completion:^(BOOL finished) {
            
            DBLog(@"切换账号 动画做完了");
            [switchView removeFromSuperview];
        }];
    }
}
 
    


- (void)swtchBtnDidClick:(UIButton *)btn {
    
    [UIView animateWithDuration:.3f animations:^{
        
        if (CATransform3DIsIdentity(btn.layer.transform)) {
            btn.layer.transform = CATransform3DMakeRotation(M_PI - 0.001, 0, 0, 50);
        }
        else {
            
            btn.layer.transform = CATransform3DIdentity;
        }
        
    } completion:^(BOOL finished) {
        
        DBLog(@"小三角转动 动画做完了");
    }];
}

- (void)loginBtnDidClick:(UIButton *)btn {
    
    NSLog(@"===loginBtnDidClick===");
    
    [self dismissViewControllerAnimated:YES completion:^{
    
        [self autoLoginWithVC:nil];
    }];
}

-(void)autoLoginWithVC:(UIViewController* _Nullable)vc{
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"SDKBundle" ofType:@"bundle"];
    NSBundle *SDKBundle = [NSBundle bundleWithPath:path];
    
    AutoLoginController * autoVC = [[AutoLoginController alloc] initWithNibName:@"AutoLoginView" bundle:SDKBundle];
    [autoVC setModalPresentationStyle:UIModalPresentationCustom];
    
    UIViewController *rootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    [rootVC presentViewController:autoVC animated:YES completion:nil];
    
    
}

/**
 配置悬浮球
 
 @param viewController vc
 @param isRememberFloatBallLocation 是否记住悬浮球的位置
 */
- (void)setupFloatBallWtihViewController:(UIViewController *)viewController isRememberFloatBallLocation:(BOOL)isRememberFloatBallLocation floatBallInitStyle:(FloatBallStyle)floatBallInitStyle {
    
    // 先看看vc里面有没有这个悬浮球，如果有，就先去掉
    for (UIViewController *vc in viewController.childViewControllers) {
        
        if ([vc isKindOfClass:[FloatBallController class]]) {
            
            FloatBallController *floatVcOLD = (FloatBallController *)vc;
            [floatVcOLD removeTheFloatBall];
        }
    }
    
    // 添加并设置悬浮球
    self.floatVc =
    [FloatBallController fetchFloatBallControllerWithViewController:viewController
                                                             height:KKHEIGHT(60.f)
                                                       interPadding:KKHEIGHT(0.f)
                                              isRemberUserOperation:isRememberFloatBallLocation
                                                         userPrefix:@"a"
                                                     initFloatStyle:floatBallInitStyle];
    // 设置悬浮球的图片
    [self.floatVc.floatView.floatBtn kk_setBackgroundImageWithURLString:nil forState:UIControlStateNormal placeholderImage: res_float_ball];
    [self.floatVc.floatView.floatBtn kk_setBackgroundImageWithURLString:nil forState:UIControlStateHighlighted placeholderImage: res_float_ball_down];
    // 想要等待的时间，减去2；比如想要等9s，就赋值为7
    self.floatVc.floatView.waitTimeInterval = 7.f;
    
    NSArray *float_menu = [KKUserHandler sharedHandler].float_menu;
    NSMutableArray *items = [NSMutableArray array];
    for (KKUserFloat *flo in float_menu) {
        [items addObject:[KKFloatItem floatItemWithIcon:flo.icon highlightIcon:flo.highlightIcon actionTag: flo.tag]];
    }
    
//    [self kk_setupFloatExtendViewsWithItems: items];
}

/**
 设置悬浮球的extend views: 每个按钮都增加一个开关，可以控制任意个按钮的开启和隐藏
 */
- (void)kk_setupFloatExtendViewsWithItems:(NSArray<KKFloatItem *> *)items {
    
    NSInteger itemCount = items.count;
    
    if (itemCount == 0) {
        return;
    }
    
    weakSelf();
    KKFloatCollectView *leftExtend = [KKFloatCollectView collectionViewWithOrderLeft:YES floatItems:items];
    CGSize leftSize = [KKFloatCollectView viewSizeWithModel:items];
    leftExtend.frame = CGRectMake(0, 0, leftSize.width, leftSize.height);
    
    weak(self.floatVc, weakFloat);
    [leftExtend setDidSelectItemAtIndexPathAction:^(KKFloatCollectView *view, NSInteger index, UIButton *btn) {
        [weakSelf setupExtendBtnActionsWithButtonIndex:index btn:btn floatVc:weakFloat];
    }];
    self.floatVc.leftExtendView = leftExtend;
    
    KKFloatCollectView *rightExtend = [KKFloatCollectView collectionViewWithOrderLeft:NO floatItems:items];
    CGSize rightSize = [KKFloatCollectView viewSizeWithModel:items];
    rightExtend.frame = CGRectMake(0, 0, rightSize.width, rightSize.height);
    self.floatVc.rightExtendView = rightExtend;
    [rightExtend setDidSelectItemAtIndexPathAction:^(KKFloatCollectView *view, NSInteger index, UIButton *btn) {
        
        [weakSelf setupExtendBtnActionsWithButtonIndex:index btn:btn floatVc:weakFloat];
    }];
}

/**
 设置悬浮球的extend views: 设置三个按钮
 */
- (void)kk_setupOldFloatExtendViews {
    
    weakSelf();
    FloatLeftExtendView *leftExtend = [FloatLeftExtendView new];
    CGSize leftSize = [FloatLeftExtendView viewHeightWithModel:NULL];
    leftExtend.frame = CGRectMake(0, 0, leftSize.width, leftSize.height);
    
    weak(self.floatVc, weakFloat);
    [leftExtend setExtendBtnsDidClickAction:^(NSInteger buttonIdx, UIButton *btn) {
        
        [weakSelf setupExtendBtnActionsWithButtonIndex:buttonIdx btn:btn floatVc:weakFloat];
    }];
    self.floatVc.leftExtendView = leftExtend;
    
    FloatRightExtendView *rightExtend = [FloatRightExtendView new];
    CGSize rightSize = [FloatRightExtendView viewHeightWithModel:NULL];
    rightExtend.frame = CGRectMake(0, 0, rightSize.width, rightSize.height);
    self.floatVc.rightExtendView = rightExtend;
    [rightExtend setExtendBtnsDidClickAction:^(NSInteger buttonIdx, UIButton *btn) {
        
        [weakSelf setupExtendBtnActionsWithButtonIndex:buttonIdx btn:btn floatVc:weakFloat];
    }];
}

/** 设置btns的点击事件处理  */
- (void)setupExtendBtnActionsWithButtonIndex:(KKFloatItemActionTag)buttonIdx btn:(UIButton *)btn floatVc:(FloatBallController *)floatVc  {
    return;
//    if (buttonIdx == KKFloatItemActionTagUserCenter) {
//
//        // 个人中心
//        [self requestSdkwebFloatUrlWithFtype:@"1" success:^(KKResult * _Nonnull result) {
//
//            // 去展示个人中心
//            KKSdkFloatWebController *webVc = [KKSdkFloatWebController new];
//            webVc.webUrlString = result.data;
//            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:webVc];
//            nav.modalPresentationStyle = UIModalPresentationCustom;
//            nav.transitioningDelegate = [Koala getInstance].loginTrans;
//            [[Koala getInstance].kk_gameVc presentViewController:nav animated:YES completion:nil];
//        }];
//    }
//    else if (buttonIdx == KKFloatItemActionTagService) {
//
//        // 客服
//        [self requestSdkwebFloatUrlWithFtype:@"2" success:^(KKResult * _Nonnull result) {
//
//            // 去展示客服
//            KKSdkFloatWebController *webVc = [KKSdkFloatWebController new];
//            webVc.webUrlString = result.data;
//            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:webVc];
//            nav.modalPresentationStyle = UIModalPresentationCustom;
//            nav.transitioningDelegate = [Koala getInstance].loginTrans;
//            [[Koala getInstance].kk_gameVc presentViewController:nav animated:YES completion:nil];
//        }];
//    }
//    else if (buttonIdx == KKFloatItemActionTagStrategy) {
//
//        // 展示攻略
//        [self requestSdkwebFloatUrlWithFtype:@"3" success:^(KKResult * _Nonnull result) {
//
//            KKStrategyController *webVc = [KKStrategyController new];
//            webVc.webUrlString = result.data;
//            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:webVc];
//            nav.modalPresentationStyle = UIModalPresentationCustom;
//            nav.transitioningDelegate = [Koala getInstance].loginTrans;
//            [[Koala getInstance].kk_gameVc presentViewController:nav animated:YES completion:nil];
//        }];
//
//    }
//    else if (buttonIdx == KKFloatItemActionTagPlatform) {
//
//        if (![KKInitData new].plat_url.length) {
//            [KKToast kk_showToast:@"平台链接为空～"];
//            return;
//        }
//
//        //去展示平台
//        UIViewController *webVc = [self webViewControllerWithUrlString: [KKInitData new].plat_url];
//        weak(webVc, weakWeb);
//        [webVc setDoneBtnDidClickAction:^{
//
//            [weakWeb dismissViewControllerAnimated:YES completion:NULL];
//        }];
//        [[Koala getInstance].kk_gameVc presentViewController:webVc animated:YES completion:NULL];
//    }
//    else if (buttonIdx == KKFloatItemActionTagHide) {
//
//        // 隐藏悬浮球
//        [self removeFloatBallAction];
//    }
}

/**
 获取个人中心/客服/攻略web的网址
 
 @param ftype 个人中心是1；客服是2，攻略是3；
 */
//- (void)requestSdkwebFloatUrlWithFtype:(NSString *)ftype success:(KKCompletionHandler)success {
//
//    KKSdkWebFloatParam *param = [KKSdkWebFloatParam new];
//    param.ftype = ftype;
//
//    [KKNetworking kk_requestSdkWebFloatWithParameters:param success:^(KKResult * _Nullable result) {
//
//        if (result.isSucc) {
//
//            if (success) {
//                success(result);
//            }
//        }
//        else {
//
//            [KKToast kk_showToast:result.msg];
//        }
//
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error) {
//
//        DBLog(@"获取个人中心/客服/攻略/web的网址时，出错：%@", error);
//        [KKToast kk_showToast:error.localizedDescription];
//    }];
//}



- (KKSwitchAccountsView *)switchAccountsView {
    
    _switchAccountsView = [self kk_initSwitchViewInstance];
    
    NSMutableArray *userM = [KKUserHandler kk_fetchAllLoginedUsernames];
    if (userM.count && [userM.firstObject isEqualToString:self.accountCell.textFieldView.textField.text]) {
        [userM removeObjectAtIndex:0];
    }
    _switchAccountsView.dataSource = userM;
    
    CGRect cellRect = [self.accountCell convertRect:self.accountCell.textFieldView.frame toView:self.view];
    CGFloat viewW = cellRect.size.width;
    NSInteger hCount = userM.count <= 3 ? (userM.count ? userM.count : 1) : 3;
    CGFloat viewH = KKHEIGHT(KKSwitchAccountsCellHeight) * hCount;
    _switchAccountsView.frame = CGRectMake(cellRect.origin.x, CGRectGetMaxY(cellRect), viewW, viewH);
    
    return _switchAccountsView;
}

- (KKSwitchAccountsView *)kk_initSwitchViewInstance {
    
    __block __weak typeof(self) weakSelf = self;
    
    KK_MakeAndReturnPropertyInstance(_switchAccountsView, KKSwitchAccountsView, ^(KKSwitchAccountsView *prop){
        
        [prop setDelBtnDidClickAction:^(NSString *account) {
            
            // 清除账号信息
//            DBLog(@"清除账号信息：%@", account);
            NSError *error = nil;
            [KKUserHandler kk_removeTheUserWithAccount:account error:&error];
            if (error) {
//                DBLog(@"清除账号出错：%@", error);
            }
        }];
        
        [prop setDidSelectRowAtIndexPathAction:^(NSIndexPath *indexPath, NSString *account) {
            
            // 切换到这个账号
//            DBLog(@"切换到这个账号：%@", indexPath);
            [weakSelf.accountCell.textFieldView.tailBtn sendActionsForControlEvents:UIControlEventTouchUpInside];
            weakSelf.accountCell.textFieldView.textField.text = account;
            weakSelf.pwdCell.textFieldView.textField.text = [KKUserHandler kk_fetchPwdFromKeychainWithUsername:account];
            [weakSelf loginAccountWithBtn:weakSelf.accountCell.textFieldView.tailBtn success:^(KKResult * _Nonnull result) {
                
                // 发送登录成功通知
                KKNotiPostLoginSuccessNoti(result);
            }];
        }];
    })
}

@end

