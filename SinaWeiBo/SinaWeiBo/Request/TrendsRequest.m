//
//  TrendsRequest.m
//  WBTest
//
//  Created by mjx on 15/1/28.
//  Copyright (c) 2015年 MJX. All rights reserved.
//

#import "TrendsRequest.h"

@implementation TrendsRequest

/**返回最近一小时内的热门话题
 *access_token 采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 *base_app 是否只获取当前应用的数据。0为否（所有数据），1为是（仅当前应用），默认为0。
 */
- (void)TrendsHourlyRequestWithParma:(RequestTrendsParma*)parma
{
    NSString *url = @"https://api.weibo.com/2/trends/hourly.json";
    NSDictionary *parmas = [parma dictaryValue];
    [WBHttpRequest requestWithURL:url httpMethod:@"GET" params:parmas queue:nil withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error)
     {
         NSDictionary *dict = result;
         TrendsList *trendList = [[TrendsList alloc]initWithDict:dict];
         NSArray *trends = trendList.trends;
         NSString *date = trendList.date;
         [self.delegate TrendsHourlyRequestDidfinishWithTrendsList:trendList Date:date Trends:trends error:error];

         
     }];
}

/**返回最近一天内的热门话题
 *access_token 采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 *base_app 是否只获取当前应用的数据。0为否（所有数据），1为是（仅当前应用），默认为0。
 */
- (void)TrendsDailyRequestWithParma:(RequestTrendsParma*)parma
{
    NSString *url = @"https://api.weibo.com/2/trends/daily.json";
    NSDictionary *parmas = [parma dictaryValue];
    [WBHttpRequest requestWithURL:url httpMethod:@"GET" params:parmas queue:nil withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error)
     {
         NSDictionary *dict = result;
         TrendsList *trendList = [[TrendsList alloc]initWithDict:dict];
         NSArray *trends = trendList.trends;
         NSString *date = trendList.date;
         [self.delegate TrendsDailyRequestDidfinishWithTrendsList:trendList Date:date Trends:trends error:error];

         
         
     }];
}

/**返回最近一周内的热门话题
 *access_token 采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 *base_app 是否只获取当前应用的数据。0为否（所有数据），1为是（仅当前应用），默认为0。
 */

- (void)TrendsWeeklyRequestWithParma:(RequestTrendsParma*)parma
{
    NSString *url = @"https://api.weibo.com/2/trends/weekly.json";
    NSDictionary *parmas = [parma dictaryValue];
    [WBHttpRequest requestWithURL:url httpMethod:@"GET" params:parmas queue:nil withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error)
     {
         NSDictionary *dict = result;
         TrendsList *trendList = [[TrendsList alloc]initWithDict:dict];
         NSArray *trends = trendList.trends;
         NSString *date = trendList.date;
         [self.delegate TrendsWeeklyRequestDidfinishWithTrendsList:trendList Date:date Trends:trends error:error];
     }];
}

@end
