//
//  CommentList.m
//  sinaWeiboDemo1
//
//  Created by William-zhang on 15/1/22.
//  Copyright (c) 2015年 William-zhang. All rights reserved.
//

#import "CommentList.h"


@implementation CommentList

/**通过json初始化
 */
-(CommentList *)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init]) {
        if (dictionary[@"comments"]) {
            NSArray* arr = dictionary[@"comments"];
            NSMutableArray* coms = [[NSMutableArray alloc]init];
            for (NSDictionary* dic in arr) {
                Comment* comment = [[Comment alloc]initWithDictionary:dic];
                [coms addObject:comment];
            }
            self.total_number = [dictionary[@"total_number"] integerValue];
            self.comments = coms;
        }
    }
    return self;
}

/**在确定评论是某条的微博的时候，使用这个初始化方法
 */
-(CommentList *)initWithDictionary:(NSDictionary *)dictionary Statu:(Statu *)statu
{
    if (self = [super init]) {
        if (dictionary[@"comments"]) {
            NSArray* arr = dictionary[@"comments"];
            NSMutableArray* coms = [[NSMutableArray alloc]init];
            for (NSDictionary* dic in arr) {
                Comment* comment = [[Comment alloc]initWithDictionary:dic Statu:statu];
                [coms addObject:comment];
            }
            self.total_number = [dictionary[@"total_number"] integerValue];
            self.comments = coms;
        }
    }
    return self;
}



@end
