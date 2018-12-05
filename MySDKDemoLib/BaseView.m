//
//  BaseView.m
//  MySDKDemoLib
//
//  Created by 李一贤 on 2018/12/5.
//  Copyright © 2018 李一贤. All rights reserved.
//

#import "BaseView.h"

@implementation BaseView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+(instancetype)loadXib
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"SDKBundle" ofType:@"bundle"];
    NSBundle *SDKBundle = [NSBundle bundleWithPath:path];
    BaseView *baseView = [[[UINib nibWithNibName:@"BaseView" bundle:SDKBundle] instantiateWithOwner:nil options:nil] lastObject];
    return baseView;
}


@end
