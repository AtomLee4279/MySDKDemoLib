//
//  FloatLeftExtendView.m
//  KoalaGameKit
//
//  Created by kaola  on 2018/3/15.
//  Copyright © 2018年 kaola . All rights reserved.
//

#import "FloatLeftExtendView.h"

@interface FloatLeftExtendView ()

@property(nonatomic, strong) UIButton *oneBtn;
@property(nonatomic, strong) UIButton *twoBtn;
@property(nonatomic, strong) UIButton *threeBtn;
@property(nonatomic, strong) UIButton *fourBtn;

// btns之间的竖线
@property(nonatomic, strong) NSArray<UIImageView *> *lines;

@property(nonatomic, strong) CAShapeLayer *theMaskLayer;

@end

static CGFloat const FloatLeftExtendViewBtnWidth = 60.f;
static CGFloat const FloatLeftExtendViewArcWidth = 15.f;
// 高度
static CGFloat FloatLeftExtendViewHeight = 50.f;
@implementation FloatLeftExtendView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self prepareUI];
    }
    return self;
}

+ (CGSize)viewHeightWithModel:(nullable id)model {
    
    return CGSizeMake(KKWIDTH(FloatLeftExtendViewBtnWidth) * 4 + KKWIDTH(FloatLeftExtendViewArcWidth), KKWIDTH(FloatLeftExtendViewHeight));
}

- (void)prepareUI {
    
    self.layer.mask = self.theMaskLayer;
    
    self.backgroundColor = [UIColor colorWithPatternImage:res_float_bg];
    
    CGFloat margin = KKHEIGHT(8.f);
    
    __weak typeof(self) weakSelf = self;
    [self.fourBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.trailing.equalTo(weakSelf);
        make.top.equalTo(weakSelf).offset(margin);
        make.bottom.equalTo(weakSelf).offset(-margin);
        make.width.equalTo(@(KKWIDTH(FloatLeftExtendViewBtnWidth)));
    }];
    
    [self.threeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.trailing.equalTo(weakSelf.fourBtn.mas_leading);
        make.top.equalTo(weakSelf).offset(margin);
        make.bottom.equalTo(weakSelf).offset(-margin);
        make.width.equalTo(@(KKWIDTH(FloatLeftExtendViewBtnWidth)));
    }];
    
    [self.twoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.trailing.equalTo(weakSelf.threeBtn.mas_leading);
        make.top.equalTo(weakSelf).offset(margin);
        make.bottom.equalTo(weakSelf).offset(-margin);
        make.width.equalTo(@(KKWIDTH(FloatLeftExtendViewBtnWidth)));
    }];
    
    [self.oneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.trailing.equalTo(weakSelf.twoBtn.mas_leading);
        make.top.equalTo(weakSelf).offset(margin);
        make.bottom.equalTo(weakSelf).offset(-margin);
        make.width.equalTo(@(KKWIDTH(FloatLeftExtendViewBtnWidth)));
    }];
    
    // 3 X 105
    NSInteger linIndex = 0;
    UIButton *btn = nil;
    for (UIImageView *imgView in self.lines) {
        
        switch (linIndex) {
            case 0:
                btn = weakSelf.oneBtn;
                break;
            case 1:
                btn = weakSelf.twoBtn;
                break;
            case 2:
                btn = weakSelf.threeBtn;
                break;
                
            default:
                break;
        }
        
        [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.leading.equalTo(btn.mas_trailing).offset(KKWIDTH(-.5f));
            make.top.bottom.equalTo(weakSelf.oneBtn);
            make.width.mas_equalTo(KKWIDTH(1.f));
        }];
        
        linIndex++;
    }

    [self.oneBtn addTarget:self action:@selector(oneBtnDidClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.twoBtn addTarget:self action:@selector(twoBtnDidClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.threeBtn addTarget:self action:@selector(threeBtnDidClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.fourBtn addTarget:self action:@selector(fourBtnDidClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)oneBtnDidClick:(UIButton *)btn {
    
    if (self.extendBtnsDidClickAction) {
        self.extendBtnsDidClickAction(0, btn);
    }
}

- (void)twoBtnDidClick:(UIButton *)btn {
    
    if (self.extendBtnsDidClickAction) {
        self.extendBtnsDidClickAction(1, btn);
    }
}

- (void)threeBtnDidClick:(UIButton *)btn {
    
    if (self.extendBtnsDidClickAction) {
        self.extendBtnsDidClickAction(2, btn);
    }
}

- (void)fourBtnDidClick:(UIButton *)btn {
    
    if (self.extendBtnsDidClickAction) {
        self.extendBtnsDidClickAction(3, btn);
    }
}


#pragma mark - Getter & Setter
- (UIButton *)oneBtn {
    
    if (_oneBtn) {
        return _oneBtn;
    }
    
    _oneBtn = [UIButton new];
    [_oneBtn setImage: res_float_user forState:UIControlStateNormal];
    [_oneBtn setImage: res_float_user_down forState:UIControlStateHighlighted];
    _oneBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:_oneBtn];
    
    return _oneBtn;
}

- (UIButton *)twoBtn {
    
    if (_twoBtn) {
        return _twoBtn;
    }
    
    _twoBtn = [UIButton new];
    
    [_twoBtn setImage: res_float_service forState:UIControlStateNormal];
    [_twoBtn setImage: res_float_service_down forState:UIControlStateHighlighted];
    _twoBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:_twoBtn];
    
    return _twoBtn;
}

- (UIButton *)threeBtn {
    
    if (_threeBtn) {
        return _threeBtn;
    }
    
    _threeBtn = [UIButton new];
    [_threeBtn setImage: res_float_gl forState:UIControlStateNormal];
    [_threeBtn setImage: res_float_gl_down forState:UIControlStateHighlighted];
    _threeBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:_threeBtn];
    
    return _threeBtn;
}

- (UIButton *)fourBtn {
    
    if (_fourBtn) {
        return _fourBtn;
    }
    
    _fourBtn = [UIButton new];
    [_fourBtn setImage: res_float_hide forState:UIControlStateNormal];
    [_fourBtn setImage: res_float_hide_down forState:UIControlStateHighlighted];
    _fourBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:_fourBtn];
    
    return _fourBtn;
}

- (NSArray<UIImageView *> *)lines {
    
    if (_lines) {
        return _lines;
    }
    
    NSMutableArray *linM = [NSMutableArray array];
    
    for (NSInteger idx = 0; idx < 3; idx++) {
        
        UIImageView *line = [[UIImageView alloc] initWithImage: res_float_split];
        [self addSubview:line];
        [linM addObject:line];
    }
    
    _lines = linM;
    
    return _lines;
}

- (CAShapeLayer *)theMaskLayer {
    
    if (_theMaskLayer) {
        return _theMaskLayer;
    }
    
    CGSize size = [FloatLeftExtendView viewHeightWithModel:NULL];
    CGFloat minX = 0.f;
    
    _theMaskLayer = [CAShapeLayer layer];
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(minX, 0)];
    
    // 画半圆弧
    CGFloat arcRadius = size.height * .5f;
    CGPoint arcCenter = CGPointMake(size.width - arcRadius, arcRadius);
    [path addArcWithCenter:arcCenter radius:arcRadius startAngle:-M_PI_2 endAngle:M_PI_2 clockwise:YES];
    [path addLineToPoint:CGPointMake(minX, size.height)];
    
    // 曲线
    CGPoint center = CGPointMake(minX + KKWIDTH(FloatLeftExtendViewBtnWidth) * .5f, size.height * .5f);
    CGPoint po2 = CGPointMake(minX, 0);
    [path addQuadCurveToPoint:po2 controlPoint:center];
    
    _theMaskLayer.fillColor = [UIColor blackColor].CGColor;
    _theMaskLayer.path = path.CGPath;
    
    return _theMaskLayer;
}

@end
