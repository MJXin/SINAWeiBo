//
//  RequestFriendshipsParma.m
//  WBTest
//
//  Created by mjx on 15/1/23.
//  Copyright (c) 2015年 MJX. All rights reserved.
//

#import "RequestFriendshipsParma.h"
#import "NSObject+PropertyMethod.h"
@implementation RequestFriendshipsParma


- (instancetype)initWithAccess_token:(NSString *)access_token
{
    if (self =[super init]) {
        self.access_token = access_token;
    }
    
    return self;
}

- (NSDictionary *)dictaryValue
{
    NSMutableDictionary *mdict = [[self properties_aps] mutableCopy];
    return mdict;
    
}

@end
