//
//  SuggestionsRequest.h
//  WBTest
//
//  Created by mjx on 15/1/29.
//  Copyright (c) 2015年 MJX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RequestSuggestionParma.h"
#import "WeiboSDK.h"
#import "User.h"
#import "Statu.h"
#import "MayinterestedUesr.h"
#pragma mark --- 推荐类代理 ---
@protocol SuggestionsRequestDelegate <NSObject>

@optional
/**完成请求系统推荐的热门用户列表触发的代理方法, 数组中存放的是user类*/
- (void)HotUsersSuggestionRequestDidFinishedWithUsers:(NSArray*)users error:(NSError*)error;
/**完成请求可能感兴趣的用户列表触发的代理方法, 数组中存放的是MayinterestedUesr类*/
- (void)MayInterestedUsersSuggestionsRequestDidFinishedWithUsers:(NSArray*)users error:(NSError*)error;
/**完成请求根据一段微博正文推荐相关微博用户触发的代理方法, 数组中存放的事user类*/
- (void)UsersSuggestionByStatusRequestDidFinishedWithUsers:(NSArray*)users error:(NSError*)error;
/**完成请求系统推荐热门收藏触发的代理方法, 数组中存放的是statu累*/
- (void)HotFavoritesSuggestionRequestDidFinishedWithFavorites:(NSArray*)favorites error:(NSError*)error;
/**完成写入标识不感兴趣的人触发的代理方法*/
- (void)NotInterestedUserWriteDidFinishedWithUser:(User*)user error:(NSError*)error;




@end
#pragma mark --- 推荐类正文 ---
@interface SuggestionsRequest : NSObject
@property (nonatomic, strong) id<SuggestionsRequestDelegate> delegate;
#pragma mark -- 读取方法 --
/**系统推荐的热门用户列表
 *(必)access_token 采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 *category推荐分类，返回某一类别的推荐用户，默认为default，如果不在以下分类中，返回空列表，default：人气关注、ent：影视名星、music：音乐、sports：体育、fashion：时尚、art：艺术、cartoon：动漫、games：游戏、trip：旅行、food：美食、health：健康、literature：文学、stock：炒股、business：商界、tech：科技、house：房产、auto：汽车、fate：命理、govern：政府、medium：媒体、marketer：营销专家。
 */
- (void)HotUsersSuggestionRequestWithParma:(RequestSuggestionParma*)parma;

/**获取用户可能感兴趣的人
 *(必)access_token 采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 *count 单页返回的记录条数，默认为10。
 *page 返回结果的页码，默认为1。
 *注意申请到的数据每次都会不一样,而推荐原因的由于多少个"粉丝/关注者"关注的数量和实际给出来的id数量不一样,id数量5个封顶
 */
- (void)MayInterestedUsersSuggestionsRequestWithParma:(RequestSuggestionParma*)parma;

/**根据一段微博正文推荐相关微博用户
 *不知道如何推荐,试了几条都返回空
 *(必)access_token 采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 *(必)content 微博正文内容，必须做URLEncode，UTF-8编码 。
 *num 返回结果数目，默认为10。
 */
- (void)UsersSuggestionByStatusRequestWithParma:(RequestSuggestionParma*)parma;

/**返回系统推荐的热门收藏
 *access_token 采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 *count 每页返回结果数，默认20。
 *page 返回页码，默认1。
*/
- (void)HotFavoritesSuggestionRequestWithParma:(RequestSuggestionParma*)parma;

#pragma mark -- 写入方法 -- 
/**把某人标识为不感兴趣的人
 *此方法返回errir不知道为什么
 *access_token 采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 *uid 不感兴趣的用户的UID。
 */
- (void)NotInterestedUserWriteWithParma:(RequestSuggestionParma*)parma;
@end
