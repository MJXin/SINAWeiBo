//
//  Geo.m
//  WBTest
//
//  Created by mjx on 15/1/19.
//  Copyright (c) 2015年 MJX. All rights reserved.
//
//地理信息类
#import "Geo.h"

@implementation Geo

-(Geo *)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        NSMutableDictionary *mDict = [self StandardizePropertyDictionary:dict];
        if(mDict[@"coordinates"])
        {
            NSArray *coordinates = mDict[@"coordinates"];
            [mDict setObject:[coordinates[0] stringValue] forKey:@"latitude"];
            [mDict setObject:[coordinates[1] stringValue] forKey:@"longitude"];
               
        }
        if (mDict[@"address"] &&[mDict[@"address"] length]!=0 ) {
            NSString *address = mDict[@"address"];
            
            NSRange rang = [address rangeOfString:@"市"];
            if (rang.length > 0) {
                address = [address substringFromIndex:rang.location+1];
            }
            [mDict setObject:address forKey:@"address"];
        }
        [self setValuesForKeysWithDictionary:mDict];
    }
    return self;
}
@end
