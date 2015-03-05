//
//  ShortURLRequest.m
//  WBTest
//
//  Created by mjx on 15/1/30.
//  Copyright (c) 2015年 MJX. All rights reserved.
//

#import "ShortURLRequest.h"

@implementation ShortURLRequest


/**将一个或多个长链接转换成短链接
 *access_token 采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 *url_long 需要转换的长链接，需要URLencoded，最多不超过20个。
 *多个url参数需要使用如下方式：url_long=aaa&url_long=bbb
 */
- (void)ShortenURLRequestWithParma:(RequestShortURLParma*)parma
{
    NSString *url = @"https://api.weibo.com/2/short_url/shorten.json";
    NSDictionary *parmas = [parma dictaryValue];
    [WBHttpRequest requestWithURL:url httpMethod:@"GET" params:parmas queue:nil withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error)
     {
         NSDictionary *dict = result;
         NSMutableArray *urls = [NSMutableArray new];
         if(dict[@"urls"])
         {
             NSArray *urlsArr = dict[@"urls"];
             for (NSDictionary *urlDict in urlsArr) {
                 Url *url = [[Url alloc]initWithDict:urlDict];
                 [urls addObject:url];
             }
         }
         [self.delegate ShortenURLRequestDidFinishedWithUrls:urls error:error];
     }];
}

/**将一个或多个短链接还原成原始的长链接
 *access_token 采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 *url_long 需要转换的长链接，需要URLencoded，最多不超过20个。
 *没弄明白多个怎么传进去
 */
- (void)ExpandURLRequestWithParma:(RequestShortURLParma*)parma
{
    NSString *url = @"https://api.weibo.com/2/short_url/expand.json";
    NSDictionary *parmas = [parma dictaryValue];
    [WBHttpRequest requestWithURL:url httpMethod:@"GET" params:parmas queue:nil withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error)
     {
         NSDictionary *dict = result;
         NSMutableArray *urls = [NSMutableArray new];
         if(dict[@"urls"])
         {
             NSArray *urlsArr = dict[@"urls"];
             for (NSDictionary *urlDict in urlsArr) {
                 Url *url = [[Url alloc]initWithDict:urlDict];
                 [urls addObject:url];
             }
         }
         [self.delegate ExpandURLRequestDidFinishedWithUrls:urls error:error];
     }];

}

/**获取短链接在微博上的微博分享数
 *access_token 采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 *url_short 需要取得分享数的短链接，需要URLencoded，最多不超过20个。
 */
- (void)ShortUrlShareStatusesCountRequestWithParma:(RequestShortURLParma*)parma
{
    NSString *url = @"https://api.weibo.com/2/short_url/share/counts.json";
    NSDictionary *parmas = [parma dictaryValue];
    [WBHttpRequest requestWithURL:url httpMethod:@"GET" params:parmas queue:nil withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error)
     {
         NSDictionary *dict = result;
         NSMutableArray *urls = [NSMutableArray new];
         if(dict[@"urls"])
         {
             NSArray *urlsArr = dict[@"urls"];
             for (NSDictionary *urlDict in urlsArr) {
                 Url *url = [[Url alloc]initWithDict:urlDict];
                 [urls addObject:url];
             }
         }
         [self.delegate ShortUrlShareStatusesCountRequestDidFinishedWithUrls:urls error:error];
     }];

}

/**获取包含指定单个短链接的最新微博内容
 *access_token 采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 *url_short 需要取得分享数的短链接，需要URLencoded，最多不超过20个。
 *since_id 若指定此参数，则返回ID比since_id大的微博（即比since_id时间晚的微博），默认为0。
 *max_id 若指定此参数，则返回ID小于或等于max_id的微博，默认为0。
 *count 单页返回的记录条数，默认为50，最多不超过200。
 *page 返回结果的页码，默认为1。
 */
- (void)ShortUrlShareStatusesRequestWithParma:(RequestShortURLParma*)parma
{
    NSString *url = @"https://api.weibo.com/2/short_url/share/statuses.json";
    NSDictionary *parmas = [parma dictaryValue];
    [WBHttpRequest requestWithURL:url httpMethod:@"GET" params:parmas queue:nil withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error)
     {
         NSDictionary *dict = result;
         Url *url = [[Url alloc]initWithDict:dict];
         [self.delegate ShortUrlShareStatusesRequestDidFinishedWithUrl:url error:error];
     }];

}

/**获取短链接在微博上的微博评论数
 *access_token 采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 *url_short 需要取得分享数的短链接，需要URLencoded，最多不超过20个。
 */
- (void)ShortUrlShareCommentCountRequestWithParma:(RequestShortURLParma*)parma
{
    NSString *url = @"https://api.weibo.com/2/short_url/comment/counts.json";
    NSDictionary *parmas = [parma dictaryValue];
    [WBHttpRequest requestWithURL:url httpMethod:@"GET" params:parmas queue:nil withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error)
     {
         NSDictionary *dict = result;
         NSMutableArray *urls = [NSMutableArray new];
         if(dict[@"urls"])
         {
             NSArray *urlsArr = dict[@"urls"];
             for (NSDictionary *urlDict in urlsArr) {
                 Url *url = [[Url alloc]initWithDict:urlDict];
                 [urls addObject:url];
             }
         }
         [self.delegate ShortUrlShareCommentCountRequestDidFinishedWithUrls:urls error:error];
     }];

}

/**获取包含指定单个短链接的最新微博评论
 *access_token 采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 *url_short 需要取得分享数的短链接，需要URLencoded，最多不超过20个。
 *since_id 若指定此参数，则返回ID比since_id大的微博（即比since_id时间晚的微博），默认为0。
 *max_id 若指定此参数，则返回ID小于或等于max_id的微博，默认为0。
 *count 单页返回的记录条数，默认为50，最多不超过200。
 *page 返回结果的页码，默认为1。
 */
- (void)ShortUrlShareCommentsRequestWithParma:(RequestShortURLParma*)parma
{
    NSString *url = @"https://api.weibo.com/2/short_url/comment/comments.json";
    NSDictionary *parmas = [parma dictaryValue];
    [WBHttpRequest requestWithURL:url httpMethod:@"GET" params:parmas queue:nil withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error)
     {
         NSDictionary *dict = result;
         Url *url = [[Url alloc]initWithDict:dict];
         [self.delegate ShortUrlShareCommentRequestDidFinishedWithUrl:url error:error];
     }];

}
@end
