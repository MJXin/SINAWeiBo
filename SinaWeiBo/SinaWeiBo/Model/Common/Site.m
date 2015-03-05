//
//  Site.m
//  WBTest
//
//  Created by mjx on 15/1/30.
//  Copyright (c) 2015年 MJX. All rights reserved.
//

#import "Site.h"

@implementation Site

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        
        if ([dict allKeys].count >0) {
            self.Id = [dict allKeys][0];
            self.name = dict[self.Id];
        }
    }
    return self;
}
@end
