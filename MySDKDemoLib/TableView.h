//
//  TableView.h
//  MySDKDemoLib
//
//  Created by 李一贤 on 2018/12/30.
//  Copyright © 2018 李一贤. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TableView : UITableView<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

NS_ASSUME_NONNULL_END
