//
//  RequestCommentParma.h
//  sinaWeiboDemo1
//
//  Created by William-zhang on 15/1/22.
//  Copyright (c) 2015年 William-zhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RequestCommentParma : NSObject

/**采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。 
 */
@property (nonatomic, strong) NSString *access_token;

/**评论内容，必须做URLencode，内容不超过140个汉字。
 */
@property (nonatomic, strong) NSString *comment;

/**若指定此参数，则返回ID比since_id大的评论（即比since_id时间晚的评论），默认为0 
 */
@property (nonatomic, strong) NSString *since_id;

/**若指定此参数，则返回ID小于或等于max_id的评论，默认为0。 
 */
@property (nonatomic, strong) NSString *max_id;

/**单页返回的记录条数，最大不超过100，默认为50。 */
@property (nonatomic, strong) NSString *count;

/**返回结果的页码，默认为1。 */
@property (nonatomic, strong) NSString *page;

/**返回值中user字段开关，0：返回完整user字段、1：user字段仅返回user_id，默认为0。 
 *只有在“获取用户发送及收到的评论列表”的时候选填
 */
@property (nonatomic, strong) NSString *trim_user;
/**作者筛选类型，0：全部、1：我关注的人、2：陌生人，默认为0。
 *在请求“获取某条微博的评论列表”、“我收到的评论列表”、“@我的评论列表”的时候可以选填
 */
@property (nonatomic, strong) NSString *filter_by_author;

/**来源筛选类型，0：全部、1：来自微博的评论、2：来自微群的评论，默认为0。
 *在请求 “我发出的评论列表”、“我收到的评论列表”、“@我的评论列表” 的时候可以选填
 */
@property (nonatomic, strong) NSString *filter_by_source;

/**需要查询评论的微博的Id
 *这个参数在请求某条微博的评论的时候必须填
 */
@property (nonatomic, strong) NSString *status_Id;

/**需要查询回复的评论Id
 *这个参数在请求回复某条评论的时候必须填
 */
@property (nonatomic, strong) NSString *cid;

/**当评论转发微博时，是否评论给原微博，0：否、1：是，默认为0。
 *在“评论一条微博”、“回复一条评论”的时候选填
 */
@property (nonatomic, strong) NSString *comment_ori;

/**回复中是否自动加入“回复@用户名”，0：是、1：否，默认为0。
 * “回复一条评论”时选填
 */
@property (nonatomic, strong) NSString *without_mention;

/**开发者上报的操作用户真实IP，形如：211.156.0.1。
 *这个参数不理解，先忽略
 */
@property (nonatomic, strong) NSString *rip;


/** 使用access_token初始化
 */
- (instancetype)initWithAccess_token:(NSString*)access_token;

/** 转换为字典
 */
- (NSDictionary*)dictaryValue;

@end
