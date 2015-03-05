//
//  FriendShipsRequest.h
//  WBTest
//
//  Created by mjx on 15/1/23.
//  Copyright (c) 2015年 MJX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RequestFriendshipsParma.h"
#import "WeiboSDK.h"
#import "FriendShipsList.h"
#import "UserFriendships.h"
#import "User.h"
@protocol FriendshipsRequestDelegate <NSObject>

@optional
#pragma mark --- FriendShips类代理 --
#pragma mark -- 关注请求代理 --
/**完成请求用户关注用户列表调用的代理方法*/
- (void)FriendsRequestDidFinishedWithFriendShipsList:(FriendShipsList*)friendShipsList Friends:(NSArray*)users error:(NSError*)error;
/**完成请求用户关注用户Id列表调用的代理方法*/
- (void)FriendsIdRequestDidFinishedWithFriendShipsList:(FriendShipsList*)friendShipsList FriendsId:(NSArray*)usersId error:(NSError*)error;
/**完成请求共同关注列表调用的代理方法*/
- (void)FriendsInCommonRequestDidFinishedWithFriendShipsList:(FriendShipsList *)friendShipsList Friends:(NSArray *)users error:(NSError *)error;
/**完成请求双向关注列表调用的代理方法*/
- (void)BilateralRequestDidFinishedWithFriendShipsList:(FriendShipsList *)friendShipsList Friends:(NSArray *)users error:(NSError *)error;
/**完成请求双向关注用户Id调用的代理方法*/
- (void)BilateralIdRequestDidFinishedWithFriendShipsList:(FriendShipsList *)friendShipsList FriendsId:(NSArray *)usersId error:(NSError *)error;
#pragma mark -- 粉丝请求代理 --
/**完成请求粉丝用户列表调用的代理方法*/
- (void)FollowersRequestDidFinishedWithFriendShipsList:(FriendShipsList *)friendShipsList Friends:(NSArray *)users error:(NSError *)error;
/**完成请求粉丝用户Id列表调用的代理方法*/
- (void)FollowersIdRequestDidFinishedWithFriendShipsList:(FriendShipsList *)friendShipsList FriendsId:(NSArray *)usersId error:(NSError *)error;
/**完成请求优势粉丝用户Id列表调用的代理方法*/
- (void)ActiveFollowersRequestDidFinishedWithFriendShipsList:(FriendShipsList *)friendShipsList Friends:(NSArray *)users error:(NSError *)error;
#pragma mark -- 关系链请求代理 --
/**完成请求当前登录用户的关注人中又关注了指定用户的用户列表*/
- (void)Friends_chain_followersRequestDidFinishedWithFriendShipsList:(FriendShipsList *)friendShipsList Friends:(NSArray *)users error:(NSError *)error;
#pragma mark -- 关系读取接口代理 --
/**完成获取两个用户之间的详细关注关系情况请求*/
- (void)ShowFriendShipsRequestDidFinishedWithfriendShip:(UserFriendships*)source_targetFriendship error:(NSError*)error;

#pragma mark --- 写入接口 ---
#pragma mark -- 关注接口 --
/**完成关注一个用户后的代理方法*/
- (void)CreatFriendshipsWriteDidFinishedWithUser:(User *)user error:(NSError *)error;
/**完成取消关注一个用户后的代理方法*/
- (void)DestroyfriendshipsWriteDidFinishedWithUser:(User *)user error:(NSError *)error;


@end


#pragma mark --- FriendShips类正文 ---
@interface FriendShipsRequest : NSObject
@property (nonatomic, strong) id<FriendshipsRequestDelegate> delegate;

#pragma mark -- 关注接口 --
/**获取用户的关注用户列表
 *采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 *参数uid与screen_name二者必选其一，且只能选其一；
 *uid 需要查询的用户UID。
 *screen_name 需要查询的用户昵称。
 *count 单页返回的记录条数，默认为50，最大不超过200。
 *cursor 返回结果的游标，下一页用返回值里的next_cursor，上一页用previous_cursor，默认为0。
 *trim_status 返回值中user字段中的status字段开关，0：返回完整status字段、1：status字段仅返回status_id，默认为1。
 *uid与screen_name只能为当前授权用户，第三方微博类客户端不受影响；最多可获得总关注量30%的用户，上限为500。
 */
- (void)FriendsRequestWithParma:(RequestFriendshipsParma*)parma;

/**获取用户关注用户的id列表
 *采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 *参数uid与screen_name二者必选其一，且只能选其一；
 *uid 需要查询的用户UID。
 *screen_name 需要查询的用户昵称。
 *count 单页返回的记录条数，默认为50，最大不超过200。
 *cursor 返回结果的游标，下一页用返回值里的next_cursor，上一页用previous_cursor，默认为0。
 *trim_status 返回值中user字段中的status字段开关，0：返回完整status字段、1：status字段仅返回status_id，默认为1。
 *uid与screen_name只能为当前授权用户，第三方微博类客户端不受影响；最多可获得总关注量30%的用户，上限为500。
 */
- (void)FriendsIdRequestWithParma:(RequestFriendshipsParma*)parma;



/**获取两个用户之间的共同关注人列表
 *access_token 采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 *uid 需要获取共同关注关系的用户UID。
 *suid 需要获取共同关注关系的用户UID，默认为当前登录用户。
 *count	单页返回的记录条数，默认为50。
 *page 回结果的页码，默认为1。
 *trim_status 返回值中user字段中的status字段开关，0：返回完整status字段、1：status字段仅返回status_id，默认为1。
 *接口升级后：uid只能为当前授权用户，第三方微博类客户端不受影响；
 */
- (void)FriendsInCommonRequestWithParma:(RequestFriendshipsParma*)parma;


/**获取用户的双向关注列表，即互粉列表
 *access_token 采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 *uid 需要获取双向关注列表的用户UID。
 *count 单页返回的记录条数，默认为50。
 *page 返回结果的页码，默认为1。
 *sort 排序类型，0：按关注时间最近排序，默认为0。
 *接口升级后：uid只能为当前授权用户，第三方微博类客户端不受影响；最多可获得双向关注总量30%的用户，上限为500。
 */
- (void)BilateralRequestWithParma:(RequestFriendshipsParma*)parma;


/**获取用户的双向关注列表用户Id，即互粉列表
 *注意是id
 *access_token 采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 *uid 需要获取双向关注列表的用户UID。
 *count 单页返回的记录条数，默认为50。
 *page 返回结果的页码，默认为1。
 *sort 排序类型，0：按关注时间最近排序，默认为0。
 *接口升级后：uid只能为当前授权用户，第三方微博类客户端不受影响；最多可获得双向关注总量30%的用户，上限为500。
 */
- (void)BilateralIdRequestWithParma:(RequestFriendshipsParma*)parma;

#pragma mark -- 粉丝接口 --
/**获取用户的粉丝用户列表
 *access_token 采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 *uid 需要查询的用户UID。
 *screen_name 需要查询的用户昵称。
 *count 单页返回的记录条数，默认为50，最大不超过200。
 *cursor 返回结果的游标，下一页用返回值里的next_cursor，上一页用previous_cursor，默认为0。
 *trim_status 返回值中user字段中的status字段开关，0：返回完整status字段、1：status字段仅返回status_id，默认为1。
 *最多返回总粉丝量30%，上限为500；
 */
- (void)FollowersRequestWithParma:(RequestFriendshipsParma*)parma;

/**获取用户的粉丝用户Id列表
 *access_token 采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 *uid 需要查询的用户UID。
 *screen_name 需要查询的用户昵称。
 *count 单页返回的记录条数，默认为50，最大不超过200。
 *cursor 返回结果的游标，下一页用返回值里的next_cursor，上一页用previous_cursor，默认为0。
 *trim_status 返回值中user字段中的status字段开关，0：返回完整status字段、1：status字段仅返回status_id，默认为1。
 *最多返回总粉丝量30%，上限为500；
 */
- (void)FollowersIdRequestWithParma:(RequestFriendshipsParma*)parma;

/**获取用户的优质粉丝用户列表
 *access_token 采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 *uid 需要查询的用户UID。
 *count	返回的记录条数，默认为20，最大不超过200。
 */
- (void)ActiveFollowersRequestWithParma:(RequestFriendshipsParma*)parma;


#pragma mark -- 关系链接口 --
/**获取当前登录用户的关注人中又关注了指定用户的用户列表
 *access_token 采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 *uid 指定的关注目标用户UID。
 *count 单页返回的记录条数，默认为50。
 *page 返回结果的页码，默认为1。 *
 */
- (void)Friends_chain_followersRequestWithParma:(RequestFriendshipsParma*)parma;

#pragma mark -- 关系读取接口 --
/**获取两个用户之间的详细关注关系情况
 *这个类的使用需要口头描述
 *access_token 采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 *source_id 源用户的UID。
 *source_screen_name 源用户的微博昵称。
 *target_id 目标用户的UID。
 *target_screen_name 目标用户的微博昵称。
 */
- (void)ShowFriendShipsRequestWithParma:(RequestFriendshipsParma*)parma;

#pragma mark --- 写入接口 ---
#pragma mark -- 关注接口 --
/**关注一个用户
 *access_token 采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 *uid 需要关注的用户ID。
 *screen_name 需要关注的用户昵称。
 *rip 开发者上报的操作用户真实IP，形如：211.156.0.1。
 */
- (void)CreatFriendshipsWriteWithParma:(RequestFriendshipsParma*)parma;

/**取消关注一个用户
 *access_token 采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 *uid 需要取消关注的用户ID。
 *screen_name 需要取消关注的用户昵称。
 *
 */
- (void)DestroyfriendshipsWriteWithParma:(RequestFriendshipsParma*)parma;


@end
