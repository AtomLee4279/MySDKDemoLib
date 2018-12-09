//
//  NewAccountCell.m
//  SDKBundle
//
//  Created by 李一贤 on 2018/12/9.
//  Copyright © 2018 李一贤. All rights reserved.
//

#import "NewAccountCell.h"
#import "AccountRegisterViewController.h"

@implementation NewAccountCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)newAccountBtnDidClick:(id)sender {
    
    
    NSLog(@"newAccountBtnDidClick");
    
    UIViewController *viewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    NSString *path = [[NSBundle mainBundle] pathForResource:@"SDKBundle" ofType:@"bundle"];
    NSBundle *SDKBundle = [NSBundle bundleWithPath:path];
    
    AccountRegisterViewController *baseVC = [[AccountRegisterViewController alloc] initWithNibName:@"AccountRegisterView" bundle:SDKBundle];
    [baseVC setModalTransitionStyle:(UIModalTransitionStyleFlipHorizontal)];
    [baseVC setModalPresentationStyle:UIModalPresentationCustom];
    
    [viewController dismissViewControllerAnimated:YES completion:^{
           [viewController presentViewController:baseVC animated:YES completion:nil];
    }];
    
 
    
}

@end
