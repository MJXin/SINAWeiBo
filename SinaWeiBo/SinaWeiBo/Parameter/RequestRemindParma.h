//
//  RequestRemindParma.h
//  WBTest
//
//  Created by mjx on 15/1/30.
//  Copyright (c) 2015年 MJX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+PropertyMethod.h"
@interface RequestRemindParma : NSObject

/**采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。*/
@property (nonatomic, strong) NSString *access_token;
/**需要获取消息未读数的用户UID，必须是当前登录用户。*/
@property (nonatomic, strong) NSString *uid;
/**JSONP回调函数，用于前端调用返回JS格式的信息。*/
@property (nonatomic, strong) NSString *callback;
/**未读数版本。0：原版未读数，1：新版未读数。默认为0。*/
@property (nonatomic, strong) NSString *unread_message;
/**需要设置未读数计数的消息项，follower：新粉丝数、cmt：新评论数、dm：新私信数、mention_status：新提及我的微博数、mention_cmt：新提及我的评论数、group：微群消息数、notice：新通知数、invite：新邀请数、badge：新勋章数、photo：相册消息数、close_friends_feeds：密友feeds未读数、close_friends_mention_status：密友提及我的微博未读数、close_friends_mention_cmt：密友提及我的评论未读数、close_friends_cmt：密友评论未读数、close_friends_attitude：密友表态未读数、close_friends_common_cmt：密友共同评论未读数、close_friends_invite：密友邀请未读数，一次只能操作一项。*/
@property (nonatomic, strong) NSString *type;

/** 使用access_token初始化
 */
- (instancetype)initWithAccess_token:(NSString*)access_token;

/** 转换为字典
 */
- (NSDictionary*)dictaryValue;

@end
