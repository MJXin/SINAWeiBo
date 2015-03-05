//
//  UserFriendships.h
//  WBTest
//
//  Created by mjx on 15/1/26.
//  Copyright (c) 2015年 MJX. All rights reserved.
//  这个类专用于反映用户与某用户的关系

#import <Foundation/Foundation.h>

@interface UserFriendships : NSObject
/**目标用户的id*/
@property (nonatomic, strong) NSString *tId;
/**目标用户的昵称*/
@property (nonatomic, strong) NSString *tScreen_name;
/**下面属性作用不明*/
@property (nonatomic) BOOL tFollowed_by;
@property (nonatomic) BOOL tFollowing;
@property (nonatomic) BOOL tNotifications_enabled;

/**请求用户的id*/
@property (nonatomic, strong) NSString *sId;
/**请求用户的昵称*/
@property (nonatomic, strong) NSString *sScreen_name;
/**下面属性作用不明*/
@property (nonatomic) BOOL sFollowed_by;
@property (nonatomic) BOOL sFollowing;
@property (nonatomic) BOOL sNotifications_enabled;


-(instancetype)initWithDict:(NSDictionary*)dict;


@end
