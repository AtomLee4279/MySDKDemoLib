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
}

- (void)loginBtnDidClick:(UIButton *)btn {
    
    NSLog(@"===loginBtnDidClick===");
    
    [self dismissViewControllerAnimated:YES completion:^{
        
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"SDKBundle" ofType:@"bundle"];
        NSBundle *SDKBundle = [NSBundle bundleWithPath:path];
        
        AutoLoginController * autoVC = [[AutoLoginController alloc] initWithNibName:@"AutoLoginView" bundle:SDKBundle];
        [autoVC setModalPresentationStyle:UIModalPresentationCustom];
        
        UIViewController *rootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
        [rootVC presentViewController:autoVC animated:YES completion:nil];
        
        
    }];
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
