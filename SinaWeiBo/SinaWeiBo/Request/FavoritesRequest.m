//
//  FavoritesRequest.m
//  WBTest
//
//  Created by mjx on 15/1/27.
//  Copyright (c) 2015年 MJX. All rights reserved.
//

#import "FavoritesRequest.h"

@implementation FavoritesRequest

/**获取当前登录用户的收藏列表
 *access_token 采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 *count 单页返回的记录条数，默认为50。
 *page 返回结果的页码，默认为1。
 */
- (void)FavoritesRequestWithParma:(RequestFavoritesParma*)parma
{
    NSString *url =@"https://api.weibo.com/2/favorites.json";
    NSDictionary *parmas = [parma dictaryValue];
    [WBHttpRequest requestWithURL:url httpMethod:@"GET" params:parmas queue:nil withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error)
     {
         NSDictionary *dict = result;
         FavoritesList *favoritesList = [[FavoritesList alloc]initWithDict:dict];
         NSArray *favorites = favoritesList.favorites;
         
         [self.delegate FavoritesRequestDidFinishedWithFavoritesList:favoritesList favorites:favorites error:error];
     }];

}

/**获取当前登录用户的收藏列表微博Id
 *注意获取的是id
 *access_token 采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 *count 单页返回的记录条数，默认为50。
 *page 返回结果的页码，默认为1。
 */
- (void)FavoritesIdRequestWithParma:(RequestFavoritesParma*)parma;
{
    NSString *url =@"https://api.weibo.com/2/favorites/ids.json";
    NSDictionary *parmas = [parma dictaryValue];
    [WBHttpRequest requestWithURL:url httpMethod:@"GET" params:parmas queue:nil withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error)
     {
         NSDictionary *dict = result;
         FavoritesList *favoritesList = [[FavoritesList alloc]initFavoriteIdWithDict:dict];
         NSArray *favoritesId = favoritesList.favorites;
         
         [self.delegate FavoritesIdRequestDidFinishedWithFavoritesList:favoritesList favoritesId:favoritesId error:error];
     }];
    
}

/**根据收藏ID获取指定的收藏信息
 *access_token 采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 *Id 需要查询的收藏ID。这个id推测是微博id,因为找不到具体叫收藏id的字段
 */
- (void)FavoritesRequestWithFavoriteIdParma:(RequestFavoritesParma*)parma
{
    NSString *url = @"https://api.weibo.com/2/favorites/show.json";
    NSDictionary *parmas = [parma dictaryValue];
    [WBHttpRequest requestWithURL:url httpMethod:@"GET" params:parmas queue:nil withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error)
     {
         NSDictionary *dict = result;
         Favorite *favorite = [[Favorite alloc]initWithDict:dict];
         [self.delegate FavoritesRequestWithFavoriteIdDidFinishedWithfavorites:favorite error:error];
     }];

}

/**根据标签获取当前登录用户该标签下的收藏列表
 *source 采用OAuth授权方式不需要此参数，其他授权方式为必填参数，数值为应用的AppKey。
 *access_token 采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 *tid 需要查询的标签ID。
 *count 单页返回的记录条数，默认为50。
 *page 返回结果的页码，默认为1。
 */
- (void)FavoritesRequestByTagsWithParma:(RequestFavoritesParma*)parma
{
    NSString *url =@"https://api.weibo.com/2/favorites/by_tags.json";
    NSDictionary *parmas = [parma dictaryValue];
    [WBHttpRequest requestWithURL:url httpMethod:@"GET" params:parmas queue:nil withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error)
     {
         NSDictionary *dict = result;
         FavoritesList *favoritesList = [[FavoritesList alloc]initWithDict:dict];
         NSArray *favorites = favoritesList.favorites;
         
         [self.delegate FavoritesRequestByTagsDidFinishedWithFavoritesList:favoritesList favorites:favorites error:error];
     }];

}

/**根据标签获取当前登录用户该标签下的收藏列表Id
 *注意获取的是id
 *source 采用OAuth授权方式不需要此参数，其他授权方式为必填参数，数值为应用的AppKey。
 *access_token 采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 *tid 需要查询的标签ID。
 *count 单页返回的记录条数，默认为50。
 *page 返回结果的页码，默认为1。
 */
- (void)FavoritesIdRequestByTagsWithParma:(RequestFavoritesParma*)parma
{
    NSString *url =@"https://api.weibo.com/2/favorites/by_tags/ids.json";
    NSDictionary *parmas = [parma dictaryValue];
    [WBHttpRequest requestWithURL:url httpMethod:@"GET" params:parmas queue:nil withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error)
     {
         NSDictionary *dict = result;
         FavoritesList *favoritesList = [[FavoritesList alloc]initFavoriteIdWithDict:dict];
         NSArray *favoritesId = favoritesList.favorites;
         
         [self.delegate FavoritesIdRequestByTagsDidFinishedWithFavoritesList:favoritesList favoritesId:favoritesId error:error];
     }];
    
}


/**获取当前登录用户的收藏标签列表
 *access_token 采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 *count 单页返回的记录条数，默认为10。
 *page 返回结果的页码，默认为1。
 */
- (void)TagsRequestWithParma:(RequestFavoritesParma*)parma
{
    NSString *url =@"https://api.weibo.com/2/favorites/tags.json";
    NSDictionary *parmas = [parma dictaryValue];
    [WBHttpRequest requestWithURL:url httpMethod:@"GET" params:parmas queue:nil withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error)
     {
         NSDictionary *dict = result;
         FavoritesList *favoritesList = [[FavoritesList alloc]initTagsWithDict:dict];
         NSArray *tags = favoritesList.tags;
         
         [self.delegate TagsRequestDidFinishedWithFavoritesList:favoritesList Tags:tags error:error];
     }];
}

/**收藏一条微博
 *access_token 采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 *id 要收藏的微博ID。
 */
- (void)CreatFavoritesWriteWithParma:(RequestFavoritesParma*)parma
{
    NSString *url = @"https://api.weibo.com/2/favorites/create.json";
    NSDictionary *parmas = [parma dictaryValue];
    [WBHttpRequest requestWithURL:url httpMethod:@"POST" params:parmas queue:nil withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error)
     {
         NSDictionary *dict = result;
         Favorite *favorite = [[Favorite alloc]initWithDict:dict];
         [self.delegate CreatFavoritesWriteDidFinishedWithfavorites:favorite error:error];
     }];
}

/**取消收藏一条微博
 *access_token 采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 *id 要取消收藏的微博ID。
 */
- (void)DestroyFavoritesWriteWithParma:(RequestFavoritesParma*)parma
{
    NSString *url = @"https://api.weibo.com/2/favorites/destroy.json";
    NSDictionary *parmas = [parma dictaryValue];
    [WBHttpRequest requestWithURL:url httpMethod:@"POST" params:parmas queue:nil withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error)
     {
         NSDictionary *dict = result;
         Favorite *favorite = [[Favorite alloc]initWithDict:dict];
         [self.delegate DestroyFavoritesWriteDidFinishedWithfavorites:favorite error:error];
         
    }];
}

/**根据收藏ID批量取消收藏
 *access_token 采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 *ids 要取消收藏的收藏ID，用半角逗号分隔，最多不超过10个。
 */
- (void)DestroyBatchFavoritesWriteWithParma:(RequestFavoritesParma*)parma
{
    NSString *url = @"https://api.weibo.com/2/favorites/destroy_batch.json";
    NSDictionary *parmas = [parma dictaryValue];
    [WBHttpRequest requestWithURL:url httpMethod:@"POST" params:parmas queue:nil withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error)
     {
         NSDictionary *dict = result;
         if ( dict[@"result"] && [dict[@"result"] isEqual:@NO] ) {
             error = [NSError errorWithDomain:@"失败" code:-500 userInfo:nil];
         }
         [self.delegate DestroyBatchFavoritesWriteDidFinishedWitherror:error];
     }];
}

/**更新一条收藏的收藏标签
 *access_token 采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 *id 需要更新的收藏ID。
 *tags 需要更新的标签内容，必须做URLencode，用半角逗号分隔，最多不超过2条。
 */
- (void)UpdateFavoritesTagsWriteWithParma:(RequestFavoritesParma*)parma
{
    NSString *url = @"https://api.weibo.com/2/favorites/tags/update.json";
    NSDictionary *parmas = [parma dictaryValue];
    [WBHttpRequest requestWithURL:url httpMethod:@"POST" params:parmas queue:nil withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error)
     {
         NSDictionary *dict = result;
         Favorite *favorite = [[Favorite alloc]initWithDict:dict];
         [self.delegate UpdateFavoritesTagsWriteDidFinishedWithfavorites:favorite error:error];
     }];

}

/**修改某个标签的名字
 *access_token 采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 *tid 需要修改的标签ID。
 *tag 修改成的名字，必须做URLencode。
 */
- (void)UpdateBatchFavoritesTagsWriteWithParma:(RequestFavoritesParma*)parma
{
    NSString *url = @"https://api.weibo.com/2/favorites/tags/update_batch.json";
    NSDictionary *parmas = [parma dictaryValue];
    [WBHttpRequest requestWithURL:url httpMethod:@"POST" params:parmas queue:nil withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error)
     {
         NSDictionary *dict = result;
         Tag *tag = [[Tag alloc]initWithDict:dict];
         [self.delegate UpdateBatchFavoritesTagsWriteDidFinishedWithTag:tag error:error];
     }];
}

/**删除当前登录用户收藏下的指定标签
 *删除标签后，该用户所有收藏中，添加了该标签的收藏均解除与该标签的关联关系
 *access_token采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 *tid需要删除的标签ID。
 */
- (void)DestroyBatchFavoritesTagsWriteWithParma:(RequestFavoritesParma*)parma
{
    NSString *url = @"https://api.weibo.com/2/favorites/tags/destroy_batch.json";
    NSDictionary *parmas = [parma dictaryValue];
    [WBHttpRequest requestWithURL:url httpMethod:@"POST" params:parmas queue:nil withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error)
     {
         NSDictionary *dict = result;
         if ( dict[@"result"] && [dict[@"result"]  isEqual: @NO] ) {
             error = [NSError errorWithDomain:@"失败" code:-500 userInfo:nil];
         }
         [self.delegate DestroyBatchFavoritesTagsWriteDidFinishedWitherror:error];
         
         
     }];

}





@end
