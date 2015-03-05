//
//  RequestFavoritesParma.m
//  WBTest
//
//  Created by mjx on 15/1/27.
//  Copyright (c) 2015年 MJX. All rights reserved.
//

#import "RequestFavoritesParma.h"

@implementation RequestFavoritesParma

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
    if(mdict[@"Id"])
    {
    [mdict setObject:mdict[@"Id"] forKey:@"id"];
    }
    return mdict;

}
@end
