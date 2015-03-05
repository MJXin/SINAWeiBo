//
//  MayinterestedUesr.m
//  WBTest
//
//  Created by mjx on 15/1/29.
//  Copyright (c) 2015年 MJX. All rights reserved.
//

#import "MayinterestedUesr.h"

@implementation MayinterestedUesr
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        if(dict[@"uid"])
        {
            self.uid =dict[@"uid"];
        }
        if (dict[@"reason"])
        {
            MayinterestedReason *reason = [[MayinterestedReason alloc]initWithDict:dict[@"reason"]];
            self.reason = reason;
        }
    }
    return self;
}
@end
