//
//  UserFriendships.m
//  WBTest
//
//  Created by mjx on 15/1/26.
//  Copyright (c) 2015年 MJX. All rights reserved.
//

#import "UserFriendships.h"

@implementation UserFriendships

-(instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (dict[@"target"]) {
             NSDictionary *mdict = dict[@"target"];
            if (mdict[@"id"]) {
                self.tId = [NSString stringWithFormat:@"%@",mdict[@"id"]];
            }
            if (mdict[@"screen_name"]) {
                self.tScreen_name = mdict[@"screen_name"];
            }
            if (mdict[@"followed_by"]) {
                self.tFollowed_by = mdict[@"followed_by"];
            }
            if (mdict[@"following"]) {
                self.tFollowing = mdict[@"following"];
            }
            if (mdict[@"notifications_enabled"]) {
                self.tNotifications_enabled = mdict[@"notifications_enabled"];
            }
            
        }
        if (dict[@"source"]) {
            NSDictionary *mdict = dict[@"source"];
            if (mdict[@"id"]) {
                self.sId = [NSString stringWithFormat:@"%@",mdict[@"id"]];

            }
            if (mdict[@"screen_name"]) {
                self.sScreen_name = mdict[@"screen_name"];
            }
            if (mdict[@"followed_by"]) {
                self.sFollowed_by = mdict[@"followed_by"];
            }
            if (mdict[@"following"]) {
                self.sFollowing = mdict[@"following"];
            }
            if (mdict[@"notifications_enabled"]) {
                self.sNotifications_enabled = mdict[@"notifications_enabled"];
            }
            
        }
        
    }
    return self;
}
@end
