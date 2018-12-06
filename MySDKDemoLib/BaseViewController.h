//
//  BaseViewController.h
//  MySDKDemoLib
//
//  Created by 李一贤 on 2018/12/6.
//  Copyright © 2018 李一贤. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

//+(void)normalLogin;


@end



NS_ASSUME_NONNULL_END
