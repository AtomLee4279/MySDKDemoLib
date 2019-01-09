//
//  BaseVC.m
//  SDKBundle
//
//  Created by 李一贤 on 2019/1/1.
//  Copyright © 2019 李一贤. All rights reserved.
//

#import "BaseVC.h"
#import "TitleViewCell.h"

@interface BaseVC ()



@end

@implementation BaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    return [UITableViewCell new];
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}



@end
