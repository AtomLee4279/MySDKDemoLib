//
//  UIView+ActivityIndicatorView.m
//  FoxGameKit
//
//  Created by shun on 2017/9/25.
//  Copyright © 2017年 shunbang. All rights reserved.
//

#import "UIView+ActivityIndicatorView.h"
#import <objc/runtime.h>


@interface UIView ()

//@property(nonatomic,strong) UIImageView *bgImgView;
//@property(nonatomic,strong) UILabel *msgLabel;
@property(nonatomic,strong) UIView *bgCoverView;

@end

static char *_activityIndicatorView = "_activityIndicatorView";
static char *_bgCoverView = "_bgCoverView";
@implementation UIView (ActivityIndicatorView)

- (void)kk_startAnimating {
    
    if ([self kk_animating]) {
        return;
    }
    
    [self addSubview:self.activityIndicatorView];
    [self.activityIndicatorView startAnimating];
    
    __block __weak typeof(self) weakSelf = self;
    [self.activityIndicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(weakSelf);
    }];
}
- (BOOL)kk_animating {
    
    return self.activityIndicatorView.animating;
}

- (void)kk_stopAnimating {
    
    [self.activityIndicatorView stopAnimating];
    [self.activityIndicatorView removeFromSuperview];
}

- (void)kk_startAnimatingWithCover {
    
    [self addSubview:self.bgCoverView];
    
    weakSelf();
    [self.bgCoverView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(weakSelf);
    }];
    
    [self kk_startAnimating];
}

- (void)kk_stopAnimatingWithCover {
    
    [self kk_stopAnimating];
    
    [self.bgCoverView removeFromSuperview];
}

///// 菊花退下，显示message（会自动消失，不用手动隐藏）
//- (void)kk_showMessage:(NSString *)message {
//    
//    if (self.activityIndicatorView.animating) {
//        [self kk_stopAnimating];
//    }
//    
//    // 显示msg
//    
//}

#pragma mark - Getter && Setter
- (UIActivityIndicatorView *)activityIndicatorView {
    
    if (objc_getAssociatedObject(self, _activityIndicatorView)) {
        return objc_getAssociatedObject(self, _activityIndicatorView);
    }
    
    self.activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.activityIndicatorView.hidesWhenStopped = YES;
    
    return objc_getAssociatedObject(self, _activityIndicatorView);
}

- (void)setActivityIndicatorView:(UIActivityIndicatorView *)activityIndicatorView {
    
    objc_setAssociatedObject(self, _activityIndicatorView, activityIndicatorView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)bgCoverView {
    
    if (objc_getAssociatedObject(self, _bgCoverView)) {
        return objc_getAssociatedObject(self, _bgCoverView);
    }
    
    self.bgCoverView = [[UIView alloc] init];
    
    return objc_getAssociatedObject(self, _bgCoverView);
}

- (void)setBgCoverView:(UIView *)bgCoverView {
    
    objc_setAssociatedObject(self, _bgCoverView, bgCoverView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
