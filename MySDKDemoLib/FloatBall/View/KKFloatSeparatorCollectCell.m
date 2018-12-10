//
//  KKFloatSeparatorCollectCell.m
//  KoalaGameStaticLib
//
//  Created by kaola  on 2018/8/21.
//  Copyright © 2018年    . All rights reserved.
//

#import "KKFloatSeparatorCollectCell.h"

#define weak(obj, weakName) __weak typeof(obj) weakName = obj
#define weakSelf() weak(self, weakSelf)

@implementation KKFloatSeparatorCollectCell {
    UIImageView *_separatorImageView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self prepareUI];
    }
    return self;
}

- (void)prepareUI {
    
    CGFloat topMargin = KKHEIGHT(8.f);
    
    weakSelf();
    [self.separatorImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.leading.trailing.equalTo(weakSelf.contentView);
        make.top.equalTo(weakSelf.contentView).offset(topMargin);
        make.bottom.equalTo(weakSelf.contentView).offset(-topMargin);
    }];
}

#pragma mark - Getter & Setter
- (UIImageView *)separatorImageView {
    
    if (_separatorImageView) {
        return _separatorImageView;
    }
    
    
    _separatorImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.bundle/%@", @"SDKBundle", @"分割线"]]];
    [self.contentView addSubview:_separatorImageView];
    
    return _separatorImageView;
}



@end
