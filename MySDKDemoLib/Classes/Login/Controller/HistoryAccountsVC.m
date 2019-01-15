//
//  HistoryAccountsVC.m
//  SDKBundle
//
//  Created by 李一贤 on 2018/12/28.
//  Copyright © 2018 李一贤. All rights reserved.
//

#import "HistoryAccountsVC.h"
#import "HistoryAccountsCell.h"

@interface HistoryAccountsVC ()

@end

@implementation HistoryAccountsVC

- (void)viewDidLoad {
    [super viewDidLoad];
//    regNib((UITableView*)self.view, @"HistoryAccountsCell", @"HistoryAccountsCell");
    regNib(self.tableView, @"HistoryAccountsCell", @"HistoryAccountsCell");
    [self customFrame];
}

#pragma mark - methods
//自定义该控制器一些子view的frame*
-(void)customFrame{
    
    //**设置tableView父view--containerView的frame*
    if (!CGRectIsEmpty(self.containerFrame)) {
        self.view.frame = self.containerFrame;
    }
    
    //*设置taleView的frame*
    if (!CGRectIsEmpty(self.tableFrame)) {
        
        CGFloat viewX = self.tableFrame.origin.x;
        CGFloat viewY = CGRectGetMaxY(self.tableFrame);
        CGFloat viewW = self.tableFrame.size.width;
        CGFloat viewH = 100;
        _tableView.frame = CGRectMake(viewX,viewY,viewW,viewH);
    }
    

    
    
    return;
};

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
    
    HistoryAccountsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HistoryAccountsCell" forIndexPath:indexPath];
    return cell;
    
}

///**重写UIResponder方法，手指触摸账号框其他区域时，关掉此框
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
//    [self removeFromParentViewController];
    [self.view removeFromSuperview];
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
