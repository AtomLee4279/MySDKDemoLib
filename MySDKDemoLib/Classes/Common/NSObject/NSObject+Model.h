//
//  NSObject+Model.h
//  KoalaGameKit
//
//  Created by kaola  on 2018/3/6.
//  Copyright © 2018年 kaola . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Model)

+ (instancetype)kk_modelWithKeyValues:(id)keyValues;
+ (NSMutableArray *)kk_modelArrayWithKeyValuesArray:(id)keyValuesArray;

@end
