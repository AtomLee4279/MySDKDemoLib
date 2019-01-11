//
//  NetWorkRespondModel.m
//  MySDKDemoKit
//
//  Created by 李一贤 on 2018/7/7.
//  Copyright © 2018年 李一贤. All rights reserved.
//

#import "NetWorkRespondModel.h"

@implementation NetWorkRespondModel

-(instancetype)initWithObject:(id)object
{
    if (self = [super init]) {
        if([object isKindOfClass:[NSError class]]) {
            self.error = object;
            return self;
        }
        
        [self setValuesForKeysWithDictionary:object];
    }
    return self;
}

+(instancetype)netWorkModelWithObject:(id)object
{
    return [[self alloc] initWithObject: object];
}
@end
