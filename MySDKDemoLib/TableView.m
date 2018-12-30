//
//  TableView.m
//  MySDKDemoLib
//
//  Created by 李一贤 on 2018/12/30.
//  Copyright © 2018 李一贤. All rights reserved.
//

#import "TableView.h"

@implementation TableView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    if (self = [super initWithCoder:aDecoder]) {
        
        [self prepareForUI];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.dataSource = self;
    self.delegate = self;
    //    CGFloat imgW = self.logo.image.size.width;
    //    CGFloat imgCenterX = imgW * .5;
    //    UIEdgeInsets inset = UIEdgeInsetsMake(0, imgCenterX, 0, imgCenterX - 1);
    //    [self.logo.image resizableImageWithCapInsets:inset resizingMode:UIImageResizingModeStretch];
    //    self.logo.image = [[UIImage imageNamed:[NSString stringWithFormat:@"%@.bundle/%@", @"SDKBundle", @"标题栏"]] resizeWithResizeMode:ResizeModeHorizontal];
    //    [self.logo.image resizeWithResizeMode:ResizeModeHorizontal];
    //
    
    
}

- (void)prepareForUI{
    self.dataSource = self;
    self.delegate = self;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HistoryAccountsCell"];
    if (!cell) {
        cell = [[SDKBundle loadNibNamed:@"TableViewController" owner:nil options:nil] objectAtIndex:3];
        return cell;
    }
    
    return  [UITableViewCell new];
    
}




@end
