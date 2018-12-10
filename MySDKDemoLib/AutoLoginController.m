//
//  AutoLoginController.m
//  SDKBundle
//
//  Created by 李一贤 on 2018/12/10.
//  Copyright © 2018 李一贤. All rights reserved.
//

#import "AutoLoginController.h"

@interface AutoLoginController ()

@end

@implementation AutoLoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSString *userName = @"U8888";
    NSString *txt = [NSString stringWithFormat:@"欢迎%@用户进入游戏",userName];
    NSDictionary *baseAttr = @{
                               NSForegroundColorAttributeName : [UIColor blackColor],
//                               NSFontAttributeName : UIFont systemFontOfSize:<#(CGFloat)#>,
                               };
    NSMutableAttributedString *attrM = [[NSMutableAttributedString alloc] initWithString:txt attributes:baseAttr];
    NSDictionary *attr = @{
                           NSForegroundColorAttributeName : [UIColor redColor],
                           };
    NSRange ran = [txt rangeOfString:userName];
    [attrM addAttributes:attr range:ran];
    self.tipsLabel.attributedText = attrM;
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)switchBtnDidClick:(id)sender {
    
    
    
}

@end
