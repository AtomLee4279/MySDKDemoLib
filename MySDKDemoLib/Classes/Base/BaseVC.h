//
//  BaseVC.h
//  SDKBundle
//
//  Created by 李一贤 on 2019/1/1.
//  Copyright © 2019 李一贤. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseVC : UIViewController<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end

NS_ASSUME_NONNULL_END
