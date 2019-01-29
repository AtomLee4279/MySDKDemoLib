//
//  AgreementCell.m
//  SDKBundle
//
//  Created by 李一贤 on 2018/12/9.
//  Copyright © 2018 李一贤. All rights reserved.
//

#import "AgreementCell.h"

@implementation AgreementCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
   
}
- (IBAction)checkBtnDidClicked:(UIButton *)sender {
    
    NSLog(@"=AgreementCell:checkBtnDidClicked=");
    sender.selected = !sender.selected;
}

- (IBAction)detailBtnDidClicked:(UIButton *)sender {
    
    NSLog(@"=AgreementCell:detailBtnDidClicked=");
}

@end
