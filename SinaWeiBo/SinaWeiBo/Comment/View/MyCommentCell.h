//
//  MyCommentCell.h
//  sinaWeiboDemo1
//
//  Created by William-zhang on 15/1/30.
//  Copyright (c) 2015年 William-zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LRWWeiBoLabel.h"

@class Comment;
@class MyCommentCell;
@class Statu;

@protocol MyCommentCellDelegate <NSObject>

@required
-(void)replyComment:(MyCommentCell*)cell;

-(void)statusViewClicked:(Statu*)statu;

@end

@interface MyCommentCell : UITableViewCell<LRWWeiBoLabelDelegate>
/**cell对应的评论内容
 */
@property(nonatomic, strong)Comment* comment;
/**cell的高度
 */
@property(nonatomic, assign)CGFloat height;
/**cell的宽度
 */
@property(nonatomic, assign)CGFloat width;
/**回复按钮
 */
@property(nonatomic, strong)UIButton* replyButton;

@property(nonatomic, strong)id<MyCommentCellDelegate>delegate;

/**置空cell的ContentView，在重用这个cell的时候要用调用
 */
-(void)setContentViewNULL;

@end
