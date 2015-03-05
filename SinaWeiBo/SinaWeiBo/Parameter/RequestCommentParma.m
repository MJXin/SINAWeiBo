//
//  RequestCommentParma.m
//  sinaWeiboDemo1
//
//  Created by William-zhang on 15/1/22.
//  Copyright (c) 2015年 William-zhang. All rights reserved.
//

#import "RequestCommentParma.h"
#import "NSObject+PropertyMethod.h"

@implementation RequestCommentParma


- (instancetype)initWithAccess_token:(NSString *)access_token
{
    if (self = [super init]) {
        self.access_token = access_token;
        self.count = @"20";
    }
    return self;
}

- (NSDictionary*)dictaryValue
{
    NSMutableDictionary *mdict = [[self properties_aps] mutableCopy];
    if(self.status_Id)
    {
        if ([mdict valueForKey:@"status_Id"]) {
            [mdict removeObjectForKey:@"status_Id"];
            [mdict setObject:self.status_Id forKey:@"id"];
        }
    }
    return mdict;
}

@end
