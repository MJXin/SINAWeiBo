//
//  FavoritesRequest.h
//  WBTest
//
//  Created by mjx on 15/1/27.
//  Copyright (c) 2015年 MJX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RequestFavoritesParma.h"
#import "WeiboSDK.h"
#import "FavoritesList.h"
#pragma mark --- FavoritesRequest类代理
@protocol FavoritesRequestDelegate <NSObject>

@optional
#pragma mark -- 读取方法 --
/**完成获取当前登录用户收藏列表触发的代理方法 代理可以从favorites中包含收藏的标签和微博以及收藏日期*/
- (void)FavoritesRequestDidFinishedWithFavoritesList:(FavoritesList*)favoritesList favorites:(NSArray*)favorites error:(NSError*)error;

/**完成获取当前登录用户收藏列表Id触发的代理方法 代理可以从favorites中包含收藏的标签和微博以及收藏日期*/
- (void)FavoritesIdRequestDidFinishedWithFavoritesList:(FavoritesList*)favoritesList favoritesId:(NSArray*)favoritesId error:(NSError*)error;

/**完成通过收藏id请求收藏触发的代理方法*/
- (void)FavoritesRequestWithFavoriteIdDidFinishedWithfavorites:(Favorite *)favorite error:(NSError *)error;
/**完成通过tagId请求收藏触发的代理方法 代理可以从favorites中包含收藏的标签和微博以及收藏日期*/
- (void)FavoritesRequestByTagsDidFinishedWithFavoritesList:(FavoritesList*)favoritesList favorites:(NSArray*)favorites error:(NSError*)error;
/**完成通过tagId请求收藏Id触发的代理方法 代理可以从favorites中包含收藏的标签和微博以及收藏日期*/
- (void)FavoritesIdRequestByTagsDidFinishedWithFavoritesList:(FavoritesList*)favoritesList favoritesId:(NSArray*)favoritesId error:(NSError*)error;

/**完成请求登录用户的收藏列表触发的代理方法  代理可以从tags中获取标签组*/
- (void)TagsRequestDidFinishedWithFavoritesList:(FavoritesList*)favoritesList Tags:(NSArray*)tags error:(NSError*)error;

#pragma mark -- 写入方法 --
/**完成收藏一条微博的代理方法*/
- (void)CreatFavoritesWriteDidFinishedWithfavorites:(Favorite *)favorite error:(NSError *)error;
/**完成取消收藏一条微博的代理方法*/
- (void)DestroyFavoritesWriteDidFinishedWithfavorites:(Favorite *)favorite error:(NSError *)error;
/**完成根据收藏ID批量取消收藏*/
- (void)DestroyBatchFavoritesWriteDidFinishedWitherror:(NSError *)error;
/**完成更新一条收藏的收藏标签触发的代理方法*/
- (void)UpdateFavoritesTagsWriteDidFinishedWithfavorites:(Favorite *)favorite error:(NSError *)error;
/**完成修改某个标签的名字触发的代理方法*/
- (void)UpdateBatchFavoritesTagsWriteDidFinishedWithTag:(Tag*)tag error:(NSError *)error;
/**完成删除当前登录用户所有收藏下的指定标签*/
- (void)DestroyBatchFavoritesTagsWriteDidFinishedWitherror:(NSError *)error;




@end

#pragma mark --- FavoritesRequest类正文 ---
@interface FavoritesRequest : NSObject
@property (nonatomic, strong) id<FavoritesRequestDelegate> delegate;
#pragma mark -- 读取方法 --

/**获取当前登录用户的收藏列表
 *access_token 采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 *count 单页返回的记录条数，默认为50。
 *page 返回结果的页码，默认为1。
 */
- (void)FavoritesRequestWithParma:(RequestFavoritesParma*)parma;

/**获取当前登录用户的收藏列表微博Id
 *注意获取的是id
 *access_token 采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 *count 单页返回的记录条数，默认为50。
 *page 返回结果的页码，默认为1。
 */
- (void)FavoritesIdRequestWithParma:(RequestFavoritesParma*)parma;

/**根据收藏ID获取指定的收藏信息
 *access_token 采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 *Id 需要查询的收藏ID,这个id是微博id
 */
- (void)FavoritesRequestWithFavoriteIdParma:(RequestFavoritesParma*)parma;

/**根据标签获取当前登录用户该标签下的收藏列表
 *source 采用OAuth授权方式不需要此参数，其他授权方式为必填参数，数值为应用的AppKey。
 *access_token 采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 *tid 需要查询的标签ID。
 *count 单页返回的记录条数，默认为50。
 *page 返回结果的页码，默认为1。
 */
- (void)FavoritesRequestByTagsWithParma:(RequestFavoritesParma*)parma;

/**获取当前用户某个标签下的收藏列表的ID
 *注意获取的是id
 *source 采用OAuth授权方式不需要此参数，其他授权方式为必填参数，数值为应用的AppKey。
 *access_token 采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 *tid 需要查询的标签ID。
 *count 单页返回的记录条数，默认为50。
 *page 返回结果的页码，默认为1。
 */
- (void)FavoritesIdRequestByTagsWithParma:(RequestFavoritesParma*)parma;

/**获取当前登录用户的收藏标签列表
 *access_token 采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 *count 单页返回的记录条数，默认为10。
 *page 返回结果的页码，默认为1。
 */
- (void)TagsRequestWithParma:(RequestFavoritesParma*)parma;

#pragma mark -- 写入方法 -- 

/**收藏一跳微博
 *access_token 采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 *id 要收藏的微博ID。
 */
- (void)CreatFavoritesWriteWithParma:(RequestFavoritesParma*)parma;

/**取消收藏一条微博
 *access_token 采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 *id 要取消收藏的微博ID。
 */
- (void)DestroyFavoritesWriteWithParma:(RequestFavoritesParma*)parma;

/**根据收藏ID批量取消收藏
 *access_token 采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 *ids 要取消收藏的收藏ID，用半角逗号分隔，最多不超过10个。
 */
- (void)DestroyBatchFavoritesWriteWithParma:(RequestFavoritesParma*)parma;

/**设置一条收藏的收藏标签
 *access_token 采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 *id 需要更新的收藏ID。
 *tags 需要更新的标签内容，必须做URLencode，用半角逗号分隔，最多不超过2条。
 */
- (void)UpdateFavoritesTagsWriteWithParma:(RequestFavoritesParma*)parma;

/**修改某个标签的名字
 *access_token 采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 *tid 需要修改的标签ID。
 *tag 修改成的名字，必须做URLencode。
 *注意微博收藏的id是跟着名字走的,名字变了id也变
 */
- (void)UpdateBatchFavoritesTagsWriteWithParma:(RequestFavoritesParma*)parma;

/**删除当前登录用户收藏下的指定标签
 *删除标签后，该用户所有收藏中，添加了该标签的收藏均解除与该标签的关联关系
 *access_token采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 *tid需要删除的标签ID。
*/
- (void)DestroyBatchFavoritesTagsWriteWithParma:(RequestFavoritesParma*)parma;

@end
