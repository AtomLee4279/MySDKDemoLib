//
//  UIView+ActivityIndicatorView.h
//  FoxGameKit
//
//  Created by shun on 2017/9/25.
//  Copyright © 2017年 shunbang. All rights reserved.
// 在view上转菊花

#import <UIKit/UIKit.h>

@interface UIView (ActivityIndicatorView)

- (void)kk_startAnimating;
- (BOOL)kk_animating;
- (void)kk_stopAnimating;

/** 菊花下面有一层遮罩  */
- (void)kk_startAnimatingWithCover;
- (void)kk_stopAnimatingWithCover;

///// 菊花退下，显示message（会自动消失，不用手动隐藏）--- 未完成
//- (void)kk_showMessage:(NSString *)message;

/// 可以修改的菊花的样式
@property(nonatomic,strong,readonly) UIActivityIndicatorView *activityIndicatorView;

@end
