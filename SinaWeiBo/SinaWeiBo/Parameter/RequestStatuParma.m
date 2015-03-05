//
//  StatuParma.m
//  WBTest
//
//  Created by mjx on 15/1/20.
//  Copyright (c) 2015年 MJX. All rights reserved.
//  这个类用做请求微博时候的参数

#import "RequestStatuParma.h"
#import "NSObject+PropertyMethod.h"
@implementation RequestStatuParma

- (instancetype)initWithAccess_token:(NSString *)access_token
{
    if (self = [super init]) {
        self.access_token = access_token;
    }
    return self;
}
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        
        NSMutableDictionary *mDict = [self StandardizePropertyDictionary:dict];
        [self setValuesForKeysWithDictionary:mDict];
    }
    return self;
}


- (NSDictionary*)dictaryValue
{
    NSMutableDictionary *mdict = [[self properties_aps] mutableCopy];
    if(self.Id)
    {
        if ([mdict valueForKey:@"Id"]) {
            
            [mdict removeObjectForKey:@"Id"];
            [mdict setObject:self.Id forKey:@"id"];
        }
        
    }
    if(self.Long)
    {
        if ([mdict valueForKey:@"Long"]) {
            [mdict removeObjectForKey:@"Long"];
            [mdict setObject:self.Long forKey:@"long"];
            
        }
    }
    
    
    return mdict;
}


@end
