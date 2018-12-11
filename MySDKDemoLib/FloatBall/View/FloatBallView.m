//
//  FloatBallView.m
//  FloatBallDemo
//
//  Created by kaola  on 2018/3/13.
//  Copyright © 2018年 kaola . All rights reserved.
//

#import "FloatBallView.h"
#import <Masonry.h>
//#import <Masonry.h>

NSString * const kFloatBallCenterKey = @"float_ball_center_key";

@interface FloatBallView () {
    
    UIButton *_floatBtn;
}

@property(nonatomic,strong) NSTimer *timer;

@property(nonatomic,assign) NSTimeInterval leftTimeInterval;

@property(nonatomic,assign) BOOL isBallFaded;

@end

@implementation FloatBallView

- (void)dealloc {
    
    DBLog(@"--- dealloc --- 悬浮球，销毁了 --- %@", self.class);
    [self invalidateTimer];
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self setupSelf];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    if (self = [super initWithCoder:aDecoder]) {
        
        [self setupSelf];
    }
    return self;
}

- (void)setupSelf {
    
    self.clipsToBounds = YES;
    
    __weak typeof(self) weakSelf = self;
    [self.floatBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.equalTo(weakSelf.mas_height);
        make.top.leading.bottom.equalTo(weakSelf);
    }];
    
    [self.floatBtn addTarget:self action:@selector(ballDidClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIPanGestureRecognizer *panG = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(PanGestureRecognizer:)];
    [self.floatBtn addGestureRecognizer:panG];
}

static NSInteger AdjustTimes = 0;
- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    AdjustTimes++;
    DBLog(@"layoutSubviews : %@", @(AdjustTimes));
    
    CGFloat BallW_2 = self.bounds.size.width * .5;
    CGFloat BallH_2 = self.bounds.size.height * .5;
    
    self.floatBtn.layer.cornerRadius = BallH_2;
    
    // 1、现在的位置
    CGPoint center = self.center;
    CGPoint SuperCenter = (self.superview ?: nil).center;
    center.y = (center.y - BallH_2) > 0 ? center.y : self.bounds.size.height * .5 + 20.f;
    center.y = (center.y + BallH_2 - self.superview.bounds.size.height) < 0 ? center.y : (self.superview.bounds.size.height - BallH_2);
    
    // 2、左右比较
    center.x = BallW_2; // 在左边
    self.position = FloatBallPositionLeft;
    if (self.center.x - SuperCenter.x > 0) {
        
        // 在右边
        center.x = self.superview.bounds.size.width - self.bounds.size.width * .5;
        self.position = FloatBallPositionRight;
    }
    
    self.center = center;
}

- (CGPoint)configSelf {
    
    // 1: 记住 + 有记录
    // 2: 其他
    
    if (self.isRememberUerOperation) {
        
        CGPoint point = [self fetchUserCenterHistoryLocation];
        
        if (!CGPointEqualToPoint(CGPointZero, point)) {
            
            DBLog(@"有记录：%@", NSStringFromCGPoint(point));
            // 有记录
            return point;
        }
    }
    
    CGFloat ViewW = self.superview.bounds.size.width;
    CGFloat ViewH = self.superview.bounds.size.height;
    
    CGPoint center = CGPointMake(self.floatBallHeight * .5f, ViewH * .5f);
    
    switch (self.floatStyle) {
        case FloatBallStyleCenterLeft:
        {
            // 左中
            
        }
            break;
        case FloatBallStyleCenterRight:
        {
            // 右中
            center.x = ViewW - self.floatBallHeight * .5f;
        }
            break;
        case FloatBallStyleTopLeft:
        {
            // 左上
            
            center.y = self.edgeInsets.top + self.floatBallHeight * .5f;
        }
            break;
        case FloatBallStyleTopRight:
        {
            // 右上
            center.x = ViewW - self.floatBallHeight * .5f;
            center.y = self.edgeInsets.top + self.floatBallHeight * .5f;
        }
            break;
        case FloatBallStyleBottomLeft:
        {
            // 左下
            center.y = ViewH - self.floatBallHeight * .5f;
        }
            break;
        case FloatBallStyleBottomRight:
        {
            // 右下
            center.x = ViewW - self.floatBallHeight * .5f;
            center.y = ViewH - self.floatBallHeight * .5f;
        }
            break;
            
        default:
            break;
    }
    
    DBLog(@"计算出的center为：%@", NSStringFromCGPoint(center));
    
    return center;
}

#pragma mark - methods
- (void)ballDidClick:(UIButton *)ball {
    
    if (self.isBallFaded) {
        
        // 隐藏状态
        // 展示悬浮球，并不触发点击事件
        __weak typeof(self) weakSelf = self;
        [self adjustBallFrameWithCompleteHandler:^{
            
            [weakSelf startTimer];
        }];
        self.isBallFaded = NO;
        
        return;
    }
    
    [self invalidateTimer];
    if (self.floatBallDidClickAction) {
        self.floatBallDidClickAction(ball);
    }
}

- (void)PanGestureRecognizer:(UIPanGestureRecognizer *)pan {
    
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:
        {
            // 开始
            [self invalidateTimer];
            self.alpha = 1.f;
            self.isBallFaded = NO;
            
            if (self.panGestureRecognizerBeganAction) {
                self.panGestureRecognizerBeganAction(pan);
            }
        }
            break;
        case UIGestureRecognizerStateChanged:
        {
            // 变化
            CGPoint point = [pan locationInView:self.superview];
            self.center = point;
        }
            break;
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateFailed:
        case UIGestureRecognizerStateEnded:
        {
            DBLog(@"state : %@", @(pan.state));
            // cancel || fail || end
            __weak typeof(self) weakSelf = self;
            [self adjustBallFrameWithCompleteHandler:^{
                
                [weakSelf startTimer];
            }];
        }
            break;
            
        default:
        {
            
            DBLog(@"state : %@", @(pan.state));
        }
            break;
    }
}

#pragma mark - methods
- (void)adjustBallFrameWithCompleteHandler:(void(^)(void))completeHandler {
    
    DBLog(@"adjustBallFrame");
    
    CGFloat BallW_2 = self.bounds.size.width * .5;
    CGFloat BallH_2 = self.bounds.size.height * .5;
    
    // 1、现在的位置
    CGPoint center = self.center;
    CGPoint SuperCenter = (self.superview ?: nil).center;
    center.y = (center.y - BallH_2) > 0 ? center.y : self.bounds.size.height * .5 + 20.f;
    center.y = (center.y + BallH_2 - self.superview.bounds.size.height) < 0 ? center.y : (self.superview.bounds.size.height - BallH_2);
    
    // 2、左右比较
    center.x = BallW_2; // 在左边
    self.position = FloatBallPositionLeft;
    if (self.center.x - SuperCenter.x > 0) {
        
        // 在右边
        center.x = self.superview.bounds.size.width - self.bounds.size.width * .5;
        self.position = FloatBallPositionRight;
    }
    
    [self restoreUserCenterLocationWithPoint:center];
    
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:.25 animations:^{
        
        // 3、回到边上
        weakSelf.center = center;
        weakSelf.alpha = 1.f;
        
    } completion:^(BOOL finished) {
        
        if (self.floatBallFrameAdjustCompletedAction) {
            self.floatBallFrameAdjustCompletedAction(self);
        }
        
        // 4、开始倒数三个数，三个数后，隐藏起来
        if (completeHandler) {
            completeHandler();
        }
    }];
}


/**
 记录用户移动的位置
 
 @param point center
 */
- (void)restoreUserCenterLocationWithPoint:(CGPoint)point {
    
    if (self.isRememberUerOperation) {
        
        // 记录用户移动球的位置
        [[NSUserDefaults standardUserDefaults] setObject:NSStringFromCGPoint(point) forKey:[FloatBallView theRememberKeyWithUserPrefix:self.userPrefix]];
        
//        DBLog(@"记录了位置：%@", NSStringFromCGPoint(point));
    }
}

/** 获取历史的定位 */
- (CGPoint)fetchUserCenterHistoryLocation {
    
    if (self.isRememberUerOperation) {
        
        return CGPointFromString([[NSUserDefaults standardUserDefaults] objectForKey:[FloatBallView theRememberKeyWithUserPrefix:self.userPrefix]]);
    }
    
    return CGPointZero;
}

/** 获取第一次展示的center */
- (CGPoint)fetchInitCenter {
    
    return [self configSelf];
}

+ (NSString *)theRememberKeyWithUserPrefix:(NSString *)userPrefix {
    
    return [NSString stringWithFormat:@"%@_%@", userPrefix ?: @"", kFloatBallCenterKey];
}

- (void)startCountdown {
    
    [self startTimer];
}
- (void)stopCountdown {
    
    [self invalidateTimer];
}

- (void)startTimer {
    
    [self invalidateTimer];
    [self timer];
}

- (void)invalidateTimer {
    
    if (_timer.isValid) {
        [_timer invalidate];
        _timer = nil;
    }
}

- (void)timerAction:(NSTimer *)timer {
    
    self.leftTimeInterval--;
    
//    DBLog(@"float ball timerAction : %@", @(self.leftTimeInterval));
    
    if (self.leftTimeInterval <= 0) {
        
        if (self.floatBallWillHiddenAction) {
            
            if (self.leftTimeInterval <= -2) {
                
                [self invalidateTimer];
                [self hiddenFloatBallView];
                return;
            }
            else if (self.leftTimeInterval == 0) {
                
                self.floatBallWillHiddenAction(self);
            }
            
            return;
        }
        
        [self hiddenFloatBallView];
    }
}

- (void)hiddenFloatBallView {
    
    // 倒计时完毕
    [self invalidateTimer];
    
    // 改变ball的状态
    CGPoint newCenter = self.center;
    if (self.position == FloatBallPositionLeft) {
        
        // 在左边
        newCenter.x = 0.f;
        
    } else if (self.position == FloatBallPositionRight) {
        
        // 在右边
        newCenter.x = CGRectGetMaxX(self.superview.bounds);
    }
    
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:.25 animations:^{
        
        weakSelf.center = newCenter;
        weakSelf.alpha = 0.5;
        
    } completion:^(BOOL finished) {
        
        weakSelf.isBallFaded = YES;
        
        if (self.floatBallFadedCompletedAction) {
            self.floatBallFadedCompletedAction(self);
        }
    }];
}

#pragma mark - Getter && Setter
- (NSTimer *)timer {
    
    if (!_timer) {
        
        self.leftTimeInterval = self.waitTimeInterval;
        _timer = [NSTimer timerWithTimeInterval:1.f target:self selector:@selector(timerAction:) userInfo:NULL repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
    
    return _timer;
}

- (UIButton *)floatBtn {
    
    if (_floatBtn) {
        return _floatBtn;
    }
    
    _floatBtn = [UIButton new];
    [self addSubview:_floatBtn];
    
    [_floatBtn setBackgroundImage: res_float_ball forState:UIControlStateNormal];
    [_floatBtn setBackgroundImage: res_float_ball_down forState:UIControlStateHighlighted];
//    _floatBtn.backgroundColor = [UIColor orangeColor];
    
    return _floatBtn;
}

- (UIEdgeInsets)edgeInsets {
    
    if (!UIEdgeInsetsEqualToEdgeInsets(_edgeInsets, UIEdgeInsetsZero)) {
        return _edgeInsets;
    }
    
    _edgeInsets = UIEdgeInsetsMake(KKSTATUSBAR_HEIGHT, 0, 0, 0);
    
    return _edgeInsets;
}

@end
