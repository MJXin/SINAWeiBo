//
//  RequestPlaceParma.m
//  WBTest
//
//  Created by mjx on 15/2/2.
//  Copyright (c) 2015年 MJX. All rights reserved.
//

#import "RequestPlaceParma.h"

@implementation RequestPlaceParma

- (instancetype)initWithAccess_token:(NSString *)access_token
{
    if (self = [super init]) {
        self.access_token = access_token;
    }
    return self;
}

- (NSDictionary *)dictaryValue
{
    NSMutableDictionary *mdict = [[self properties_aps] mutableCopy];
    if(mdict[@"Public"])
    {
        [mdict setObject:mdict[@"Public"] forKey:@"public"];
        [mdict removeObjectForKey:@"Public"];
    }
    if (mdict[@"Long"]) {
        [mdict setObject:mdict[@"Long"] forKey:@"long"];
        [mdict removeObjectForKey:@"Long"];

    }
    return mdict;
    
}

@end
