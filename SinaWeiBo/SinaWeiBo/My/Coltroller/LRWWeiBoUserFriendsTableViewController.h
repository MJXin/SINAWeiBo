//
//  LRWUserFriendsTableViewController.h
//  微博SDK测试
//
//  Created by lrw on 15/2/4.
//  Copyright (c) 2015年 LRW. All rights reserved.
//

#import "LRWRefreshTableViewController.h"
typedef enum
{
    LRWWeiBoFriendShipStyleFriends = 0,//好友列表
    LRWWeiBoFriendShipStyleFans,//粉丝列表
    LRWWeiBoFriendShipStyleAttention,//关注列表
    LRWWeiBoFriendShipStyleSpecial,//特别的人列表
    LRWWeiBoFriendShipStyleEnt,//影视明星列表
    LRWWeiBoFriendShipStyleFashion,//体育列表
    LRWWeiBoFriendShipStyleCartoon,//动漫
    LRWWeiBoFriendShipStyleBusiness,//商界
    LRWWeiBoFriendShipStylePlace//周边的人
}LRWWeiBoFriendShipStyle;
@interface LRWWeiBoUserFriendsTableViewController : LRWRefreshTableViewController
/**
 friendShipStyle:显示内容，默认是 LRWWeiBoFriendShipStyleFriends显示好友列表
 */
- (instancetype)initWithFriendShipStyle:(LRWWeiBoFriendShipStyle)friendShipStyle;
@end
