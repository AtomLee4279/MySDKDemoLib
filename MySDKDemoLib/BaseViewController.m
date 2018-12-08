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
 
    // Do any additional setup after loading the view.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 5;
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
        InputViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"InputViewCell"];
        return cell;
    }
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"SDKBundle" ofType:@"bundle"];
//    NSBundle *SDKBundle = [NSBundle bundleWithPath:path];
//    [UINib nibWithNibName:@"TitleViewCell" bundle:SDKBundle];
      return [UITableViewCell new];
}


- (void)backBtnDidClick:(UIButton *)btn {
    
    NSLog(@"===backBtnDidClick===");
}


@end
