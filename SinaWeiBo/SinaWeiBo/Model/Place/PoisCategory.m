//
//  PoisCategory.m
//  WBTest
//
//  Created by mjx on 15/2/3.
//  Copyright (c) 2015年 MJX. All rights reserved.
//

#import "PoisCategory.h"

@implementation PoisCategory

-(instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        NSMutableDictionary *mDict = [self StandardizePropertyDictionary:dict];
        [self setValuesForKeysWithDictionary:mDict];
    }
    return self;
}

@end
