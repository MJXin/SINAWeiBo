//
//  CommentRequest.m
//  sinaWeiboDemo1
//
//  Created by William-zhang on 15/1/21.
//  Copyright (c) 2015年 William-zhang. All rights reserved.
//

#import "CommentRequest.h"
#import "AppDelegate.h"
#import "WBHttpRequest.h"

@interface CommentRequest ()

@end

@implementation CommentRequest

/**获取某条微博的评论列表
 */
-(void)commentOfStatuWithParmas:(RequestCommentParma *)parmas Status:(Statu*)statu
{
    NSInteger state = 0;
    if (parmas.since_id) {
        state = 1;
    }
    if (parmas.max_id) {
        state = 2;
    }
    NSDictionary *parma = [parmas dictaryValue];
    [WBHttpRequest requestWithURL:@"https://api.weibo.com/2/comments/show.json" httpMethod:@"GET" params:parma queue:nil withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error)
     {
         CommentList* commentList = [[CommentList alloc]initWithDictionary:result Statu:statu];
//         CommentList* commentList = [[CommentList alloc]initWithDictionary:result];
         if ([self.delegate respondsToSelector:@selector(commentOfStatuRequestDidFinshed:State:Error:)]) {
             //NSLog(@"请求某条微博的代理方法执行了");
//             NSLog(@"%@",result);
             [self.delegate commentOfStatuRequestDidFinshed:commentList State:state Error:error];
             //NSLog(@"Error:%@",error);
         }
     }];
}

/**
 *我发出的评论列表
 */
-(void)commentOfMineWithParmas:(RequestCommentParma *)parmas
{
    NSDictionary *parma = [parmas dictaryValue];
    [WBHttpRequest requestWithURL:@"https://api.weibo.com/2/comments/by_me.json" httpMethod:@"GET" params:parma queue:nil withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error)
     {
         CommentList* commentList = [[CommentList alloc]initWithDictionary:result];
         if ([self.delegate respondsToSelector:@selector(commentOfMineRequestDidFinshed:Error:)]) {
//             NSLog(@"%@",result);
             [self.delegate commentOfMineRequestDidFinshed:commentList Error:error];
//             NSLog(@"Error:%@",error);
         }
     }];
}

/**
 *我收到的评论列表
 */
-(void)commentToMeWithParmas:(RequestCommentParma *)parmas
{
    NSDictionary *parma = [parmas dictaryValue];
    [WBHttpRequest requestWithURL:@"https://api.weibo.com/2/comments/to_me.json" httpMethod:@"GET" params:parma queue:nil withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error)
     {
         CommentList* commentList = [[CommentList alloc]initWithDictionary:result];
         if ([self.delegate respondsToSelector:@selector(commentToMeRequestDidFinshed:Error:)]) {
//             NSLog(@"%@",result);
             [self.delegate commentToMeRequestDidFinshed:commentList Error:error];
//             NSLog(@"Error:%@",error);
         }
     }];
}

/**
 *获取@到我的评论
 */
-(void)commentMentionMeWithParmas:(RequestCommentParma *)parmas
{
    NSDictionary *parma = [parmas dictaryValue];
    [WBHttpRequest requestWithURL:@"https://api.weibo.com/2/comments/mentions.json" httpMethod:@"GET" params:parma queue:nil withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error)
     {
         CommentList* commentList = [[CommentList alloc]initWithDictionary:result];
         if ([self.delegate respondsToSelector:@selector(commentMentionMeRequestDidFinished:Error:)]) {
//             NSLog(@"%@",result);
             [self.delegate commentMentionMeRequestDidFinished:commentList Error:error];
//             NSLog(@"Error:%@",error);
         }
     }];
}

/**
 *获取用户发送及收到的评论列表
 */
-(void)commentTimeLineWithParmas:(RequestCommentParma *)parmas
{
    NSDictionary *parma = [parmas dictaryValue];
    [WBHttpRequest requestWithURL:@"https://api.weibo.com/2/comments/timeline.json" httpMethod:@"GET" params:parma queue:nil withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error)
     {
         CommentList* commentList = [[CommentList alloc]initWithDictionary:result];
         if ([self.delegate respondsToSelector:@selector(commentTimeLineRequestDidFinshed:Error:)]) {
//             NSLog(@"%@",result);
             [self.delegate commentTimeLineRequestDidFinshed:commentList Error:error];
//             NSLog(@"Error:%@",error);
         }
     }];
}

/**根据url和参数来请求评论
 */
-(void)commentByURL:(NSString*)url Parmas:(RequestCommentParma *)parmas
{
    NSInteger state = 0;
    if (parmas.since_id) {
        state = 1;
    }
    if (parmas.max_id) {
        state = 2;
    }
    NSDictionary *parma = [parmas dictaryValue];
    [WBHttpRequest requestWithURL:url httpMethod:@"GET" params:parma queue:nil withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error)
     {
         CommentList* commentList = [[CommentList alloc]initWithDictionary:result];
         if ([self.delegate respondsToSelector:@selector(commentOfURLRequestDidFinshed:State:Error:)]) {
//            NSLog(@"评论：%@",result);
             [self.delegate commentOfURLRequestDidFinshed:commentList State:state Error:error];
//                          NSLog(@"Error:%@",error);
         }
     }];
}

/**回复一条评论
 */
-(void)replyComment:(Comment*)comment WithParmas:(RequestCommentParma*)parmas
{
    NSDictionary *parma = [parmas dictaryValue];
     //NSLog(@"%@",prama);
    [WBHttpRequest requestWithURL:@"https://api.weibo.com/2/comments/reply.json" httpMethod:@"POST" params:parma queue:nil withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error)
     {
//        NSLog(@"%@",result);
//         NSLog(@"%@",error);
         if ([self.delegate respondsToSelector:@selector(replyCommentDidiFinishedError:)]) {
             [self.delegate replyCommentDidiFinishedError:error];
         }
     }];
}

/**
 *评论一条微博
 */
-(void)commentStatusWithParmas:(RequestCommentParma *)parmas
{
    NSDictionary *parma = [parmas dictaryValue];
    //NSLog(@"%@",prama);
    [WBHttpRequest requestWithURL:@"https://api.weibo.com/2/comments/create.json" httpMethod:@"POST" params:parma queue:nil withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error)
     {
//        NSLog(@"%@",result);
//         NSLog(@"%@",error);
         if ([self.delegate respondsToSelector:@selector(commentStatusDidFinishedError:)]) {
             [self.delegate commentStatusDidFinishedError:error];
         }
     }];
}

/**删除一条评论
 */
-(void)deleteCommentWithParmas:(RequestCommentParma *)parmas
{
    NSDictionary *parma = [parmas dictaryValue];
    [WBHttpRequest requestWithURL:@"https://api.weibo.com/2/comments/destroy.json" httpMethod:@"POST" params:parma queue:nil withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error)
     {
//        NSLog(@"%@",result);
//         NSLog(@"%@",error);
         if ([self.delegate respondsToSelector:@selector(deleteCommentDidiFinishedError:)]) {
             [self.delegate deleteCommentDidiFinishedError:error];
         }
     }];
}

/**
 *批量获取评论内容
 */
-(void)commentBatchByIDs:(RequestCommentParma*)parmas;
{
    NSDictionary *parma = [parmas dictaryValue];
    [WBHttpRequest requestWithURL:@"https://api.weibo.com/2/comments/show_batch.json" httpMethod:@"GET" params:parma queue:nil withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error)
     {
         CommentList* commentList = [[CommentList alloc]initWithDictionary:result];
         if ([self.delegate respondsToSelector:@selector(commentBatchRequestDidFinshed:Error:)]) {
//             NSLog(@"%@",result);
             [self.delegate commentBatchRequestDidFinshed:commentList Error:error];
//             NSLog(@"Error:%@",error);
         }
     }];
}

@end
