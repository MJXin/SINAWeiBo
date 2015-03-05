//
//  MyCommentViewController.h
//  SinaWeiBo
//
//  Created by William-zhang on 15/2/7.
//  Copyright (c) 2015年 LMZ. All rights reserved.
//

#import "LRWRefreshTableViewController.h"
#import "CommentRequest.h"
#import "MyCommentCell.h"



//评论类型
typedef NS_ENUM(NSInteger, WLComentType)
{
    WLAllComentType = 1,    //所有评论，这个评论包括了我收到的和我发出的，不包含@我的评论
    WLSendToMeCommentType,  //我收到的评论
    WLSendByMeCommentType,  //我发出的评论
    WLMentionMeComentType   //@我的评论
};

@interface MyCommentViewController : LRWRefreshTableViewController<CommentDelegate, UITableViewDataSource, MyCommentCellDelegate,LRWRefreshTableViewControllerDelegate, UIActionSheetDelegate>
/**评论类型
 */
@property(nonatomic, assign)WLComentType commentType;

/**评论请求参数
 */
@property(nonatomic, strong)RequestCommentParma* requestParma;


@end
