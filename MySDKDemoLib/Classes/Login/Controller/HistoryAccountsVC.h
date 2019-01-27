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

@class HistoryAccountsVC;

@protocol HistoryAccountsDelegate <NSObject>

@optional

-(void)historyAccountsDidClickedOutSideFinished :(HistoryAccountsVC*)hisVC;

@end

@interface HistoryAccountsVC : UIViewController

@property(weak,nonatomic) id<HistoryAccountsDelegate> delegate;

@property(nonatomic,assign) CGRect containerFrame;

@property(nonatomic,assign) CGRect tableFrame;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

NS_ASSUME_NONNULL_END
