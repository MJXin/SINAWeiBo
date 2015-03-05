//
//  TrendsRequest.h
//  WBTest
//
//  Created by mjx on 15/1/28.
//  Copyright (c) 2015年 MJX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TrendsList.h"
#import "RequestTrendsParma.h"
#import "WeiboSDK.h"
#pragma mark --- 话题请求协议 ---
@protocol TrendsRequestDelegate <NSObject>

@optional
/**完成请求一小时热门话题触发的代理方法*/
- (void)TrendsHourlyRequestDidfinishWithTrendsList:(TrendsList*)trendsList Date:(NSString*)date Trends:(NSArray*)trends error:(NSError*)error;

/**完成请求一天热门话题触发的代理方法*/
- (void)TrendsDailyRequestDidfinishWithTrendsList:(TrendsList*)trendsList Date:(NSString*)date Trends:(NSArray*)trends error:(NSError*)error;

/**完成请求一周热门话题触发的代理方法*/
- (void)TrendsWeeklyRequestDidfinishWithTrendsList:(TrendsList*)trendsList Date:(NSString*)date Trends:(NSArray*)trends error:(NSError*)error;

@end

#pragma mark --- 话题请求正文 ---
@interface TrendsRequest : NSObject

@property (nonatomic, strong) id<TrendsRequestDelegate> delegate;
/**返回最近一小时内的热门话题
 *access_token 采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 *base_app 是否只获取当前应用的数据。0为否（所有数据），1为是（仅当前应用），默认为0。
 */
- (void)TrendsHourlyRequestWithParma:(RequestTrendsParma*)parma;

/**返回最近一天内的热门话题
 *access_token 采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 *base_app 是否只获取当前应用的数据。0为否（所有数据），1为是（仅当前应用），默认为0。
 */

- (void)TrendsDailyRequestWithParma:(RequestTrendsParma*)parma;

/**返回最近一周内的热门话题
 *access_token 采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 *base_app 是否只获取当前应用的数据。0为否（所有数据），1为是（仅当前应用），默认为0。
 */

- (void)TrendsWeeklyRequestWithParma:(RequestTrendsParma*)parma;


@end
