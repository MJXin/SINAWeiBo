//
//  AppSearchSuggestion.m
//  WBTest
//
//  Created by mjx on 15/1/29.
//  Copyright (c) 2015年 MJX. All rights reserved.
//

#import "AppSearchSuggestion.h"

@implementation AppSearchSuggestion

-(instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        NSMutableDictionary *mDict = [self StandardizePropertyDictionary:dict];
        [self setValuesForKeysWithDictionary:mDict];
    }
    return self;
}

@end
