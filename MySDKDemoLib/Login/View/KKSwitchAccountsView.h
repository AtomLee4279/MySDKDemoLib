//
//  KKSwitchAccountsView.h
//  KoalaGameKit
//
//  Created by kaola  on 2018/3/23.
//  Copyright © 2018年 kaola . All rights reserved.
// 切换账号 的view

#import "KKView.h"

extern CGFloat const KKSwitchAccountsCellHeight;

@interface KKSwitchAccountsView : KKView

@property(nonatomic, strong, readonly) UITableView *tableView;
@property(nonatomic, strong) NSMutableArray<NSString *> *dataSource;

@property(nonatomic, copy) void (^didSelectRowAtIndexPathAction)(NSIndexPath *indexPath, NSString *username);
@property(nonatomic, copy) void (^delBtnDidClickAction)(NSString *account);

@end
