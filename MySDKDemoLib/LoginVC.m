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

@interface LoginVC ()

@property(nonatomic,strong) InputViewCell *accountCell;

@property(nonatomic,strong) InputViewCell *pwdCell;

@end

@implementation LoginVC



-(void)viewDidLoad{
    [super viewDidLoad];
//    [self regNib];
    regNib(self.tableView, @"TitleViewCell", @"TitleViewCell");
    regNib(self.tableView, @"InputViewCell", @"InputViewCell");
    
    
}

-(void)setUpReg{
    
    
    
    
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
        cell = [[SDKBundle loadNibNamed:@"Cells" owner:nil options:nil] objectAtIndex:1];
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
            cell = [[SDKBundle loadNibNamed:@"Cells" owner:nil options:nil] objectAtIndex:1];
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
        cell = [[SDKBundle loadNibNamed:@"Cells" owner:nil options:nil] objectAtIndex:2];
        [cell.rightBtn addTarget:self action:@selector(newAccount:) forControlEvents:UIControlEventTouchUpInside];

        return cell;
    }
    if (indexPath.row==4) {
        AgreementCell * cell = [tableView dequeueReusableCellWithIdentifier:@"AgreementCell" forIndexPath:indexPath];
        cell = [[SDKBundle loadNibNamed:@"Cells" owner:nil options:nil] objectAtIndex:5];
        [cell.checkBtn addTarget:self action:@selector(checkBtnDidClick:) forControlEvents:UIControlEventTouchUpInside];
        [cell.detailBtn addTarget:self action:@selector(detailBtnDidClick:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
    //
    if (indexPath.row==5) {
        
        LoginBtnCell * cell = [tableView dequeueReusableCellWithIdentifier:@"LoginBtnCell" forIndexPath:indexPath];
        cell = [[SDKBundle loadNibNamed:@"Cells" owner:nil options:nil] objectAtIndex:4];
        [cell.loginBtn addTarget:self action:@selector(loginBtnDidClick:) forControlEvents:UIControlEventTouchUpInside];
        
        
        return cell;
    }
    
    return [UITableViewCell new];
}



@end
