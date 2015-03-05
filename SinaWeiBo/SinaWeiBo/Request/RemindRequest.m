//
//  RemindRequest.m
//  WBTest
//
//  Created by mjx on 15/1/30.
//  Copyright (c) 2015年 MJX. All rights reserved.
//

#import "RemindRequest.h"

@implementation RemindRequest


/**获取某个用户的各种消息未读数
 *access_token 采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 *uid 需要获取消息未读数的用户UID，必须是当前登录用户。
 *callback JSONP回调函数，用于前端调用返回JS格式的信息。
 *unread_message	未读数版本。0：原版未读数，1：新版未读数。默认为0。
 */
- (void)UnreadCountRequestWithparma:(RequestRemindParma*)parma
{
    NSString *url = @"https://rm.api.weibo.com/2/remind/unread_count.json";
    NSDictionary *parmas = [parma dictaryValue];
    [WBHttpRequest requestWithURL:url httpMethod:@"GET" params:parmas queue:nil withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error)
     {
         NSDictionary *dict = result;
         UnRead *unread = [[UnRead alloc]initWithDict:dict];
         [self.delegate UnreadCountRequestDidFinishedWithUnRead:unread error:error];
     }];
}

/**对当前登录用户某一种消息未读数进行清零
 *这个是高级接口,暂时用不了
 *(必)access_token 采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 *(必)type 需要设置未读数计数的消息项，follower：新粉丝数、cmt：新评论数、dm：新私信数、mention_status：新提及我的微博数、mention_cmt：新提及我的评论数、group：微群消息数、notice：新通知数、invite：新邀请数、badge：新勋章数、photo：相册消息数、close_friends_feeds：密友feeds未读数、close_friends_mention_status：密友提及我的微博未读数、close_friends_mention_cmt：密友提及我的评论未读数、close_friends_cmt：密友评论未读数、close_friends_attitude：密友表态未读数、close_friends_common_cmt：密友共同评论未读数、close_friends_invite：密友邀请未读数，一次只能操作一项。
 */
- (void)SetCountWriteWithparma:(RequestRemindParma*)parma
{
    NSString *url = @"https://rm.api.weibo.com/2/remind/set_count.json";
    NSDictionary *parmas = [parma dictaryValue];
    [WBHttpRequest requestWithURL:url httpMethod:@"POST" params:parmas queue:nil withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error)
     {
         NSDictionary *dict = result;
         if(dict[@"result"]&&[dict[@"result"] isEqual:@NO])
         {
             error = [NSError errorWithDomain:@"失败" code:-1 userInfo:nil];
         }
         [self.delegate SetCountWriteDidFinishedWitherror:error];
     }];
}
@end
