//
//  FloatBallController.h
//  FloatBallDemo
//
//  Created by kaola  on 2018/3/13.
//  Copyright © 2018年 kaola . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FloatBallView.h"
/* 悬浮球的初始位置 */

@interface FloatBallController : UIViewController

@property(nonatomic, strong, readonly) FloatBallView *floatView;

/** 展开的extend view: 悬浮球在左边时展开的extend view */
@property(nonatomic,strong) UIView *leftExtendView;

/** 展开的extend view: 悬浮球在右边时展开的extend view */
@property(nonatomic,strong) UIView *rightExtendView;


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
                                            initFloatStyle:(FloatBallStyle)initFloatStyle;



/**
 移除这个float ball
 */
- (void)removeTheFloatBall;

@end
