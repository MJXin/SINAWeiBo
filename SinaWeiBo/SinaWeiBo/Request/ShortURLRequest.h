//
//  ShortURLRequest.h
//  WBTest
//
//  Created by mjx on 15/1/30.
//  Copyright (c) 2015年 MJX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RequestShortURLParma.h"
#import "Url.h"
#import "WeiboSDK.h"
#pragma mark --- URL 请求类代理方法 ---
@protocol ShortURLRequestDelegate <NSObject>
/**完成长链转为短链触发的代理方法*/
- (void)ShortenURLRequestDidFinishedWithUrls:(NSArray*)urls error:(NSError*)error;
/**完成短链转为长链触发的代理方法*/
- (void)ExpandURLRequestDidFinishedWithUrls:(NSArray*)urls error:(NSError*)error;
/**完成获取短链接在微博上的微博分享数*/
- (void)ShortUrlShareStatusesCountRequestDidFinishedWithUrls:(NSArray*)urls error:(NSError*)error;
/**完成获取包含指定单个短链接的最新微博内容*/
- (void)ShortUrlShareStatusesRequestDidFinishedWithUrl:(Url*)urls error:(NSError*)error;
/**完成获取短链接在微博上的微博评论数*/
- (void)ShortUrlShareCommentCountRequestDidFinishedWithUrls:(NSArray*)urls error:(NSError*)error;
/**完成获取包含指定单个短链接的最新微博评论*/
- (void)ShortUrlShareCommentRequestDidFinishedWithUrl:(Url*)urls error:(NSError*)error;

@optional

@end
#pragma mark --- URL请求类正文 ---
@interface ShortURLRequest : NSObject
@property (nonatomic, strong) id<ShortURLRequestDelegate> delegate;
#pragma mark -- 转换接口 --

/**将一个或多个长链接转换成短链接
 *access_token 采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 *url_long 需要转换的长链接，需要URLencoded，最多不超过20个。
 *没弄明白多个怎么传进去
 */
- (void)ShortenURLRequestWithParma:(RequestShortURLParma*)parma;

/**将一个或多个短链接还原成原始的长链接
 *access_token 采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 *url_long 需要转换的长链接，需要URLencoded，最多不超过20个。
 *没弄明白多个怎么传进去
 */
- (void)ExpandURLRequestWithParma:(RequestShortURLParma*)parma;

#pragma mark -- 数据接口 -- 
/**获取短链接在微博上的微博分享数
 *access_token 采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 *url_short 需要取得分享数的短链接，需要URLencoded，最多不超过20个。
 */
- (void)ShortUrlShareStatusesCountRequestWithParma:(RequestShortURLParma*)parma;

/**获取包含指定单个短链接的最新微博内容
 *access_token 采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 *url_short 需要取得分享数的短链接，需要URLencoded，最多不超过20个。
 *since_id 若指定此参数，则返回ID比since_id大的微博（即比since_id时间晚的微博），默认为0。
 *max_id 若指定此参数，则返回ID小于或等于max_id的微博，默认为0。
 *count 单页返回的记录条数，默认为50，最多不超过200。
 *page 返回结果的页码，默认为1。
 */
- (void)ShortUrlShareStatusesRequestWithParma:(RequestShortURLParma*)parma;

/**获取短链接在微博上的微博评论数
 *access_token 采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 *url_short 需要取得分享数的短链接，需要URLencoded，最多不超过20个。
 */
- (void)ShortUrlShareCommentCountRequestWithParma:(RequestShortURLParma*)parma;

/**获取包含指定单个短链接的最新微博评论
 *access_token 采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 *url_short 需要取得分享数的短链接，需要URLencoded，最多不超过20个。
 *since_id 若指定此参数，则返回ID比since_id大的微博（即比since_id时间晚的微博），默认为0。
 *max_id 若指定此参数，则返回ID小于或等于max_id的微博，默认为0。
 *count 单页返回的记录条数，默认为50，最多不超过200。
 *page 返回结果的页码，默认为1。
 */
- (void)ShortUrlShareCommentsRequestWithParma:(RequestShortURLParma*)parma;



@end
