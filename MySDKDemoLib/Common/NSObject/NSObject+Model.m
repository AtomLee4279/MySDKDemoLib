//
//  NSObject+Model.m
//  KoalaGameKit
//
//  Created by kaola  on 2018/3/6.
//  Copyright © 2018年 kaola . All rights reserved.
//

#import "NSObject+Model.h"

@implementation NSObject (Model)

+ (instancetype)kk_modelWithKeyValues:(id)keyValues {
    
    id obj = [self new];
    [obj setValuesForKeysWithDictionary:keyValues];
    
    return obj;
}

+ (NSMutableArray *)kk_modelArrayWithKeyValuesArray:(id)keyValuesArray {
    
    NSMutableArray *modelsM = [NSMutableArray array];
    for (id dict in keyValuesArray) {
        
        id obj = [self kk_modelWithKeyValues:dict];
        [modelsM addObject:obj];
    }
    
    return modelsM;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {}

@end
