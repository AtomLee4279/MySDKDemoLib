//
//  HistoryAccountsVC.h
//  SDKBundle
//
//  Created by 李一贤 on 2018/12/28.
//  Copyright © 2018 李一贤. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseVC.h"
NS_ASSUME_NONNULL_BEGIN

@interface HistoryAccountsVC : UIViewController

@property(nonatomic,assign) CGRect rect;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

NS_ASSUME_NONNULL_END
