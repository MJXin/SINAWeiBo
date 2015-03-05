//
//  Comment.h
//  sinaWeiboDemo1
//
//  Created by William-zhang on 15/1/21.
//  Copyright (c) 2015年 William-zhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@class User;
@class Statu;

@interface Comment : NSObject

/**评论的id **/
@property(nonatomic, assign)NSUInteger Id;
/**该评论在所有评论中是第几条**/
@property(nonatomic, assign)NSUInteger floorNum;
/**评论内容**/
@property(nonatomic, strong)NSString* text;
/**评论时间**/
@property(nonatomic, strong)NSString* date;
/**评论者**/
@property(nonatomic, strong)User* user;
/**这条评论回复的评论**/
@property(nonatomic, strong)Comment* reply;
/**这条评论所属的微博**/
@property(nonatomic, strong)Statu* status;

/**以下为保留属性**/

/**评论的mid**/
@property(nonatomic, strong)NSString* mid;
/**评论id的字符串类型**/
@property(nonatomic, strong)NSString* idStr;
/**评论来源，一个Html的<a>超链接**/
@property(nonatomic, strong)NSString* source;
/**评论来源类型**/
@property(nonatomic, assign)NSInteger source_type;

/**通过json数据初始化
 */
-(Comment*)initWithDictionary:(NSDictionary*)dictionary;

/**通过json和一个微博对象初始化
 */
-(Comment*)initWithDictionary:(NSDictionary *)dictionary Statu:(Statu*)statu;


@end
