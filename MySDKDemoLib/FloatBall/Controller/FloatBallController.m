//
//  FloatBallController.m
//  FloatBallDemo
//
//  Created by kaola  on 2018/3/13.
//  Copyright © 2018年 kaola . All rights reserved.
//

#import "FloatBallController.h"

#import "FloatBallView.h"
//#import "FloatExtendView.h"

#import <Masonry.h>

@interface FloatBallController () {
    
    FloatBallView *_floatView;
}

@property(nonatomic, assign) CGFloat originHeight;
@property(nonatomic, assign) CGRect leftExtendOriginFrame;
@property(nonatomic, assign) CGRect rightExtendOriginFrame;

@property(nonatomic, strong) UITapGestureRecognizer *tapG;

/** 展示次数计数：第一次会展示动画  */
@property(nonatomic, assign) NSInteger displayCount;

/** 球和展开部分交接的距离  */
@property(nonatomic, assign) CGFloat interPadding;

/** 左边是否展开  */
@property(nonatomic, assign) BOOL isLeftExtend;

/** 右边是否展开  */
@property(nonatomic, assign) BOOL isRightExtend;

@end

@implementation FloatBallController

- (void)loadView {
    
    self.view = self.floatView;
}

- (void)dealloc {
    
    DBLog(@"悬浮球，销毁了 --- %@ ---", self);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor clearColor];
    self.view.clipsToBounds = YES;
    
    self.floatView.waitTimeInterval = 5.f;
    
    __weak typeof(self) weakSelf = self;
    [self.floatView setFloatBallDidClickAction:^(UIButton *ball) {
        
        DBLog(@"展示extend view");
        
        if (weakSelf.floatView.position == FloatBallPositionLeft) {
            // 展示extend view
            [weakSelf setupLeftExtendViewWithCompletion:NULL];
        }
        else {
            
            [weakSelf setupRightExtendViewWithCompletion:NULL];
        }
        
        [weakSelf.floatView startCountdown];
    }];
    
    [self.floatView setFloatBallWillHiddenAction:^(FloatBallView *floatBall) {
        
        if (weakSelf.isLeftExtend) {
            
            // 合上extend view
            [weakSelf setupLeftExtendViewWithCompletion:NULL];
            
            return ;
        }
        else if (weakSelf.isRightExtend) {
            
            // 合上extend view
            [weakSelf setupRightExtendViewWithCompletion:NULL];
        }
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    if (self.displayCount)  return;
    
    self.view.transform = CGAffineTransformMakeScale(.1f, .1f);
    self.view.alpha = .01f;
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    if (self.displayCount) return;
    
    self.displayCount++;
    weakSelf();
    [UIView animateWithDuration:KKFloatBallAnimationDuration delay:0.f usingSpringWithDamping:.5f initialSpringVelocity:10.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        weakSelf.view.transform = CGAffineTransformIdentity;
        weakSelf.view.alpha = 1.f;
        
    } completion:^(BOOL finished) {
        
        [weakSelf.floatView startCountdown];
    }];
}

/**
 设置，并获得这个float ball管理对象
 
 @param viewController float ball展示在这上面的vc
 @param height 高度
 @param interPadding 球和extend view之间的padding
 @param isRemberUserOperation 是否记住用户最后一次拖动的位置
 @param userPrefix 不同用户的标识，用来记住不同用户的标识
 @param initFloatStyle 初始化float ball时候的初始位置
 @return float ball的管理对象
 */
+ (instancetype)fetchFloatBallControllerWithViewController:(UIViewController *)viewController
                                                    height:(CGFloat)height
                                              interPadding:(CGFloat)interPadding
                                     isRemberUserOperation:(BOOL)isRemberUserOperation
                                                userPrefix:(NSString *)userPrefix
                                            initFloatStyle:(FloatBallStyle)initFloatStyle {
    
    FloatBallController *floatVc = [FloatBallController new];
    
    floatVc.interPadding = interPadding;
    [viewController addChildViewController:floatVc];
    [viewController.view addSubview:floatVc.view];
    floatVc.originHeight = height;
    floatVc.floatView.floatBallHeight = height;
    floatVc.floatView.isRememberUerOperation = isRemberUserOperation;
    floatVc.floatView.userPrefix = userPrefix;
    floatVc.floatView.floatStyle = initFloatStyle;
    
    CGPoint center = [floatVc.floatView fetchInitCenter];
    DBLog(@"获得的center：%@", NSStringFromCGPoint(center));
    
    if (!center.x) {
        center.x = height * .5f;
    }
    __weak typeof(viewController) weakVc = viewController;
    [floatVc.view mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakVc.view).offset(center.y - height * .5f);
        make.leading.equalTo(weakVc.view).offset(center.x - height * .5f);
        make.height.mas_equalTo(height);
        make.width.mas_equalTo(height);
    }];
    
    weak(floatVc, weakFloat);
    [floatVc.floatView setFloatBallFrameAdjustCompletedAction:^(FloatBallView *ball) {

        [weakFloat adjustFloatBallContrains];
    }];

    [floatVc.floatView setFloatBallFadedCompletedAction:^(FloatBallView *ball) {

        [weakFloat adjustFloatBallContrains];
    }];
    
    floatVc.view.layer.cornerRadius = height * .5f;
    
    return floatVc;
}

- (void)adjustFloatBallContrains {
    
    CGPoint center = self.view.center;
    CGFloat height = self.view.bounds.size.height;
    __weak typeof(self.parentViewController) weakVc = self.parentViewController;
    [self.view mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakVc.view).offset(center.y - height * .5f);
        make.leading.equalTo(weakVc.view).offset(center.x - height * .5f);
        make.height.mas_equalTo(height);
        make.width.mas_equalTo(height);
    }];
}

- (void)setupTap {
    
    [self.view.superview addGestureRecognizer:self.tapG];
}

- (void)removeTap {
    
    [self.view.superview removeGestureRecognizer:self.tapG];
    self.tapG = nil;
}

- (void)tapAction:(UITapGestureRecognizer *)tap {
    
    if (self.floatView.position == FloatBallPositionLeft) {
        
        [self setupLeftExtendViewWithCompletion:NULL];
    }
    else if (self.floatView.position == FloatBallPositionRight) {
        
        [self setupRightExtendViewWithCompletion:NULL];
    }
    
    [self.floatView startCountdown];
}

- (void)setupRightExtendViewWithCompletion:(void(^)(void))completion {
    
    self.rightExtendView.hidden = NO;
    self.rightExtendView.alpha = 1.f;
    self.leftExtendView.hidden = YES;
    self.isRightExtend = !self.isRightExtend;
    
    CGRect frame = self.view.frame;
    CGFloat TopOffset = frame.origin.y;
    
    CGFloat HeightOffset = self.originHeight;
    
    CGFloat WidthOffset = 0.f;
    CGFloat FloatBtnLeadingOffset = 0;
    if (self.isRightExtend) {
        
        // 展开
        WidthOffset = self.rightExtendOriginFrame.size.width + self.originHeight;
        FloatBtnLeadingOffset = self.rightExtendOriginFrame.size.width;
        // 添加一个合悬浮球的手势
        [self setupTap];
    }
    else {
        
        // 合上
        WidthOffset = self.originHeight;
        // 去掉合悬浮球的手势
        [self removeTap];
    }
    
    CGFloat LeadingOffset = 0;
    LeadingOffset = self.view.superview.bounds.size.width - WidthOffset;
    
    __weak typeof(self) weakSelf = self;
    __weak typeof(self.view.superview) weakV = self.view.superview;
    [self.view mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakV).offset(TopOffset);
        make.leading.equalTo(weakV).offset(LeadingOffset);
        make.width.mas_equalTo(WidthOffset);
        make.height.mas_equalTo(HeightOffset);
    }];
    
    [self.floatView.floatBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.leading.equalTo(weakSelf.floatView).offset(FloatBtnLeadingOffset);
        make.top.bottom.equalTo(weakSelf.floatView);
        make.width.equalTo(@(WidthOffset));
    }];
    
    [UIView animateWithDuration:KKFloatBallAnimationDuration animations:^{
        
        [weakSelf.view layoutIfNeeded];
        
    } completion:^(BOOL finished) {
        
        if (!self.isRightExtend) {
            self.rightExtendView.alpha = 0.01f;
        }
        
        if (completion) {
            completion();
        }
    }];
    
}

- (void)setupLeftExtendViewWithCompletion:(void(^)(void))completion {
    
    self.rightExtendView.hidden = YES;
    self.leftExtendView.hidden = NO;
    self.leftExtendView.alpha = 1.f;
    self.isLeftExtend = !self.isLeftExtend;
    
    CGRect frame = self.view.frame;
    CGFloat TopOffset = frame.origin.y;
    
    CGFloat HeightOffset = self.originHeight;
    
    CGFloat WidthOffset = 0.f;
    
    if (self.isLeftExtend) {
        
        // 展开
        WidthOffset = self.leftExtendOriginFrame.size.width + self.originHeight;
        // 添加一个合悬浮球的手势
        [self setupTap];
    }
    else {
        
        // 合上
        WidthOffset = self.originHeight;
        // 去掉合悬浮球的手势
        [self removeTap];
    }
    
    CGFloat LeadingOffset = 0.f;
//    if (self.floatView.position == FloatBallPositionRight) {
//
//        LeadingOffset = - (self.view.superview.bounds.size.width - (self.originHeight + self.leftExtendOriginFrame.size.width));
//    }
    
    __weak typeof(self) weakSelf = self;
    __weak typeof(self.view.superview) weakV = self.view.superview;
    [self.view mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakV).offset(TopOffset);
        make.leading.equalTo(weakV).offset(LeadingOffset);
        make.width.mas_equalTo(WidthOffset);
        make.height.mas_equalTo(HeightOffset);
    }];
    
    [self.floatView.floatBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.leading.equalTo(weakSelf.floatView);
        make.top.bottom.equalTo(weakSelf.floatView);
        make.width.equalTo(@(WidthOffset));
    }];
    
    [UIView animateWithDuration:KKFloatBallAnimationDuration animations:^{
        
        [weakSelf.view layoutIfNeeded];
        
    } completion:^(BOOL finished) {
        
        if (!self.isLeftExtend) {
            self.leftExtendView.alpha = 0.01f;
        }
        if (completion) {
            completion();
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 隐藏ball
- (void)removeTheFloatBall {
    
    [self.tapG removeTarget:self action:@selector(tapAction:)];
    
    weakSelf();
    if (self.isLeftExtend) {
        
        [self setupLeftExtendViewWithCompletion:^{
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.3f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [weakSelf freeTheBall];
            });
        }];
        return;
    }
    else if (self.isRightExtend) {
        
        [self setupRightExtendViewWithCompletion:^{
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.3f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [weakSelf freeTheBall];
            });
        }];
        return;
    }
    
    [self freeTheBall];
}

- (void)freeTheBall {
    
    weakSelf();
    [UIView animateWithDuration:KKFloatBallAnimationDuration animations:^{
        
        weakSelf.view.transform = CGAffineTransformMakeScale(.01f, .01f);
        weakSelf.view.alpha = .01f;
        
    } completion:^(BOOL finished) {
        
        [weakSelf.view removeFromSuperview];
        [weakSelf removeFromParentViewController];
    }];
}

#pragma mark - Getter & Setter
- (FloatBallView *)floatView {
    
    if (_floatView) {
        return _floatView;
    }
    
    _floatView = [FloatBallView new];
    
    __weak typeof(self) weakSelf = self;
    [_floatView setPanGestureRecognizerBeganAction:^(UIPanGestureRecognizer *pan) {
        
        if (weakSelf.isLeftExtend) {
            pan.enabled = NO;
            [weakSelf setupLeftExtendViewWithCompletion:NULL];
            pan.enabled = YES;
        }
        else if (weakSelf.isRightExtend) {
            
            pan.enabled = NO;
            [weakSelf setupRightExtendViewWithCompletion:NULL];
            pan.enabled = YES;
        }
    }];
    
    return _floatView;
}

- (void)setLeftExtendView:(UIView *)leftExtendView {
    
    if ([_leftExtendView isEqual:leftExtendView]) {
        return;
    }
    
    leftExtendView.alpha = .01f;
    _leftExtendView = leftExtendView;
    [self.view addSubview:leftExtendView];
    [self.view bringSubviewToFront:self.floatView.floatBtn];
    self.leftExtendOriginFrame = leftExtendView.frame;
    
    __weak typeof(self) weakSelf = self;
    [leftExtendView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.trailing.equalTo(weakSelf.view);
        make.centerY.equalTo(weakSelf.view);
        make.height.equalTo(@(weakSelf.leftExtendOriginFrame.size.height));
        make.width.mas_equalTo(weakSelf.leftExtendOriginFrame.size.width + weakSelf.interPadding);
    }];
}

- (void)setRightExtendView:(UIView *)rightExtendView {
    
    if ([_rightExtendView isEqual:rightExtendView]) {
        return;
    }
    
    rightExtendView.alpha = .01f;
    _rightExtendView = rightExtendView;
    [self.view addSubview:rightExtendView];
    [self.view bringSubviewToFront:self.floatView.floatBtn];
    self.rightExtendOriginFrame = rightExtendView.frame;
    
    __weak typeof(self) weakSelf = self;
    [rightExtendView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.leading.equalTo(weakSelf.view);
        make.centerY.equalTo(weakSelf.view);
        make.height.mas_equalTo(weakSelf.rightExtendOriginFrame.size.height);
        make.width.mas_equalTo(weakSelf.rightExtendOriginFrame.size.width + weakSelf.interPadding);
    }];
}

- (UITapGestureRecognizer *)tapG {
    
    if (_tapG) {
        return _tapG;
    }
    
    _tapG = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    
    return _tapG;
}


@end
