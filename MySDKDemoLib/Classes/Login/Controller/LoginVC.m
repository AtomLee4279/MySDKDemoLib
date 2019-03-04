//
//  LoginVC.m
//  MySDKDemoLib
//
//  Created by 李一贤 on 2019/1/1.
//  Copyright © 2019 李一贤. All rights reserved.
//

#import "LoginVC.h"
#import "TitleViewCell.h"
#import "InputViewCell.h"
#import "AgreementCell.h"
#import "CreateAccountCell.h"
#import "LoginBtnCell.h"
#import "HistoryAccountsCell.h"
#import "HistoryAccountsVC.h"
#import "AccountRegisterViewController.h"
#import "AutoLoginController.h"
#import <MJExtension.h>
#import "NSString+Sign.h"
#import "ParamsRegLogOn.h"
#import "MySDKConfig.h"

@interface LoginVC ()

@property(nonatomic,strong) InputViewCell *accountCell;

@property(nonatomic,strong) InputViewCell *pwdCell;

@property(nonatomic, assign) BOOL isCheckboxSelected;
@property(nonatomic,strong) AgreementCell *agreeMCell;
//展开历史账号的三角按钮
//@property(nonatomic,strong)  UIButton *switchBtn;

@end

@implementation LoginVC




-(void)viewDidLoad{
    [super viewDidLoad];
    [self setUpReg];
    self.isCheckboxSelected = YES;
    //开启和监听 设备旋转的通知（不开启的话，设备方向一直是UIInterfaceOrientationUnknown）
    if (![UIDevice currentDevice].generatesDeviceOrientationNotifications) {
        [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    }
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(handleDeviceOrientationChange:)
                                                name:UIDeviceOrientationDidChangeNotification object:nil];
}

-(void)setUpReg{
    
    regNib(self.tableView, @"TitleViewCell", @"TitleViewCell");
    regNib(self.tableView, @"InputViewCell", @"InputViewCell");
    regNib(self.tableView, @"CreateAccountCell", @"CreateAccountCell");
    regNib(self.tableView, @"AgreementCell", @"AgreementCell");
    regNib(self.tableView, @"LoginBtnCell", @"LoginBtnCell");
    
    
}

//设备方向改变的处理
- (void)handleDeviceOrientationChange:(NSNotification *)notification{
    UIDeviceOrientation deviceOrientation = [UIDevice currentDevice].orientation;
    switch (deviceOrientation) {
        case UIDeviceOrientationFaceUp:
            NSLog(@"屏幕朝上平躺");
            break;
        case UIDeviceOrientationFaceDown:
            NSLog(@"屏幕朝下平躺");
            break;
        case UIDeviceOrientationUnknown:
            NSLog(@"未知方向");
            break;
        case UIDeviceOrientationLandscapeLeft:
            NSLog(@"屏幕向左横置");
            break;
        case UIDeviceOrientationLandscapeRight:
            NSLog(@"屏幕向右橫置");
            break;
        case UIDeviceOrientationPortrait:
            NSLog(@"屏幕直立");
            break;
        case UIDeviceOrientationPortraitUpsideDown:
            NSLog(@"屏幕直立，上下顛倒");
            break;
        default:
            NSLog(@"无法辨识");
            break;
    }
}

- (void)historyAccount:(UIButton *)btn {
    
    NSLog(@"===historyAccount===");
//     self.switchBtn = btn;
     btn.selected = !btn.selected;
    //旋转按钮的动画
    [self rotateBtn:btn];
    //**if:点击状态：创建账号下拉框
    if (btn.selected) {
        HistoryAccountsVC *hisVC = [[HistoryAccountsVC alloc] initWithNibName:@"HistoryAccounts" bundle:SDKBundle];
        hisVC.delegate = self;
        UIView *containerView = [self.view viewWithTag:1000];
        //frame转换：得到inputField这个frame在LoginVC-containerView中的情况(x,y,w，h)
        CGRect cellRect = [self.accountCell convertRect:self.accountCell.inputField.frame toView:containerView];
        [self addChildViewController:hisVC];
        [self.view addSubview:hisVC.view];
        //设置hisVC的rootview与此父控制器rootView的约束关系
        CGFloat width = cellRect.size.width;
        CGFloat height = 100;
        [hisVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.center.equalTo(self.view);
//            make.width.equalTo(@(width));
//            make.height.equalTo(@(height));
            make.edges.equalTo(containerView);
        }];
        [hisVC.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.equalTo(@(width));
            make.height.equalTo(@(height));
            make.center.equalTo(hisVC.view);
        }];
        [hisVC didMoveToParentViewController:self];
    }
    //**else:非点击状态:删除账号下拉框
    else{
//        [self rotateBtn:btn];
        NSArray *array = self.childViewControllers;
        if ([array firstObject]&&[[array firstObject] isKindOfClass:[HistoryAccountsVC class]])
        {
            [[array firstObject] willMoveToParentViewController:nil];
            [[array firstObject] removeFromParentViewController];
            HistoryAccountsVC *tmpVC = [array firstObject];
            [tmpVC.view removeFromSuperview];
        }
    }
   
    
}


//按钮旋转动画
-(void)rotateBtn:(UIButton*)btn{
    //展开了历史账号下拉框，伴随的三角按钮旋转
    if (btn.selected) {
        [self rotateAnimateWithView:btn fromValue:[NSNumber numberWithFloat:0] toValue:[NSNumber numberWithFloat: M_PI] rotateWay:@"z"];
    }
    //收回账号下拉框伴随的按钮动画
    else{
        
         [self rotateAnimateWithView:btn fromValue:[NSNumber numberWithFloat:M_PI] toValue:[NSNumber numberWithFloat: 0.f] rotateWay:@"z"];
    }
}

//** 控件旋转动画的封装
//view:旋转对象
//fromValue:旋转起始时数值
//toValue：旋转结束时数值
//coordinate:旋转方式，例如绕z轴旋转则传入@"z"
-(void)rotateAnimateWithView:(UIView*)view fromValue: (NSNumber*)fromValue toValue:(NSNumber*)toValue rotateWay:(NSString*)coordinate{
    
    NSString *rotateKeyPath = [NSString stringWithFormat:@"transform.rotation.%@",coordinate];
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:rotateKeyPath];
    animation.fromValue = fromValue;
    animation.toValue = toValue;
    animation.duration = .3f;
    //动画节奏：匀速
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.repeatCount = 1; //如果这里想设置成一直自旋转，可以设置为MAXFLOAT，否则设置具体的数值则代表执行多少次
    [view.layer addAnimation:animation forKey:nil];
    
    
}
 

- (void)showPwd:(UIButton *)btn {
    
    NSLog(@"===showPwd===");
    
}

- (void)newAccount:(UIButton *)btn {
    
    NSLog(@"===newAccount===");
    UIViewController *viewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    
    AccountRegisterViewController *baseVC = [[AccountRegisterViewController alloc] initWithNibName:@"BaseVC" bundle:SDKBundle];
    [baseVC setModalTransitionStyle:(UIModalTransitionStyleFlipHorizontal)];
    [baseVC setModalPresentationStyle:UIModalPresentationCustom];
    
    [self dismissViewControllerAnimated:YES completion:^{
        [viewController presentViewController:baseVC animated:YES completion:nil];
    }];
}

- (void)loginBtnDidClick:(UIButton *)btn {
    
    NSLog(@"===loginBtnDidClick:self.isCheckboxSelected:%@=",self.isCheckboxSelected?@"YES":@"NO");
    
    [self dismissViewControllerAnimated:YES completion:^{
        
        [self mySDKLogin];
    }];
}

-(void)autoLoginWithVC:(UIViewController* _Nullable)vc{
    
    
    AutoLoginController * autoVC = [[AutoLoginController alloc] initWithNibName:@"AutoLoginView" bundle:SDKBundle];
    [autoVC setModalPresentationStyle:UIModalPresentationCustom];
    
    [rootVC presentViewController:autoVC animated:YES completion:nil];
    
    
}

-(void)mySDKLogin
{
    //模型转字典
    ParamsRegLogOn *LoginParams = [ParamsRegLogOn new];
    LoginParams.rltype = @"user";
    LoginParams.uname = @"67435446";
    LoginParams.password = @"CS68S6";
    LoginParams.token = [MySDKInitData new].token;
    NSDictionary *dict = [LoginParams mj_keyValues];
    //    //字符串签名，返回字典格式
    NSDictionary* uploadData = [NSString signDictionaryWithParameters:dict appKey:[MySDKConfig shareInstance].appkey];
    [MySDKNetWorkController requestRegisterAndLoginWithParam:uploadData];
}

-(void)dealloc{
    //删除通知
//    AgreementCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"AgreementCell" forIndexPath:[NSIndexPath indexPathWithIndex:4]];
    [self.agreeMCell removeObserver:self forKeyPath:@"checkBtn.selected"];
    
    //移除翻转屏幕的通知
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    [[UIDevice currentDevice]endGeneratingDeviceOrientationNotifications];
}

#pragma mark -getter-
//-(UIButton*)switchBtn{
//    if (_switchBtn) {
//        return _switchBtn;
//    }
//
//    _switchBtn = [UIButton new];
//    return _switchBtn;
//}


#pragma mark delegate

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    
    if ([keyPath isEqualToString:@"checkBtn.selected"]) {
        NSLog(@"checkBtn.selected is changed!checkBtn.selected is:%@",[change valueForKey:NSKeyValueChangeNewKey]);
        self.isCheckboxSelected = NO;
        return;
    }
    [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    if (indexPath.row==0) {
        TitleViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"TitleViewCell" forIndexPath:indexPath];
        cell.backBtn.hidden = YES;
        cell.titleLabel.text = @"用户登录";
        return cell;
    }
    ////
    if (indexPath.row==1) {
        InputViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"InputViewCell" forIndexPath:indexPath];
        UIImage *logo = res_login_logo;
        UIImage *btnImage = res_login_more;
        cell.logo.image = logo;
        [cell.rightBtn setImage:btnImage forState:UIControlStateNormal];
        [cell.rightBtn addTarget:self action:@selector(historyAccount:) forControlEvents:UIControlEventTouchUpInside];
        self.accountCell = cell;
        return cell;
    }
    
    if (indexPath.row==2) {
        
        InputViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"InputViewCell" forIndexPath:indexPath];
        UIImage *logo = res_login_pwd;
        UIImage *btnImage = res_login_delete;
        cell.logo.image = logo;
        [cell.rightBtn setImage:btnImage forState:UIControlStateNormal];
        [cell.rightBtn addTarget:self action:@selector(showPwd:) forControlEvents:UIControlEventTouchUpInside];
        
        return cell;
    }
    //    注册新账号
    if (indexPath.row==3) {
        CreateAccountCell* cell = [tableView dequeueReusableCellWithIdentifier:@"CreateAccountCell" forIndexPath:indexPath];
        [cell.rightBtn addTarget:self action:@selector(newAccount:) forControlEvents:UIControlEventTouchUpInside];
        
        return cell;
    }
    if (indexPath.row==4) {
        AgreementCell * cell = [tableView dequeueReusableCellWithIdentifier:@"AgreementCell" forIndexPath:indexPath];
        //添加通知
         [cell addObserver: self forKeyPath:@"checkBtn.selected" options:(NSKeyValueObservingOptionNew) context:nil];
        self.agreeMCell = cell;
        return cell;
    }
    //
    if (indexPath.row==5) {
        
        LoginBtnCell * cell = [tableView dequeueReusableCellWithIdentifier:@"LoginBtnCell" forIndexPath:indexPath];
        [cell.loginBtn addTarget:self action:@selector(loginBtnDidClick:) forControlEvents:UIControlEventTouchUpInside];
        
        
        return cell;
    }
    
    return [UITableViewCell new];
}


-(void)historyAccountsDidClickedOutSideFinished:(HistoryAccountsVC *)hisVC{
    //历史账号下拉框已经展开：此时点击了其他区域
    NSLog(@"LoginVC:historyAccountsDidClickedOutSideFinished");
    [self historyAccount:self.accountCell.rightBtn];

}

-(void)NetWorkRespondSuccessDelegate:(nullable NetWorkRespondModel*)result {
    
    NSLog(@"--MySDKInitController--NetWorkRespondSuccessDelegate");
    
    
    
}

- (void)NetWorkRespondFailDelegate:(nullable NetWorkRespondModel*)result {
    
    NSLog(@"--MySDKInitController--NetWorkRespondFailDelegate");
    //网络问题导致登录化失败
    
    
}

//-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//
//    //    //历史账号下拉框已经展开：此时点击了其他区域
//    if (self.accountCell.rightBtn.isSelected) {
//        NSLog(@"LoginVC:historyAccountsDidClickedOutSideFinished");
//        [self historyAccount:self.accountCell.rightBtn];
//    }
//}


@end
