//
//  FriendShipsList.m
//  WBTest
//
//  Created by mjx on 15/1/23.
//  Copyright (c) 2015年 MJX. All rights reserved.
//

#import "FriendShipsList.h"
#import "NSObject+PropertyMethod.h"
#import "User.h"
@implementation FriendShipsList

- (FriendShipsList *)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        
        NSMutableDictionary *mdict = [self StandardizePropertyDictionary:dict];
        NSArray *usersArr = mdict[@"users"];
        NSMutableArray *users = [NSMutableArray new];
        for (NSDictionary *userdic  in usersArr) {
            if (userdic.count != 0)
            {
                 User *user = [[User alloc]initWithDict:userdic];
                [users addObject:user];

            }
        }
        [mdict setObject:users forKey:@"users"];
        [self setValuesForKeysWithDictionary:mdict];
    }
    return self;
}

- (FriendShipsList *)initUsersIdWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        
        
        NSMutableDictionary *mdict = [dict mutableCopy];
        if (dict[@"ids"]) {
            [mdict setObject:dict[@"ids"] forKey:@"usersId"];
            [mdict removeObjectForKey:@"ids"];

        }
        [self StandardizePropertyDictionary:mdict];
        [self setValuesForKeysWithDictionary:mdict];
    }
    return self;
}


@end
