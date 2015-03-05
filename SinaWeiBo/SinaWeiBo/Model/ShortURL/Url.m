//
//  Url.m
//  WBTest
//
//  Created by mjx on 15/1/30.
//  Copyright (c) 2015年 MJX. All rights reserved.
//

#import "Url.h"

@implementation Url


-(instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        NSMutableDictionary *mDict = [self StandardizePropertyDictionary:dict];
       
        if (mDict[@"share_statuses"]) {
            NSArray *share_statusesArr = mDict[@"share_statuses"];
            NSMutableArray *share_statuses = [NSMutableArray new];
            for (NSDictionary *statusDict in share_statusesArr) {
                Statu *statu = [[Statu alloc]initWithDict:statusDict];
                [share_statuses addObject:statu];
            }
            [mDict setObject:share_statuses forKey:@"share_statuses"];
        }
        if (mDict[@"share_comments"]) {
            NSArray *share_commentsArr = mDict[@"share_comments"];
            NSMutableArray *share_comments = [NSMutableArray new];
            for (NSDictionary *commentDict in share_commentsArr) {
                Comment *comment = [[Comment alloc]initWithDictionary:commentDict];
                [share_comments addObject:comment];
            }
            [mDict setObject:share_comments forKey:@"share_comments"];
        }
        [self setValuesForKeysWithDictionary:mDict];
    }
    return self;
}
@end
