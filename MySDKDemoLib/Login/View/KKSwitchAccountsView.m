//
//  KKSwitchAccountsView.m
//  KoalaGameKit
//
//  Created by kaola  on 2018/3/23.
//  Copyright © 2018年 kaola . All rights reserved.
//

#import "KKSwitchAccountsView.h"
#import "Masonry.h"

CGFloat const KKSwitchAccountsCellHeight = 35.f;

@interface KKSwitchAccountsView () <UITableViewDataSource, UITableViewDelegate> {
    
    UITableView *_tableView;
}

@property(nonatomic,strong) UITableViewCell *deaultCell;

@end

@implementation KKSwitchAccountsView

#pragma mark - life cycle
- (void)prepareForUI {
    
    [super prepareForUI];
    
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.backgroundColor = [UIColor clearColor];
    
    self.tableView.tableFooterView = [UIView new];
}

- (UIButton *)getBtn {
    
    UIButton *btn = [UIButton new];
    btn.frame = CGRectMake(0, 0, KKWIDTH(15.f), KKWIDTH(15.f));
    [btn setImage:res_login_delete forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(delBtnDidClick:) forControlEvents:UIControlEventTouchUpInside];
    
    return btn;
}

- (UITapGestureRecognizer *)getTap {
    
    UITapGestureRecognizer *tapG = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    return tapG;
}

- (void)tapAction:(UITapGestureRecognizer *)tapG {
    
    if (self.didSelectRowAtIndexPathAction) {
        
        UITableViewCell *cell = (UITableViewCell *)tapG.view;
        NSInteger row = [self.dataSource indexOfObject:cell.textLabel.text];
        self.didSelectRowAtIndexPathAction([NSIndexPath indexPathForRow:row inSection:0], cell.textLabel.text);
    }
}

- (void)delBtnDidClick:(UIButton *)btn {
    
    UITableViewCell *cell = (UITableViewCell *)btn.superview;
    DBLog(@"删除cellcell == %@", cell.textLabel.text);
    NSInteger row = [self.dataSource indexOfObject:cell.textLabel.text];
    // 删除cell
    NSIndexPath *delPat = [NSIndexPath indexPathForRow:row inSection:0];
    [self.dataSource removeObjectAtIndex:row];
    if (!self.dataSource.count) {
        [self.tableView reloadData];
    }
    else {
        
        [self.tableView deleteRowsAtIndexPaths:@[delPat] withRowAnimation:UITableViewRowAnimationBottom];
    }
    
    if (self.delBtnDidClickAction) {
        self.delBtnDidClickAction(cell.textLabel.text);
    }
}

#pragma mark - <UITableViewDataSource, UITableViewDelegate>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataSource.count ? self.dataSource.count : 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (!self.dataSource.count) {
        return self.deaultCell;
    }
    
    static NSString * ReuseId = @"UITableViewCellReuseId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ReuseId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ReuseId];
        cell.accessoryView = [self getBtn];
        [cell addGestureRecognizer:[self getTap]];
        cell.textLabel.font = KKFONT(KKFONT_MIN_SIZE);
        cell.textLabel.textColor = [UIColor darkGrayColor];
    }
    
    cell.textLabel.text = self.dataSource[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return KKHEIGHT(KKSwitchAccountsCellHeight);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DBLog(@"didSelectRowAtIndexPath ： %@", indexPath);
}


#pragma mark - Getter && Setter
- (UITableView *)tableView {
    
    __block __weak typeof(self) weakSelf = self;
    KK_MakeAndReturnPropertyInstance(_tableView, UITableView, ^(UITableView *prop){
        
        [weakSelf addSubview:prop];
        prop.dataSource = weakSelf;
        prop.delegate = weakSelf;
        
        [prop mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.edges.equalTo(weakSelf);
        }];
    })
}

- (void)setDataSource:(NSMutableArray<NSString *> *)dataSource {
    
    _dataSource = dataSource;
    
    [self.tableView reloadData];
}

- (UITableViewCell *)deaultCell {
    
    KK_MakeAndReturnPropertyInstance(_deaultCell, UITableViewCell, ^(UITableViewCell *prop){
        
        prop.textLabel.text = @"暂无记录~";
        prop.textLabel.font = KKFONT(KKFONT_MIN_SIZE);
        prop.textLabel.textColor = [UIColor darkGrayColor];
    })
}


@end
