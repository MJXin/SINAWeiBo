//
//  SuggestionsRequest.m
//  WBTest
//
//  Created by mjx on 15/1/29.
//  Copyright (c) 2015年 MJX. All rights reserved.
//

#import "SuggestionsRequest.h"

@implementation SuggestionsRequest

/**返回系统推荐的热门用户列表
 *access_token 采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 *category推荐分类，返回某一类别的推荐用户，默认为default，如果不在以下分类中，返回空列表，default：人气关注、ent：影视名星、music：音乐、sports：体育、fashion：时尚、art：艺术、cartoon：动漫、games：游戏、trip：旅行、food：美食、health：健康、literature：文学、stock：炒股、business：商界、tech：科技、house：房产、auto：汽车、fate：命理、govern：政府、medium：媒体、marketer：营销专家。
 */
- (void)HotUsersSuggestionRequestWithParma:(RequestSuggestionParma*)parma
{
    NSString *url = @"https://api.weibo.com/2/suggestions/users/hot.json";
    NSDictionary *parmas = [parma dictaryValue];
    [WBHttpRequest requestWithURL:url httpMethod:@"GET" params:parmas queue:nil withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error)
     {
         NSArray *usersArr = result;
         NSMutableArray *users = [NSMutableArray new];
         for (NSDictionary *userdict in usersArr) {
             User *user = [[User alloc]initWithDict:userdict];
             [users addObject:user];
             if(users.count >30)
                 break;
         }
         
         
         [self.delegate HotUsersSuggestionRequestDidFinishedWithUsers:users error:error];
         
     }];
}

/**获取用户可能感兴趣的人
 *access_token 采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 *count 单页返回的记录条数，默认为10。
 *page 返回结果的页码，默认为1。
 */
- (void)MayInterestedUsersSuggestionsRequestWithParma:(RequestSuggestionParma*)parma
{
    NSString *url = @"https://api.weibo.com/2/suggestions/users/may_interested.json";
    NSDictionary *parmas = [parma dictaryValue];
    [WBHttpRequest requestWithURL:url httpMethod:@"GET" params:parmas queue:nil withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error)
     {
         NSArray *mayinterestedUsersArr = result;
         NSMutableArray *mayinterestedUsers = [NSMutableArray new];
         for (NSDictionary *mayinterestedUserDict  in mayinterestedUsersArr) {
             MayinterestedUesr *user = [[MayinterestedUesr alloc]initWithDict:mayinterestedUserDict];
             [mayinterestedUsers addObject:user];
         }
         [self.delegate MayInterestedUsersSuggestionsRequestDidFinishedWithUsers:mayinterestedUsers error:error];
     }];
}

/**根据一段微博正文推荐相关微博用户
 *access_token 采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 *content 微博正文内容，必须做URLEncode，UTF-8编码 。
 *num 返回结果数目，默认为10。
 */
- (void)UsersSuggestionByStatusRequestWithParma:(RequestSuggestionParma*)parma
{
    NSString *url = @"https://api.weibo.com/2/suggestions/users/by_status.json";
    NSDictionary *parmas = [parma dictaryValue];
    [WBHttpRequest requestWithURL:url httpMethod:@"GET" params:parmas queue:nil withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error)
     {
         NSDictionary *dict = result;
          NSMutableArray *users = [NSMutableArray new];

         if (dict[@"users"]) {
             NSArray *usersArr = dict[@"users"];
                         for (NSDictionary *userdict in usersArr) {
                 User *user = [[User alloc]initWithDict:userdict];
                 [users addObject:user];
             }
             
         }
         [self.delegate UsersSuggestionByStatusRequestDidFinishedWithUsers:users error:error];
     }];
}

/**返回系统推荐的热门收藏
 *access_token 采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 *count 每页返回结果数，默认20。
 *page 返回页码，默认1。
 */
- (void)HotFavoritesSuggestionRequestWithParma:(RequestSuggestionParma*)parma
{
    NSString *url = @"https://api.weibo.com/2/suggestions/favorites/hot.json";
    NSDictionary *parmas = [parma dictaryValue];
    [WBHttpRequest requestWithURL:url httpMethod:@"GET" params:parmas queue:nil withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error)
     {
         NSArray *hotfavoritesArr = result;
         NSMutableArray *hotFavorites = [NSMutableArray new];
         for (NSDictionary *hotFavorityDict in hotfavoritesArr) {
             Statu *statu = [[Statu alloc]initWithDict:hotFavorityDict];
             [hotFavorites addObject:statu];
         }
         
         [self.delegate HotFavoritesSuggestionRequestDidFinishedWithFavorites:hotFavorites error:error];
         
     }];
}

/**把某人标识为不感兴趣的人
 *access_token 采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 *uid 不感兴趣的用户的UID。
 */
- (void)NotInterestedUserWriteWithParma:(RequestSuggestionParma*)parma
{
    NSString *url = @"https://api.weibo.com/2/suggestions/users/not_interested.json";
    NSDictionary *parmas = [parma dictaryValue];
    [WBHttpRequest requestWithURL:url httpMethod:@"POST" params:parmas queue:nil withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error)
     {
         NSDictionary *dict = result;
         User *user = [[User alloc]initWithDict:dict];
         [self.delegate NotInterestedUserWriteDidFinishedWithUser:user error:error];
         
     }];
}

@end
