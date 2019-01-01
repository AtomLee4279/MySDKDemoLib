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

@interface LoginVC ()

@property(nonatomic,strong) InputViewCell *accountCell;

@property(nonatomic,strong) InputViewCell *pwdCell;

@end

@implementation LoginVC

-(void)viewDidLoad{
    [super viewDidLoad];
    [self regNib];
}

-(void)regNib{
    UINib *nib = [UINib nibWithNibName:@"Cells" bundle:SDKBundle];
//    [self.tableView registerNib:nib forCellReuseIdentifier:@"TitleViewCell"];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"InputViewCell"];
//    [self.tableView registerNib:nib forCellReuseIdentifier:@"AgreementCell"];
//    [self.tableView registerNib:nib forCellReuseIdentifier:@"CreateAccountCell"];
//    [self.tableView registerNib:nib forCellReuseIdentifier:@"LoginBtnCell"];
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
 
    Class cls = [InputViewCell class];
    InputViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"InputViewCell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[SDKBundle loadNibNamed:@"Cells" owner:nil options:nil] objectAtIndex:1];
        UIImage *logo = [UIImage imageNamed:[NSString stringWithFormat:@"%@.bundle/%@", @"SDKBundle", @"账号"]];
        UIImage *btnImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@.bundle/%@", @"SDKBundle", @"下拉"]];
        cell.logo.image = logo;
        [cell.rightBtn setImage:btnImage forState:UIControlStateNormal];
        [cell.rightBtn addTarget:self action:@selector(historyAccount:) forControlEvents:UIControlEventTouchUpInside];
        self.accountCell = cell;
    }
    return cell;
    return [UITableViewCell new];
}



@end
