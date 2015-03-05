//
//  MayinterestedReason.m
//  WBTest
//
//  Created by mjx on 15/1/29.
//  Copyright (c) 2015年 MJX. All rights reserved.
//

#import "MayinterestedReason.h"

@implementation MayinterestedReason
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (dict[@"f"])
        {
            NSDictionary *f = dict[@"f"];
            if (f[@"uid"]) {
                self.f = f[@"uid"];
            }
            if (f[@"n"]) {
                self.fCount = [f[@"n"] integerValue];
            }
        }
        if (dict[@"h"]) {
            NSDictionary *h = dict[@"h"];
            if (h[@"uid"]) {
                self.h = h[@"uid"];
            }
            if (h[@"n"]) {
                self.hCount = [h[@"n"] integerValue];
            }
        }
    }
    return self;
}
@end
