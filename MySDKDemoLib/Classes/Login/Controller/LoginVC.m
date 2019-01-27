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

//展开历史账号的三角按钮
@property(nonatomic,strong)  UIButton *switchBtn;

@end

@implementation LoginVC




-(void)viewDidLoad{
    [super viewDidLoad];
    [self setUpReg];
    
    
}

-(void)setUpReg{
    
    regNib(self.tableView, @"TitleViewCell", @"TitleViewCell");
    regNib(self.tableView, @"InputViewCell", @"InputViewCell");
    regNib(self.tableView, @"CreateAccountCell", @"CreateAccountCell");
    regNib(self.tableView, @"AgreementCell", @"AgreementCell");
    regNib(self.tableView, @"LoginBtnCell", @"LoginBtnCell");
    
    
}



- (void)historyAccount:(UIButton *)btn {
    
    NSLog(@"===historyAccount===");
     self.switchBtn = btn;
     btn.selected = !btn.selected;
    //旋转按钮的动画
    [self rotateBtn:btn];
    //**if:点击状态：创建账号下拉框
    if (btn.selected) {
        HistoryAccountsVC *hisVC = [[HistoryAccountsVC alloc] initWithNibName:@"HistoryAccounts" bundle:SDKBundle];
        
        UIView *containerView = [self.view viewWithTag:1000];
        //把该loginVC控制器下containerView的frame传给hisVC的属性
        hisVC.containerFrame = containerView.frame;
        //frame转换：得到inputField这个frame在LoginVC-containerView中的情况(x,y,w，h)
        CGRect cellRect = [self.accountCell convertRect:self.accountCell.inputField.frame toView:containerView];
        hisVC.tableFrame = cellRect;
        [self addChildViewController:hisVC];
        [self.view addSubview:hisVC.view];
        [hisVC didMoveToParentViewController:self];
    }
    //**else:非点击状态:删除账号下拉框
    else{
//        [self rotateBtn:btn];
        NSArray *array = self.childViewControllers;
        if ([array firstObject]&&[[array firstObject] isKindOfClass:[HistoryAccountsVC class]])
        {
            [self removeFromParentViewController];
        }
    }
   
    
}


//按钮旋转动画
-(void)rotateBtn:(UIButton*)btn{
    //展开了历史账号下拉框，伴随的三角按钮旋转
    if (btn.selected) {
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        animation.fromValue = [NSNumber numberWithFloat:0.f];
        animation.toValue = [NSNumber numberWithFloat: M_PI];
        animation.duration = .3f;
        //动画节奏：匀速
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
        animation.autoreverses = NO;
        animation.removedOnCompletion = NO;
        animation.fillMode = kCAFillModeForwards;
        animation.repeatCount = 1; //如果这里想设置成一直自旋转，可以设置为MAXFLOAT，否则设置具体的数值则代表执行多少次
        [btn.layer addAnimation:animation forKey:nil];
    }
    //收回账号下拉框伴随的按钮动画
    else{
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        animation.fromValue = [NSNumber numberWithFloat:0.f];
        animation.toValue = [NSNumber numberWithFloat: M_PI];
        animation.duration = .3f;
        //动画节奏：匀速
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
        animation.removedOnCompletion = NO;
        animation.fillMode = kCAFillModeForwards;
        [btn.layer addAnimation:animation forKey:nil];
    }
}


- (void)showPwd:(UIButton *)btn {
    
    NSLog(@"===showPwd===");
    
}

- (void)newAccount:(UIButton *)btn {
    
    NSLog(@"===newAccount===");
    UIViewController *viewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    
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
    //    BaseVC *baseVC = [[BaseVC alloc] initWithNibName:@"BaseVC" bundle:SDKBundle];
    LoginVC *loginVC = [[LoginVC alloc] init];
    [self addChildViewController:loginVC];
    [self.view addSubview:loginVC.view];
    CGRect cellRect = [self.accountCell convertRect:self.accountCell.inputField.frame toView:self.view];
    CGFloat viewX = cellRect.origin.x;
    CGFloat viewY = CGRectGetMaxY(cellRect);
    CGFloat viewW = cellRect.size.width;
    CGFloat viewH = 150;
    loginVC.view.frame = CGRectMake(viewX,viewY,viewW,viewH);
    [loginVC didMoveToParentViewController:self];
    
    
}


- (void)loginBtnDidClick:(UIButton *)btn {
    
    NSLog(@"===loginBtnDidClick===");
    
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

#pragma mark -getter-
-(UIButton*)switchBtn{
    if (_switchBtn) {
        return _switchBtn;
    }
    
    _switchBtn = [UIButton new];
    return _switchBtn;
}


#pragma mark delegate

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
        UIImage *logo = [UIImage imageNamed:[NSString stringWithFormat:@"%@.bundle/%@", @"SDKBundle", @"账号"]];
        UIImage *btnImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@.bundle/%@", @"SDKBundle", @"下拉"]];
        cell.logo.image = logo;
        [cell.rightBtn setImage:btnImage forState:UIControlStateNormal];
        [cell.rightBtn addTarget:self action:@selector(historyAccount:) forControlEvents:UIControlEventTouchUpInside];
        self.accountCell = cell;
        return cell;
    }
    
    if (indexPath.row==2) {
        
        InputViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"InputViewCell" forIndexPath:indexPath];
        UIImage *logo = [UIImage imageNamed:[NSString stringWithFormat:@"%@.bundle/%@", @"SDKBundle", @"密码"]];
        UIImage *btnImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@.bundle/%@", @"SDKBundle", @"删除"]];
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
        [cell.checkBtn addTarget:self action:@selector(checkBtnDidClick:) forControlEvents:UIControlEventTouchUpInside];
        [cell.detailBtn addTarget:self action:@selector(detailBtnDidClick:) forControlEvents:UIControlEventTouchUpInside];
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
    [self historyAccount:self.switchBtn];
    
}

-(void)NetWorkRespondSuccessDelegate:(nullable NetWorkRespondModel*)result {
    
    NSLog(@"--MySDKInitController--NetWorkRespondSuccessDelegate");
    
    
    
}

- (void)NetWorkRespondFailDelegate:(nullable NetWorkRespondModel*)result {
    
    NSLog(@"--MySDKInitController--NetWorkRespondFailDelegate");
    //网络问题导致登录化失败
    
    
}


@end
