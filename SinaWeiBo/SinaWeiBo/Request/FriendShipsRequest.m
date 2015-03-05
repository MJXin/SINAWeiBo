//
//  FriendShipsRequest.m
//  WBTest
//
//  Created by mjx on 15/1/23.
//  Copyright (c) 2015年 MJX. All rights reserved.
//

#import "FriendShipsRequest.h"

@implementation FriendShipsRequest

#pragma mark -- 关注接口 --
/**获取用户的关注列表
 *采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 *参数uid与screen_name二者必选其一，且只能选其一；
 *uid 需要查询的用户UID。
 *screen_name 需要查询的用户昵称。
 *count 单页返回的记录条数，默认为50，最大不超过200。
 *cursor 返回结果的游标，下一页用返回值里的next_cursor，上一页用previous_cursor，默认为0。
 *trim_status 返回值中user字段中的status字段开关，0：返回完整status字段、1：status字段仅返回status_id，默认为1。
 */
- (void)FriendsRequestWithParma:(RequestFriendshipsParma *)parma
{
    NSMutableDictionary *parmas = [[parma dictaryValue] mutableCopy];
    NSString *url = @"https://api.weibo.com/2/friendships/friends.json";
    [WBHttpRequest requestWithURL:url httpMethod:@"GET" params:parmas queue:nil withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error)
     {
         NSDictionary *dict = result;
         FriendShipsList *friendShipsList = [[FriendShipsList alloc]initWithDict:dict];
         NSArray *users = friendShipsList.users;
         
         [self.delegate FriendsRequestDidFinishedWithFriendShipsList:friendShipsList Friends:users error:error];
     }
     ];
}

/**获取用户的关注用户的id列表
 *采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 *参数uid与screen_name二者必选其一，且只能选其一；
 *uid 需要查询的用户UID。
 *screen_name 需要查询的用户昵称。
 *count 单页返回的记录条数，默认为50，最大不超过200。
 *cursor 返回结果的游标，下一页用返回值里的next_cursor，上一页用previous_cursor，默认为0。
 *trim_status 返回值中user字段中的status字段开关，0：返回完整status字段、1：status字段仅返回status_id，默认为1。
 */
- (void)FriendsIdRequestWithParma:(RequestFriendshipsParma *)parma
{
    NSMutableDictionary *parmas = [[parma dictaryValue] mutableCopy];
    NSString *url = @"https://api.weibo.com/2/friendships/friends/ids.json";
    [WBHttpRequest requestWithURL:url httpMethod:@"GET" params:parmas queue:nil withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error)
     {
         NSDictionary *dict = result;
         FriendShipsList *friendShipsList = [[FriendShipsList alloc]initUsersIdWithDict:dict];
         NSArray *usersId = friendShipsList.usersId;
         
         [self.delegate FriendsIdRequestDidFinishedWithFriendShipsList:friendShipsList FriendsId:usersId error:error];
     }
     ];
}



/**获取两个用户之间的共同关注人列表
 *access_token 采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 *uid 需要获取共同关注关系的用户UID。
 *suid 需要获取共同关注关系的用户UID，默认为当前登录用户。
 *count	单页返回的记录条数，默认为50。
 *page 回结果的页码，默认为1。
 *trim_status 返回值中user字段中的status字段开关，0：返回完整status字段、1：status字段仅返回status_id，默认为1。
 *接口升级后：uid只能为当前授权用户，第三方微博类客户端不受影响；
 */
- (void)FriendsInCommonRequestWithParma:(RequestFriendshipsParma*)parma
{
    NSString *url = @"https://api.weibo.com/2/friendships/friends/in_common.json";
    NSDictionary *parmas = [parma dictaryValue];
    
    [WBHttpRequest requestWithURL:url httpMethod:@"GET" params:parmas queue:nil withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error)
     {
         NSDictionary *dict = result;
         FriendShipsList *friendShipsList = [[FriendShipsList alloc]initWithDict:dict];
         NSArray *users = friendShipsList.users;
         
         [self.delegate FriendsInCommonRequestDidFinishedWithFriendShipsList:friendShipsList Friends:users error:nil];
     }
     ];
}

/**获取用户的双向关注列表用户Id，即互粉列表
 *注意是id
 *access_token 采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 *uid 需要获取双向关注列表的用户UID。
 *count 单页返回的记录条数，默认为50。
 *page 返回结果的页码，默认为1。
 *sort 排序类型，0：按关注时间最近排序，默认为0。
 *接口升级后：uid只能为当前授权用户，第三方微博类客户端不受影响；最多可获得双向关注总量30%的用户，上限为500。
 */
- (void)BilateralRequestWithParma:(RequestFriendshipsParma *)parma
{
    NSString *url = @"https://api.weibo.com/2/friendships/friends/bilateral.json";
    NSDictionary *parmas = [parma dictaryValue];
    [WBHttpRequest requestWithURL:url httpMethod:@"GET" params:parmas queue:nil withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error)
     {
         NSDictionary *dict = result;
         FriendShipsList *friendShipsList = [[FriendShipsList alloc]initWithDict:dict];
         NSArray *users = friendShipsList.users;
         
         [self.delegate BilateralRequestDidFinishedWithFriendShipsList:friendShipsList Friends:users error:nil];
     }
     ];
}

/**获取用户的双向关注列表用户Id，即互粉列表
 *注意是id
 *access_token 采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 *uid 需要获取双向关注列表的用户UID。
 *count 单页返回的记录条数，默认为50。
 *page 返回结果的页码，默认为1。
 *sort 排序类型，0：按关注时间最近排序，默认为0。
 *接口升级后：uid只能为当前授权用户，第三方微博类客户端不受影响；最多可获得双向关注总量30%的用户，上限为500。
 */

- (void)BilateralIdRequestWithParma:(RequestFriendshipsParma*)parma
{
    NSString *url = @"https://api.weibo.com/2/friendships/friends/bilateral/ids.json";
    NSDictionary *parmas = [parma dictaryValue];
    [WBHttpRequest requestWithURL:url httpMethod:@"GET" params:parmas queue:nil withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error)
     {
         NSDictionary *dict = result;
         FriendShipsList *friendShipsList = [[FriendShipsList alloc]initUsersIdWithDict:dict];
         NSArray *usersId = friendShipsList.usersId;
         
         [self.delegate BilateralIdRequestDidFinishedWithFriendShipsList:friendShipsList FriendsId:usersId error:error];
     }
     ];
}
#pragma mark -- 粉丝接口 --

/**获取用户的粉丝用户列表
 *access_token 采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 *uid 需要查询的用户UID。
 *screen_name 需要查询的用户昵称。
 *count 单页返回的记录条数，默认为50，最大不超过200。
 *cursor 返回结果的游标，下一页用返回值里的next_cursor，上一页用previous_cursor，默认为0。
 *trim_status 返回值中user字段中的status字段开关，0：返回完整status字段、1：status字段仅返回status_id，默认为1。
 */
- (void)FollowersRequestWithParma:(RequestFriendshipsParma*)parma
{
    NSString *url = @"https://api.weibo.com/2/friendships/followers.json";
    NSDictionary *parmas = [parma dictaryValue];
    [WBHttpRequest requestWithURL:url httpMethod:@"GET" params:parmas queue:nil withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error)
     {
         NSDictionary *dict = result;
         FriendShipsList *friendShipsList = [[FriendShipsList alloc]initWithDict:dict];
         NSArray *users = friendShipsList.users;
         
         [self.delegate FollowersRequestDidFinishedWithFriendShipsList:friendShipsList Friends:users error:error];
     }
     ];

}

/**获取用户的粉丝用户Id列表
 *access_token 采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 *uid 需要查询的用户UID。
 *screen_name 需要查询的用户昵称。
 *count 单页返回的记录条数，默认为50，最大不超过200。
 *cursor 返回结果的游标，下一页用返回值里的next_cursor，上一页用previous_cursor，默认为0。
 *trim_status 返回值中user字段中的status字段开关，0：返回完整status字段、1：status字段仅返回status_id，默认为1。
 *最多返回总粉丝量30%，上限为500；
 */
- (void)FollowersIdRequestWithParma:(RequestFriendshipsParma*)parma
{
    NSString *url = @"https://api.weibo.com/2/friendships/followers/ids.json";
    NSDictionary *parmas = [parma dictaryValue];
    [WBHttpRequest requestWithURL:url httpMethod:@"GET" params:parmas queue:nil withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error)
     {
         NSDictionary *dict = result;
         FriendShipsList *friendShipsList = [[FriendShipsList alloc]initUsersIdWithDict:dict];
         NSArray *usersId = friendShipsList.usersId;
         
         [self.delegate FollowersIdRequestDidFinishedWithFriendShipsList:friendShipsList FriendsId:usersId error:error];
     }
     ];
}

/**获取用户的优质粉丝用户列表
 *access_token 采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 *uid 需要查询的用户UID。
 *count	返回的记录条数，默认为20，最大不超过200。
 */
- (void)ActiveFollowersRequestWithParma:(RequestFriendshipsParma *)parma
{
    NSString *url = @"https://api.weibo.com/2/friendships/followers/active.json";
    NSDictionary *parmas = [parma dictaryValue];
    [WBHttpRequest requestWithURL:url httpMethod:@"GET" params:parmas queue:nil withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error)
     {
         NSDictionary *dict = result;
         FriendShipsList *friendShipsList = [[FriendShipsList alloc]initWithDict:dict];
         NSArray *users = friendShipsList.users;
         
         [self.delegate ActiveFollowersRequestDidFinishedWithFriendShipsList:friendShipsList Friends:users error:error];
     }
     ];

}

#pragma mark -- 关系链接口 --
/**获取当前登录用户的关注人中又关注了指定用户的用户列表
 *access_token 采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 *uid 指定的关注目标用户UID。
 *count 单页返回的记录条数，默认为50。
 *page 返回结果的页码，默认为1。 *
 */
- (void)Friends_chain_followersRequestWithParma:(RequestFriendshipsParma*)parma
{
    NSString *url = @"https://api.weibo.com/2/friendships/friends_chain/followers.json";
    NSDictionary *parmas = [parma dictaryValue];
    [WBHttpRequest requestWithURL:url httpMethod:@"GET" params:parmas queue:nil withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error)
     {
         NSDictionary *dict = result;
         FriendShipsList *friendShipsList = [[FriendShipsList alloc]initWithDict:dict];
         NSArray *users = friendShipsList.users;
         
         [self.delegate Friends_chain_followersRequestDidFinishedWithFriendShipsList:friendShipsList Friends:users error:error];
     }
     ];
}

#pragma mark -- 关系读取接口 --
/**获取两个用户之间的详细关注关系情况
 *这个类的使用需要口头描述
 *access_token 采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 *source_id 源用户的UID。
 *source_screen_name 源用户的微博昵称。
 *target_id 目标用户的UID。
 *target_screen_name 目标用户的微博昵称。
 */
- (void)ShowFriendShipsRequestWithParma:(RequestFriendshipsParma*)parma
{
    NSString *url = @"https://api.weibo.com/2/friendships/show.json";
    NSDictionary *parmas = [parma dictaryValue];
    [WBHttpRequest requestWithURL:url httpMethod:@"GET" params:parmas queue:nil withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error)
     {
         NSDictionary *dict = result;
         UserFriendships *friends = [[UserFriendships alloc]initWithDict:dict];
         [self.delegate ShowFriendShipsRequestDidFinishedWithfriendShip:friends error:error];
     }];
}


#pragma mark --- 写入接口 ---
#pragma mark -- 关注接口 --
/**关注一个用户
 *access_token 采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 *uid 需要关注的用户ID。
 *screen_name 需要关注的用户昵称。
 *rip 开发者上报的操作用户真实IP，形如：211.156.0.1。
 */
- (void)CreatFriendshipsWriteWithParma:(RequestFriendshipsParma*)parma
{
    NSString *url = @"https://api.weibo.com/2/friendships/create.json";
    NSDictionary *parmas = [parma dictaryValue];
    [WBHttpRequest requestWithURL:url httpMethod:@"POST" params:parmas queue:nil withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error)
     {
         NSDictionary *dict = result;
         User *user = [[User alloc]initWithDict:dict];
         
         [self.delegate CreatFriendshipsWriteDidFinishedWithUser:user error:error];
     }
     ];

}

/**取消关注一个用户
 *access_token 采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 *uid 需要取消关注的用户ID。
 *screen_name 需要取消关注的用户昵称。
 *
 */
- (void)DestroyfriendshipsWriteWithParma:(RequestFriendshipsParma*)parma
{
    NSString *url = @"https://api.weibo.com/2/friendships/destroy.json";
    NSDictionary *parmas = [parma dictaryValue];
    [WBHttpRequest requestWithURL:url httpMethod:@"POST" params:parmas queue:nil withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error)
     {
         NSDictionary *dict = result;
         User *user = [[User alloc]initWithDict:dict];
         
         [self.delegate DestroyfriendshipsWriteDidFinishedWithUser:user error:error];
     }
     ];

}



@end
