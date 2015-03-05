//
//  TrendsList.m
//  WBTest
//
//  Created by mjx on 15/1/28.
//  Copyright (c) 2015年 MJX. All rights reserved.
//

#import "TrendsList.h"

@implementation TrendsList

-(instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (dict[@"as_of"]) {
            self.as_of = dict[@"as_of"];
        }
        if (dict[@"trends"]) {
            NSDictionary *trendsDict = dict[@"trends"];
            self.date = [trendsDict allKeys][0];
            NSArray *trendsArr = trendsDict[self.date];
            NSMutableArray *trends = [NSMutableArray new];
            for (NSDictionary *trendDict in trendsArr) {
                Trend *trend = [[Trend alloc]initWithDict:trendDict];
                [trends addObject:trend];
            }
            self.trends = trends;
            
        }
        
    }
    return self;
}
@end
