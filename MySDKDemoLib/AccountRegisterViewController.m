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
#import "AccountLoginViewController.h"
@interface AccountRegisterViewController () {
    
}
@end

@implementation AccountRegisterViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    //注册nib文件关联的tableviewcell
   
    [self.tableView registerNib:[UINib nibWithNibName:@"TitleViewCell" bundle:SDKBundle] forCellReuseIdentifier:@"TitleViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"Cells" bundle:SDKBundle] forCellReuseIdentifier:@"InputViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"AgreementCell" bundle:SDKBundle] forCellReuseIdentifier:@"AgreementCell"];
 
    // Do any additional setup after loading the view.
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
        Class cls = [TitleViewCell class];
        TitleViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"TitleViewCell" forIndexPath:indexPath];
        [cell.backBtn addTarget:self action:@selector(backBtnDidClick:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
 
    if (indexPath.row==1) {
        Class cls = [InputViewCell class];
        InputViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"InputViewCell" forIndexPath:indexPath];
        
        UIImage *logo = KK_ImageNamed(res_login_logo);
        UIImage *btnImage = KK_ImageNamed(res_login_refresh);
//        cell.logo.image = logo;
//        [cell.rightBtn setImage:btnImage forState:UIControlStateNormal];
//        [cell.rightBtn addTarget:self action:@selector(refreshAccount:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
    
    if (indexPath.row==2) {
        Class cls = [InputViewCell class];
        InputViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"InputViewCell"];
        UIImage *logo = KK_ImageNamed(res_login_pwd);
        UIImage *btnImage = KK_ImageNamed(res_login_delete);
//        cell.logo.image = logo;
//        [cell.rightBtn setImage:btnImage forState:UIControlStateNormal];
//        [cell.rightBtn addTarget:self action:@selector(deleteInput:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
    
    if (indexPath.row==3) {
        Class cls = [InputViewCell class];
        UIImage *logo = KK_ImageNamed(res_login_pwd);
        InputViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"InputViewCell" forIndexPath:indexPath];
//        cell.logo.image = logo;
//        cell.rightBtn.hidden = YES;
        //        cell.logo.image = [UIImage imageNamed:@"密码"];
        //        [cell.moreBtn setImage:[UIImage imageNamed:@"删除"] forState:UIControlStateNormal];
        //        [cell.moreBtn addTarget:self action:@selector(deleteInput:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
    
    if (indexPath.row==4) {
        Class cls = [AgreementCell class];
        AgreementCell * cell = [tableView dequeueReusableCellWithIdentifier:@"AgreementCell"];
        [cell.checkBtn addTarget:self action:@selector(checkBtnDidClick:) forControlEvents:UIControlEventTouchUpInside];
        [cell.detailBtn addTarget:self action:@selector(detailBtnDidClick:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
      return [UITableViewCell new];
}

- (void)backBtnDidClick:(UIButton *)btn{
    
    NSLog(@"backBtnDidClick");
    UIViewController *viewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    AccountLoginViewController *baseVC = [[AccountLoginViewController alloc] initWithNibName:@"AccountLoginView" bundle:SDKBundle];
    [baseVC setModalTransitionStyle:(UIModalTransitionStyleFlipHorizontal)];
    [baseVC setModalPresentationStyle:UIModalPresentationCustom];
    
    [viewController dismissViewControllerAnimated:YES completion:^{
        [viewController presentViewController:baseVC animated:YES completion:nil];
    }];
}

- (void)refreshAccount:(UIButton *)btn {
    
    NSLog(@"===refreshAccount===");
}

- (void)deleteInput:(UIButton *)btn {
    
    NSLog(@"===deleteInput===");
}


- (void)checkBtnDidClick:(UIButton *)btn {
    
    NSLog(@"===checkBtnDidClick===");
}


- (void)detailBtnDidClick:(UIButton *)btn {
    
    NSLog(@"===detailBtnDidClick===");
}

@end
