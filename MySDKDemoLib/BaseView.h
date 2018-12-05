//
//  BaseView.h
//  MySDKDemoLib
//
//  Created by 李一贤 on 2018/12/5.
//  Copyright © 2018 李一贤. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseView : UITableView

@property (weak, nonatomic) IBOutlet UITableView *tableView;
+(instancetype)loadXib;


@end

NS_ASSUME_NONNULL_END
