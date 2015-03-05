//
//  SendCommentController.h
//  sinaWeiboDemo1
//
//  Created by William-zhang on 15/1/28.
//  Copyright (c) 2015年 William-zhang. All rights reserved.
//

#import "CommentRequest.h"
#import "StatuRequest.h"
#import "TextViewController.h"
#import "LRWWeiBoKeyBoardToolBar.h"


@class Statu;
@class Comment;

typedef NS_ENUM (NSInteger, WLControllerType)
{
    WLRetweetedControllerType = 1,  //转发
    WLCommentControllerType,        //评论
    WLReplyControllerType,          //回复评论
};

@interface SendCommentController : TextViewController<CommentDelegate, StatuRequestDelegate, LRWWeiBoKeyBoardToolBarDelegate>
/**需要回复的评论的微博/需要评论的微博/需要转发的微博
 */
@property(nonatomic, weak)Statu* statu;
/**需要回复的评论
 */
@property(nonatomic, weak)Comment* comment;
/**控制器类型
 */
@property(nonatomic, assign)WLControllerType controllerType;


@end
