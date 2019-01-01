//
//  AccountLoginViewController.m
//  SDKBundle
//
//  Created by 李一贤 on 2018/12/9.
//  Copyright © 2018 李一贤. All rights reserved.
//

#import "AccountRegisterViewController.h"
#import "AccountLoginViewController.h"
#import "AutoLoginController.h"
#import "TitleViewCell.h"
#import "InputViewCell.h"
#import "AgreementCell.h"
#import "CreateAccountCell.h"
#import "LoginBtnCell.h"
#import "HistoryAccountsVC.h"

@interface AccountLoginViewController ()

@property(nonatomic,strong) KKSwitchAccountsView *switchAccountsView;

@property(nonatomic,strong) InputViewCell *accountCell;

@property(nonatomic,strong) InputViewCell *pwdCell;

@end

@implementation AccountLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.tableView.rowHeight = UITableViewAutomaticDimension;
//    self.tableView.estimatedRowHeight = 100;
//    [self regNib];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

/**
 *  注册nib
 */
- (void)regNib {

    
    [self.tableView registerNib:[UINib nibWithNibName:@"TitleViewCell" bundle:SDKBundle] forCellReuseIdentifier:@"TitleViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"Cells" bundle:SDKBundle] forCellReuseIdentifier:@"InputViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"AgreementCell" bundle:SDKBundle] forCellReuseIdentifier:@"AgreementCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"Cells" bundle:SDKBundle] forCellReuseIdentifier:@"CreateAccountCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"LoginBtnCell" bundle:SDKBundle] forCellReuseIdentifier:@"LoginBtnCell"];
    
}
    

#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 6;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
     UINib *nib = [UINib nibWithNibName:@"Cells" bundle:SDKBundle];
    // UIView *contentView = [nib instantiateWithOwner:self options:nil].firstObject;
    if (indexPath.row==0) {
        Class cls = [TitleViewCell class];
        TitleViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"HistoryAccountsCell"];
        if (!cell) {
//方法一：加载nib：cell = [[SDKBundle loadNibNamed:@"Cells" owner:nil options:nil] objectAtIndex:0];
//方法二：
            cell = [nib instantiateWithOwner:nil options:nil].firstObject;
            cell.backBtn.hidden = YES;
            cell.titleLabel.text = @"用户登录";
        }
        return cell;
    }
////
    if (indexPath.row==1) {
        Class cls = [InputViewCell class];
        InputViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"InputViewCell"];
        if (!cell) {
            cell = [[SDKBundle loadNibNamed:@"Cells" owner:nil options:nil] objectAtIndex:1];
            UIImage *logo = [UIImage imageNamed:[NSString stringWithFormat:@"%@.bundle/%@", @"SDKBundle", @"账号"]];
            UIImage *btnImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@.bundle/%@", @"SDKBundle", @"下拉"]];
            cell.logo.image = logo;
            [cell.rightBtn setImage:btnImage forState:UIControlStateNormal];
            [cell.rightBtn addTarget:self action:@selector(historyAccount:) forControlEvents:UIControlEventTouchUpInside];
            self.accountCell = cell;
        }
        return cell;
    }
////
    if (indexPath.row==2) {
        Class cls = [InputViewCell class];
        InputViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"InputViewCell"];
        if (!cell) {
            cell = [[SDKBundle loadNibNamed:@"Cells" owner:nil options:nil] objectAtIndex:1];
            UIImage *logo = [UIImage imageNamed:[NSString stringWithFormat:@"%@.bundle/%@", @"SDKBundle", @"密码"]];
            UIImage *btnImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@.bundle/%@", @"SDKBundle", @"删除"]];
            cell.logo.image = logo;
            [cell.rightBtn setImage:btnImage forState:UIControlStateNormal];
            [cell.rightBtn addTarget:self action:@selector(showPwd:) forControlEvents:UIControlEventTouchUpInside];
        }
        
        return cell;
    }
//    注册新账号
    if (indexPath.row==3) {
        Class cls = [CreateAccountCell class];
        CreateAccountCell* cell = [tableView dequeueReusableCellWithIdentifier:@"CreateAccountCell"];
        if (!cell) {
            cell = [[SDKBundle loadNibNamed:@"Cells" owner:nil options:nil] objectAtIndex:2];
            [cell.rightBtn addTarget:self action:@selector(newAccount:) forControlEvents:UIControlEventTouchUpInside];
        }
       
        return cell;
    }
    if (indexPath.row==4) {
        Class cls = [AgreementCell class];
        AgreementCell * cell = [tableView dequeueReusableCellWithIdentifier:@"AgreementCell"];
        if (!cell) {
            cell = [[SDKBundle loadNibNamed:@"Cells" owner:nil options:nil] objectAtIndex:5];
            [cell.checkBtn addTarget:self action:@selector(checkBtnDidClick:) forControlEvents:UIControlEventTouchUpInside];
            [cell.detailBtn addTarget:self action:@selector(detailBtnDidClick:) forControlEvents:UIControlEventTouchUpInside];
        }
        return cell;
    }
//
    if (indexPath.row==5) {
        Class cls = [LoginBtnCell class];
        LoginBtnCell * cell = [tableView dequeueReusableCellWithIdentifier:@"LoginBtnCell"];
        if (!cell) {
            cell = [[SDKBundle loadNibNamed:@"Cells" owner:nil options:nil] objectAtIndex:4];
            [cell.loginBtn addTarget:self action:@selector(loginBtnDidClick:) forControlEvents:UIControlEventTouchUpInside];
        }
        
        return cell;
    }
    
    return [UITableViewCell new];
}



- (void)historyAccount:(UIButton *)btn {
    
    NSLog(@"===historyAccount===");
    btn.selected = !btn.selected;
    [self rotateBtn:btn];
    HistoryAccountsVC *hisVC = [[HistoryAccountsVC alloc] initWithNibName:@"HistoryAccounts" bundle:SDKBundle];
    [self addChildViewController:hisVC];
    [self.view addSubview:hisVC.view];
    //frame转换：得到inputField这个frame在self.view中的情况(x,y,w，h)
    CGRect cellRect = [self.accountCell convertRect:self.accountCell.inputField.frame toView:self.view];
    CGFloat viewX = cellRect.origin.x;
    CGFloat viewY = CGRectGetMaxY(cellRect);
    CGFloat viewW = cellRect.size.width;
    CGFloat viewH = 150;
    hisVC.view.frame = CGRectMake(viewX,viewY,viewW,viewH);
    [hisVC didMoveToParentViewController:self];
    
}

- (void)showPwd:(UIButton *)btn {
    
    NSLog(@"===showPwd===");
    
}

- (void)newAccount:(UIButton *)btn {
    
    NSLog(@"===newAccount===");
    UIViewController *viewController = [UIApplication sharedApplication].keyWindow.rootViewController;
  
    
    AccountRegisterViewController *baseVC = [[AccountRegisterViewController alloc] initWithNibName:@"AccountRegisterView" bundle:SDKBundle];
    [baseVC setModalTransitionStyle:(UIModalTransitionStyleFlipHorizontal)];
    [baseVC setModalPresentationStyle:UIModalPresentationCustom];
    
    [self dismissViewControllerAnimated:YES completion:^{
        [viewController presentViewController:baseVC animated:YES completion:nil];
    }];
}

- (void)checkBtnDidClick:(UIButton *)btn {
    
    NSLog(@"===checkBtnDidClick===");
}


- (void)detailBtnDidClick:(UIButton *)btn {
    
    NSLog(@"===detailBtnDidClick===");
//    TableViewController *tableVC = [[TableViewController alloc] initWithNibName:@"TableViewController" bundle:SDKBundle];
//    [self addChildViewController:tableVC];
//    [self.view addSubview:tableVC.view];
//    CGRect cellRect = [self.accountCell convertRect:self.accountCell.inputField.frame toView:self.view];
//    CGFloat viewX = cellRect.origin.x;
//    CGFloat viewY = CGRectGetMaxY(cellRect);
//    CGFloat viewW = cellRect.size.width;
//    CGFloat viewH = 150;
//    tableVC.view.frame = CGRectMake(viewX,viewY,viewW,viewH);
//    [tableVC didMoveToParentViewController:self];
    
}

//按钮旋转动画
-(void)rotateBtn:(UIButton*)btn{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.fromValue = [NSNumber numberWithFloat:0.f];
    animation.toValue = [NSNumber numberWithFloat: M_PI];
    animation.duration = .3f;
    //动画节奏：匀速
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    animation.autoreverses = NO;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.repeatCount = 1; //如果这里想设置成一直自旋转，可以设置为MAXFLOAT，否则设置具体的数值则代表执行多少次
    [btn.layer addAnimation:animation forKey:nil];
}

- (void)loginBtnDidClick:(UIButton *)btn {
    
    NSLog(@"===loginBtnDidClick===");
    
    [self dismissViewControllerAnimated:YES completion:^{
    
        [self autoLoginWithVC:nil];
    }];
}

-(void)autoLoginWithVC:(UIViewController* _Nullable)vc{
    
    
    AutoLoginController * autoVC = [[AutoLoginController alloc] initWithNibName:@"AutoLoginView" bundle:SDKBundle];
    [autoVC setModalPresentationStyle:UIModalPresentationCustom];
    
    UIViewController *rootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    [rootVC presentViewController:autoVC animated:YES completion:nil];
    
    
}

@end

