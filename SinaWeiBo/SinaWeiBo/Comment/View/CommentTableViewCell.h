//
//  CommentTableViewCell.h
//  sinaWeiboDemo1
//
//  Created by William-zhang on 15/1/26.
//  Copyright (c) 2015年 William-zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LRWWeiBoLabel.h"
@class Comment;

@interface CommentTableViewCell : UITableViewCell<LRWWeiBoLabelDelegate>
/**cell对应的评论内容
 */

@property(nonatomic, strong)Comment* comment;
/**cell的高度
 */
@property(nonatomic, readonly)CGFloat height;

/**把用户头像设成默认的
 */
-(void)setUserDefaultIcon;

-(void)setCommentBy:(Comment*)comment;

@end
