//
//  CommentRequest.h
//  sinaWeiboDemo1
//
//  Created by William-zhang on 15/1/21.
//  Copyright (c) 2015年 William-zhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommentList.h"
#import "RequestCommentParma.h"

@class Comment;
@class CommentList;
@class RequestCommentParma;

@protocol CommentDelegate <NSObject>

@optional
/**
 *获取某条微博的评论列表请求结束
 */
-(void)commentOfStatuRequestDidFinshed:(CommentList*)commentList State:(NSInteger)state Error:(NSError*)error;

/**
 *我发出的评论列表请求结束
 */
-(void)commentOfMineRequestDidFinshed:(CommentList*)commentList Error:(NSError*)error;

/**
 *我收到的评论列表请求结束
 */
-(void)commentToMeRequestDidFinshed:(CommentList*)commentList Error:(NSError*)error;

/**@我的评论列表请求结束
 */
-(void)commentMentionMeRequestDidFinished:(CommentList*)commentList Error:(NSError*)error;

/**
 *获取用户发送及收到的评论列表请求结束
 */
-(void)commentTimeLineRequestDidFinshed:(CommentList*)commentList Error:(NSError*)error;

/**根据url和参数来请求评论列表请求结束后
 */
-(void)commentOfURLRequestDidFinshed:(CommentList*)commentList State:(NSInteger)state Error:(NSError*)error;

/**
 *批量获取评论内容请求结束
 */
-(void)commentBatchRequestDidFinshed:(CommentList*)commentList Error:(NSError*)error;

/**回复一条评论结束后
 */
-(void)replyCommentDidiFinishedError:(NSError*)error;

/**删除一条评论结束后
 */
-(void)deleteCommentDidiFinishedError:(NSError*)error;

/**评论一条微博结束后
 */
-(void)commentStatusDidFinishedError:(NSError*)error;

@end



@interface CommentRequest : NSObject

@property(nonatomic, strong)id<CommentDelegate> delegate;

#pragma mark - 请求评论数据方法

/**
 *获取某条微博的评论列表
 */
-(void)commentOfStatuWithParmas:(RequestCommentParma*)parmas Status:(Statu*)statu;

/**
 *我发出的评论列表
 */
-(void)commentOfMineWithParmas:(RequestCommentParma*)parmas;

/**
 *我收到的评论列表
 */
-(void)commentToMeWithParmas:(RequestCommentParma*)parmas;

/**
 *获取用户发送及收到的评论列表
 */
-(void)commentTimeLineWithParmas:(RequestCommentParma*)parmas;

/**
 *获取@到我的评论
 */
-(void)commentMentionMeWithParmas:(RequestCommentParma*)parmas;

/**根据url和参数来请求评论
 */
-(void)commentByURL:(NSString*)url Parmas:(RequestCommentParma *)parmas;

/**
 *批量获取评论内容
 */
-(void)commentBatchByIDs:(RequestCommentParma*)parmas;

#pragma mark - 写入方法
/**
 *评论一条微博
 *ori表示当评论转发微博时
 */
-(void)commentStatusWithParmas:(RequestCommentParma*)parmas;

/**
 *删除一条评论
 */
-(void)deleteCommentWithParmas:(RequestCommentParma*)parmas;

/**
 *批量删除评论
 */
-(void)deleteBatchCommentWithParmas:(RequestCommentParma*)parmas;

/**
 *回复一条评论
 */
-(void)replyComment:(Comment*)comment WithParmas:(RequestCommentParma*)parmas;

@end
