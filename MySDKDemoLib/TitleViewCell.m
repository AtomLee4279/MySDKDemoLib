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

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self prepareForUI];
    }
    
    return self;
}

- (void)prepareForUI {
    

    
    [self.logo.image resizeWithResizeMode:ResizeModeHorizontal];

}

@end
