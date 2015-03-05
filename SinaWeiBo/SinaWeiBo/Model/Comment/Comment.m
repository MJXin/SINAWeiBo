//
//  Comment.m
//  sinaWeiboDemo1
//
//  Created by William-zhang on 15/1/21.
//  Copyright (c) 2015年 William-zhang. All rights reserved.
//

#import "Comment.h"
#import "User.h"
#import "Statu.h"

@interface Comment ()
{
    NSString* _replyCommentId;
}
@end

@implementation Comment

/**如果无法确定这条评论是属于哪条微博，请使用该方法
 */
-(Comment*)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init]) {
        self.Id = [dictionary[@"id"] integerValue];
        self.user = [[User alloc]initWithDict:dictionary[@"user"]];
        self.status = [[Statu alloc]initWithDict:dictionary[@"status"]];
        if (dictionary[@"reply_comment"]) {
            self.reply = [[Comment alloc]initWithDictionary:dictionary[@"reply_comment"]];
        }
        self.floorNum = [dictionary[@"floor_num"] integerValue];
        self.text = dictionary[@"text"];
        self.date = dictionary[@"created_at"];
        self.source = dictionary[@"source"];
        self.source_type = [dictionary[@"source_type"] integerValue];
        self.mid = dictionary[@"mid"];
        self.idStr = dictionary[@"idstr"];
    }
    return self;
}

/**如果可以确定这条微博属于哪条微博，请使用这个微博
 */
-(Comment*)initWithDictionary:(NSDictionary *)dictionary Statu:(Statu*)statu
{
    if (self = [super init]) {
        self.Id = [dictionary[@"id"] integerValue];
        self.user = [[User alloc]initWithDict:dictionary[@"user"]];
        self.status = statu;
        if (dictionary[@"reply_comment"]) {
            self.reply = [[Comment alloc]initWithDictionary:dictionary[@"reply_comment"]];
        }
        self.floorNum = [dictionary[@"floor_num"] integerValue];
        self.text = dictionary[@"text"];
        self.date = dictionary[@"created_at"];
        self.source = dictionary[@"source"];
        self.source_type = [dictionary[@"source_type"] integerValue];
        self.mid = dictionary[@"mid"];
        self.idStr = dictionary[@"idstr"];
    }
    return self;
}


@end
