//
//  Emotions.m
//  WBTest
//
//  Created by mjx on 15/1/21.
//  Copyright (c) 2015年 MJX. All rights reserved.
//

#import "Emotions.h"
#import "NSObject+PropertyMethod.h"
@implementation Emotions

-(instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        NSMutableDictionary *mDict = [self StandardizePropertyDictionary:dict];
        [self setValuesForKeysWithDictionary:mDict];
    }
    return self;
}

@end
