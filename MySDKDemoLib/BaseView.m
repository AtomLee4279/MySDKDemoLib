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
    baseView.tableView.delegate = self;
    
    
    return baseView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   
    return 1;
}


//每一行显示怎样的数据，当有一个cell出现在用户视野范围的时候调用
//indexPath:代表唯一的一行
//indexPath.section:获取对应的组号
//indexPath.row:获取对应的行号
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"hero";//使用静态局部变量static，避免每次调用该方法时都重复创建该局部变量,保证该变量的内存只分配一次
    //1.首先根据标识符去重用池中取cell
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:ID];
    //2.如果不存在cell,才根据标识符新创建cell
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
//    cell.accessoryType = UITableViewCellAccessoryNone;
    //设置cell选中状态
//    if ([self.selectedDict objectForKey:@(indexPath.section)]) {
//        cell.accessoryType = UITableViewCellAccessoryCheckmark;
//    }
//    //设置数据
//    NSLog(@"%ld==%ld",(long)indexPath.section,(long)indexPath.row);
//    HeroGroup * group = self.heroGroups[indexPath.section];
//    cell.textLabel.text = [group getHeroParamWithIndex:indexPath.row andkey:@"name"];
//    cell.detailTextLabel.text = [group getHeroParamWithIndex:indexPath.row andkey:@"info"];
//    cell.imageView.image = [UIImage imageNamed:[group getHeroParamWithIndex:indexPath.row andkey:@"icon"]];
    return cell;
}


@end
