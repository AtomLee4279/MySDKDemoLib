//
//  BaseViewController.m
//  MySDKDemoLib
//
//  Created by 李一贤 on 2018/12/6.
//  Copyright © 2018 李一贤. All rights reserved.
//

#import "AccountRegisterViewController.h"
#import "TitleViewCell.h"
#import "InputViewCell.h"
#import "AgreementCell.h"
#import "LoginBtnCell.h"
#import "LoginVC.h"
@interface AccountRegisterViewController () {
    
}
@end

@implementation AccountRegisterViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //注册nib文件关联的tableviewcell
   
    [self setUpReg];
}


-(void)setUpReg{
    
    regNib(self.tableView, @"TitleViewCell", @"TitleViewCell");
    regNib(self.tableView, @"InputViewCell", @"InputViewCell");
    regNib(self.tableView, @"AgreementCell", @"AgreementCell");
    regNib(self.tableView, @"LoginBtnCell", @"LoginBtnCell");
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 6;
}


//每一行显示怎样的数据，当有一个cell出现在用户视野范围的时候调用
//indexPath:代表唯一的一行
//indexPath.section:获取对应的组号
//indexPath.row:获取对应的行号
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {

        TitleViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"TitleViewCell" forIndexPath:indexPath];
        [cell.backBtn addTarget:self action:@selector(backBtnDidClick:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
 
    if (indexPath.row==1) {
        InputViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"InputViewCell" forIndexPath:indexPath];
        [cell.rightBtn addTarget:self action:@selector(refreshBtnDidClcik:) forControlEvents:UIControlEventTouchUpInside];
        UIImage *btnImage = res_login_refresh;
        [cell.rightBtn setImage:btnImage forState:UIControlStateNormal];
        return cell;
    }
    
    if (indexPath.row==2) {
        InputViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"InputViewCell"];
        UIImage *btnImage = res_login_delete;
        [cell.rightBtn setImage:btnImage forState:UIControlStateNormal];
        [cell.rightBtn addTarget:self action:@selector(delBtnDidClick:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
    
    if (indexPath.row==3) {
        
        UIImage *logo = res_login_pwd;
        InputViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"InputViewCell" forIndexPath:indexPath];
        return cell;
    }
    
    if (indexPath.row==4) {
        
        AgreementCell * cell = [tableView dequeueReusableCellWithIdentifier:@"AgreementCell"];
        return cell;
    }
    
    if (indexPath.row==5) {
        
    LoginBtnCell * cell = [tableView dequeueReusableCellWithIdentifier:@"LoginBtnCell"];
    [cell.loginBtn addTarget:self action:@selector(loginBtnDidClick:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
    
      return [UITableViewCell new];
}

- (void)backBtnDidClick:(UIButton *)btn{
    
    NSLog(@"backBtnDidClick");
    UIViewController *viewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    LoginVC *baseVC = [[LoginVC alloc] initWithNibName:@"BaseVC" bundle:SDKBundle];
    [baseVC setModalTransitionStyle:(UIModalTransitionStyleFlipHorizontal)];
    [baseVC setModalPresentationStyle:UIModalPresentationCustom];
    
    [viewController dismissViewControllerAnimated:YES completion:^{
        [viewController presentViewController:baseVC animated:YES completion:nil];
    }];
}

- (void)refreshBtnDidClcik:(UIButton *)btn {
    
    NSLog(@"===refreshAccount===");
}

- (void)delBtnDidClick:(UIButton *)btn {
    
    NSLog(@"===deleteInput===");
}




@end
