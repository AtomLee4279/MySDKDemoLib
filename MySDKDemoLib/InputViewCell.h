//
//  InPutViewCell.h
//  SDKBundle
//
//  Created by 李一贤 on 2018/12/21.
//  Copyright © 2018 李一贤. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface InputViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *logo;
@property (weak, nonatomic) IBOutlet UIButton *rightBtn;
@property (weak, nonatomic) IBOutlet UITextField *inputField;

@end

NS_ASSUME_NONNULL_END
