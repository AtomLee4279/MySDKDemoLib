//
//  KKFloatCollectView.m
//  FloatBallDemo
//
//  Created by xiao on 2018/3/15.
//  Copyright © 2018年 kaola . All rights reserved.
//

#import "KKFloatCollectView.h"
#import "KKFloatSeparatorCollectCell.h"

static CGFloat itemWidth = 60.f;
static CGFloat itemHeight = 50.f;
static CGFloat margin = 15.f;// 分叉尾巴的宽度
static CGFloat padding = 2.f;// 头部延长部分的宽度
static CGFloat SeparatorWidth = 1.f; // 分割线的宽度

@interface KKFloatCollectView () <UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate>

@property(nonatomic, assign) BOOL isOrderLeft;

@property(nonatomic, strong) CAShapeLayer *theMaskLayer;

@end

@interface KKFloatCollectCell : UICollectionViewCell

@property(nonatomic, strong) UIButton *iconBtn;
@property(nonatomic, copy) void(^iconBtnDidClickAction)(UIButton *btn);

@end

@implementation KKFloatCollectView

+ (instancetype)collectionViewWithOrderLeft:(BOOL)orderLeft floatItems:(NSArray<KKFloatItem *> *)floatItems {
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
//    layout.itemSize = CGSizeMake(itemWidth, itemHeight);
    
    KKFloatCollectView *instance = [[self alloc] initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:layout];
    instance.dataSource = instance;
    instance.delegate = instance;
    instance.floatItems = floatItems;
    instance.bounces = NO;
    instance.isOrderLeft = orderLeft;
    
    instance.backgroundColor = [UIColor colorWithPatternImage:res_float_bg];
    instance.layer.mask = instance.theMaskLayer;
    
    [instance setupSelf];
    
    return instance;
}

- (void)setupSelf {
    
    [self registerClass:[KKFloatCollectCell class] forCellWithReuseIdentifier:@"KKFloatCollectCell"];
    [self registerClass:[KKFloatSeparatorCollectCell class] forCellWithReuseIdentifier:@"KKFloatSeparatorCollectCell"];
}

+ (CGSize)viewSizeWithModel:(NSArray<KKFloatItem *> *)model {
    
    return CGSizeMake((itemWidth + SeparatorWidth) * model.count + 1 + KKWIDTH(margin) + KKWIDTH(padding), itemHeight);
}

#pragma mark - <UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.floatItems.count * 2 - 1;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.item % 2 == 0) {
        
        // 浮标
        KKFloatItem *item = self.floatItems[indexPath.item / 2];
        KKFloatCollectCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"KKFloatCollectCell" forIndexPath:indexPath];
        [cell.iconBtn setImage:item.icon forState:UIControlStateNormal];
        [cell.iconBtn setImage:item.highlightIcon forState:UIControlStateHighlighted];
        weakSelf();
        [cell setIconBtnDidClickAction:^(UIButton *btn) {
            
            if (weakSelf.didSelectItemAtIndexPathAction) {
                weakSelf.didSelectItemAtIndexPathAction(weakSelf, item.actionTag, btn);
            }
        }];
        
        return cell;
        
    } else {
        
        // 分割线
        KKFloatSeparatorCollectCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"KKFloatSeparatorCollectCell" forIndexPath:indexPath];
        
        return cell;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.item % 2 == 0) {
        
        return CGSizeMake(itemWidth, itemHeight);
    } else {
        
        return CGSizeMake(SeparatorWidth, itemHeight);
    }
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    if (self.isOrderLeft) {
        
        return UIEdgeInsetsMake(0, KKWIDTH(margin), 0, KKWIDTH(padding));
    } else {
        return UIEdgeInsetsMake(0, KKWIDTH(padding), 0, KKWIDTH(margin));
    }
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    
    return CGFLOAT_MIN;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    
    return CGFLOAT_MIN;
}


#pragma mark - Getter & Setter
- (CAShapeLayer *)theMaskLayer {
    
    if (_theMaskLayer) {
        return _theMaskLayer;
    }
    
    if (self.isOrderLeft) {
        [self setupMaskLayerLeft];
    } else {
        [self setupMaskLayerRight];
    }
    
    return _theMaskLayer;
}

- (void)setupMaskLayerLeft {
    
    CGSize size = [KKFloatCollectView viewSizeWithModel:self.floatItems];
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
    CGPoint center = CGPointMake(minX + KKWIDTH(itemWidth) * .5f, size.height * .5f);
    CGPoint po2 = CGPointMake(minX, 0);
    [path addQuadCurveToPoint:po2 controlPoint:center];
    
//    _theMaskLayer.fillColor = [UIColor blackColor].CGColor;
    _theMaskLayer.path = path.CGPath;
}

- (void)setupMaskLayerRight {
    
    CGSize size = [KKFloatCollectView viewSizeWithModel:self.floatItems];
    
    _theMaskLayer = [CAShapeLayer layer];
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(size.width, 0)];
    
    // 画半圆弧
    CGFloat arcRadius = size.height * .5f;
    CGPoint arcCenter = CGPointMake(arcRadius, arcRadius);
    [path addArcWithCenter:arcCenter radius:arcRadius startAngle:-M_PI_2 endAngle:-M_PI_2 * 3 clockwise:NO];
    [path addLineToPoint:CGPointMake(0, size.height)];
    [path addLineToPoint:CGPointMake(size.width, size.height)];
    
    // 曲线
    CGPoint center = CGPointMake(size.width - KKWIDTH(itemWidth * .5f), size.height * .5f);
    CGPoint po2 = CGPointMake(size.width, 0);
    [path addQuadCurveToPoint:po2 controlPoint:center];
    
//    _theMaskLayer.fillColor = [UIColor blackColor].CGColor;
    _theMaskLayer.path = path.CGPath;
}

@end


@implementation KKFloatCollectCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self prepareUI];
    }
    
    return self;
}

- (void)prepareUI {
    
    self.backgroundColor = [UIColor clearColor];
    
    CGFloat iconMargin = KKHEIGHT(8.f);
    
    weakSelf();
    [self.iconBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.leading.equalTo(weakSelf);
        make.top.equalTo(weakSelf).offset(iconMargin);
        make.bottom.equalTo(weakSelf).offset(-iconMargin);
        make.width.equalTo(@(KKWIDTH(itemWidth)));
    }];
}

- (void)iconBtnDidClick:(UIButton *)btn {
    
    if (self.iconBtnDidClickAction) {
        self.iconBtnDidClickAction(btn);
    }
}

#pragma mark - Getter & Setter
- (UIButton *)iconBtn {
    
    weakSelf();
    KK_MakeAndReturnPropertyInstance(_iconBtn, UIButton, ^(UIButton *prop){
        
        [weakSelf addSubview:prop];
        prop.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [prop addTarget:weakSelf action:@selector(iconBtnDidClick:) forControlEvents:UIControlEventTouchUpInside];
    })
}
@end

@implementation KKFloatItem

+ (instancetype)floatItemWithIcon:(UIImage *)icon highlightIcon:(UIImage *)highlightIcon actionTag:(KKFloatItemActionTag)actionTag {
    
    KKFloatItem *it = [KKFloatItem new];
    it.icon = icon;
    it.highlightIcon = highlightIcon;
    it.actionTag = actionTag;
    
    return it;
}

@end

