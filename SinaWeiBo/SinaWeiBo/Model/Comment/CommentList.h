//
//  CommentList.h
//  sinaWeiboDemo1
//
//  Created by William-zhang on 15/1/22.
//  Copyright (c) 2015年 William-zhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Comment.h"


@interface CommentList : NSObject

/**评论列表**/
@property(nonatomic, strong)NSArray* comments;
/**评论总数**/
@property(nonatomic, assign)NSUInteger total_number;

/** 不明字段 **/

@property(nonatomic, strong)id hasvisible;
@property(nonatomic, strong)id marks;
@property(nonatomic, strong)id next_cursor;
@property(nonatomic, strong)id previous_cursor;

/**通过json初始化得到评论列表
 *当这些评论属于同一微博时使用
 */
-(CommentList*)initWithDictionary:(NSDictionary*)dictionary Statu:(Statu*)statu;


/**通过json初始化得到评论列表
 *当这些评论属于不同微博时使用
 */
-(CommentList*)initWithDictionary:(NSDictionary*)dictionary;



@end
