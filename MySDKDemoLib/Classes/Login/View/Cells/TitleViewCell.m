//
//  TitleViewCell.m
//  MySDKDemoLib
//
//  Created by 李一贤 on 2018/12/6.
//  Copyright © 2018 李一贤. All rights reserved.
//

#import "TitleViewCell.h"
#import "UIImage+Resize.h"


@implementation TitleViewCell

   // Initialization code
- (void)awakeFromNib {
    [super awakeFromNib];
//    CGFloat imgW = self.logo.image.size.width;
//    CGFloat imgCenterX = imgW * .5;
//    UIEdgeInsets inset = UIEdgeInsetsMake(0, imgCenterX, 0, imgCenterX - 1);
//    [self.logo.image resizableImageWithCapInsets:inset resizingMode:UIImageResizingModeStretch];
//    self.logo.image = [[UIImage imageNamed:[NSString stringWithFormat:@"%@.bundle/%@", @"SDKBundle", @"标题栏"]] resizeWithResizeMode:ResizeModeHorizontal];
//    [self.logo.image resizeWithResizeMode:ResizeModeHorizontal];
//
    
 
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
