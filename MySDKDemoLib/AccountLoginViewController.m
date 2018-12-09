//
//  AccountLoginViewController.m
//  SDKBundle
//
//  Created by 李一贤 on 2018/12/9.
//  Copyright © 2018 李一贤. All rights reserved.
//

#import "AccountLoginViewController.h"
#import "TitleViewCell.h"
#import "InputViewCell.h"
#import "AgreementCell.h"
#import "NewAccountCell.h"
@interface AccountLoginViewController ()

@end

@implementation AccountLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"SDKBundle" ofType:@"bundle"];
    NSBundle *SDKBundle = [NSBundle bundleWithPath:path];
    [self.tableView registerNib:[UINib nibWithNibName:@"TitleViewCell" bundle:SDKBundle] forCellReuseIdentifier:@"TitleViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"InputViewCell" bundle:SDKBundle] forCellReuseIdentifier:@"InputViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"AgreementCell" bundle:SDKBundle] forCellReuseIdentifier:@"AgreementCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"NewAccountCell" bundle:SDKBundle] forCellReuseIdentifier:@"NewAccountCell"];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    
    if (indexPath.row==1) {
        Class cls = [InputViewCell class];
        InputViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"InputViewCell"];
        
        UIImage *logo = [UIImage imageNamed:[NSString stringWithFormat:@"%@.bundle/%@", @"SDKBundle", @"账号"]];
        UIImage *btnImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@.bundle/%@", @"SDKBundle", @"下拉"]];
        cell.logo.image = logo;
        [cell.moreBtn setImage:btnImage forState:UIControlStateNormal];
//        [cell.moreBtn addTarget:self action:@selector(refreshAccount:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
    
    if (indexPath.row==2) {
        Class cls = [InputViewCell class];
        InputViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"InputViewCell"];
        UIImage *logo = [UIImage imageNamed:[NSString stringWithFormat:@"%@.bundle/%@", @"SDKBundle", @"密码"]];
        UIImage *btnImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@.bundle/%@", @"SDKBundle", @"删除"]];
        cell.logo.image = logo;
        [cell.moreBtn setImage:btnImage forState:UIControlStateNormal];
//        [cell.moreBtn addTarget:self action:@selector(deleteInput:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
    
    if (indexPath.row==3) {
        Class cls = [InputViewCell class];
        InputViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"InputViewCell"];
//            NSString *path = [[NSBundle mainBundle] pathForResource:@"SDKBundle" ofType:@"bundle"];
//            NSBundle *SDKBundle = [NSBundle bundleWithPath:path];
//            [UINib nibWithNibName:@"InputViewCell" bundle:SDKBundle];
  
        //        cell.logo.image = [UIImage imageNamed:@"密码"];
        //        [cell.moreBtn setImage:[UIImage imageNamed:@"删除"] forState:UIControlStateNormal];
        //        [cell.moreBtn addTarget:self action:@selector(deleteInput:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
    
    if (indexPath.row==4) {
        Class cls = [NewAccountCell class];
        AgreementCell * cell = [tableView dequeueReusableCellWithIdentifier:@"NewAccountCell"];
        return cell;
    }
    
    if (indexPath.row==5) {
        Class cls = [AgreementCell class];
        AgreementCell * cell = [tableView dequeueReusableCellWithIdentifier:@"AgreementCell"];
        return cell;
    }
    
    //    NSString *path = [[NSBundle mainBundle] pathForResource:@"SDKBundle" ofType:@"bundle"];
    //    NSBundle *SDKBundle = [NSBundle bundleWithPath:path];
    //    [UINib nibWithNibName:@"TitleViewCell" bundle:SDKBundle];
    return [UITableViewCell new];
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
