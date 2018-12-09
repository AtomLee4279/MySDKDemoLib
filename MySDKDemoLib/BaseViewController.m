//
//  BaseViewController.m
//  MySDKDemoLib
//
//  Created by 李一贤 on 2018/12/6.
//  Copyright © 2018 李一贤. All rights reserved.
//

#import "BaseViewController.h"
#import "TitleViewCell.h"
#import "InputViewCell.h"
#import "AgreementCell.h"
@interface BaseViewController () {
    
}
@end

@implementation BaseViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    //注册nib文件关联的tableviewcell
    NSString *path = [[NSBundle mainBundle] pathForResource:@"SDKBundle" ofType:@"bundle"];
    NSBundle *SDKBundle = [NSBundle bundleWithPath:path];
    [self.tableView registerNib:[UINib nibWithNibName:@"TitleViewCell" bundle:SDKBundle] forCellReuseIdentifier:@"TitleViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"InputViewCell" bundle:SDKBundle] forCellReuseIdentifier:@"InputViewCell"];
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
        TitleViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"TitleViewCell"];
        return cell;
    }
 
    if (indexPath.row==1) {
        Class cls = [InputViewCell class];
        InputViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"InputViewCell"];
        
        UIImage *logo = [UIImage imageNamed:[NSString stringWithFormat:@"%@.bundle/%@", @"SDKBundle", @"账号"]];
        UIImage *btnImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@.bundle/%@", @"SDKBundle", @"刷新"]];
        cell.logo.image = logo;
        [cell.moreBtn setImage:btnImage forState:UIControlStateNormal];
        [cell.moreBtn addTarget:self action:@selector(refreshAccount:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
    
    if (indexPath.row==2) {
        Class cls = [InputViewCell class];
        InputViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"InputViewCell"];
        UIImage *logo = [UIImage imageNamed:[NSString stringWithFormat:@"%@.bundle/%@", @"SDKBundle", @"密码"]];
        UIImage *btnImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@.bundle/%@", @"SDKBundle", @"删除"]];
        cell.logo.image = logo;
        [cell.moreBtn setImage:btnImage forState:UIControlStateNormal];
        [cell.moreBtn addTarget:self action:@selector(deleteInput:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
    
    if (indexPath.row==3) {
        Class cls = [InputViewCell class];
        InputViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"InputViewCell"];
        UIImage *logo = [UIImage imageNamed:[NSString stringWithFormat:@"%@.bundle/%@", @"SDKBundle", @"密码"]];
        cell.logo.image = logo;
        cell.moreBtn = nil;
        //        cell.logo.image = [UIImage imageNamed:@"密码"];
        //        [cell.moreBtn setImage:[UIImage imageNamed:@"删除"] forState:UIControlStateNormal];
        //        [cell.moreBtn addTarget:self action:@selector(deleteInput:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
    
    if (indexPath.row==4) {
        Class cls = [AgreementCell class];
        AgreementCell * cell = [tableView dequeueReusableCellWithIdentifier:@"AgreementCell"];
        return cell;
    }
    
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"SDKBundle" ofType:@"bundle"];
//    NSBundle *SDKBundle = [NSBundle bundleWithPath:path];
//    [UINib nibWithNibName:@"TitleViewCell" bundle:SDKBundle];
      return [UITableViewCell new];
}


- (void)refreshAccount:(UIButton *)btn {
    
    NSLog(@"===refreshAccount===");
}

- (void)deleteInput:(UIButton *)btn {
    
    NSLog(@"===deleteInput===");
}

@end
