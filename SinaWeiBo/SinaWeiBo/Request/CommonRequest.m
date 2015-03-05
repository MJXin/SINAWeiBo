//
//  CommonRequest.m
//  WBTest
//
//  Created by mjx on 15/1/30.
//  Copyright (c) 2015年 MJX. All rights reserved.
//

#import "CommonRequest.h"

@implementation CommonRequest
/**获取时区配置表
 *access_token 采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 *language 返回的语言版本，zh-cn：简体中文、zh-tw：繁体中文、english：英文，默认为zh-cn。
 */
- (void)GetTimezoneRequestWithParma:(RequestCommonParma *)parma
{
    NSString *url = @"https://api.weibo.com/2/common/get_timezone.json";
    NSDictionary *parmas = [parma dictaryValue];
    [WBHttpRequest requestWithURL:url httpMethod:@"GET" params:parmas queue:nil withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error)
     {
         NSDictionary *timeZone = result;
         [self.delegate GetTimezoneRequestDidFinishedWithDictary:timeZone error:error];
     }];
}

/**获取国家列表
 *access_token 采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 *capital 国家的首字母，a-z，可为空代表返回全部，默认为全部。
 *language 返回的语言版本，zh-cn：简体中文、zh-tw：繁体中文、english：英文，默认为zh-cn。
 */
- (void)GetCountryRequestWithParma:(RequestCommonParma*)parma
{
    NSString *url = @"https://api.weibo.com/2/common/get_country.json";
    NSDictionary *parmas = [parma dictaryValue];
    [WBHttpRequest requestWithURL:url httpMethod:@"GET" params:parmas queue:nil withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error)
     {
         NSArray *countrysArr = result;
         NSMutableArray *countrys = [NSMutableArray new];
         for (NSDictionary *countryDict in countrysArr) {
             Site *country = [[Site alloc]initWithDict:countryDict];
             [countrys addObject:country];
         }
         [self.delegate GetCountryRequestDidFinishedWithCountrys:countrys error:error];
     }];
}

/**获取省份列表
 *(必)access_token 采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 *(必)country 国家的国家代码。
 *capital 省份的首字母，a-z，可为空代表返回全部，默认为全部。
 *language 返回的语言版本，zh-cn：简体中文、zh-tw：繁体中文、english：英文，默认为zh-cn。
 */
- (void)GetProvinceRequestWithParma:(RequestCommonParma*)parma
{
    NSString *url = @"https://api.weibo.com/2/common/get_province.json";
    NSDictionary *parmas = [parma dictaryValue];
    [WBHttpRequest requestWithURL:url httpMethod:@"GET" params:parmas queue:nil withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error)
     {
         NSArray *provinceArr = result;
         NSMutableArray *provinces = [NSMutableArray new];
         for (NSDictionary *provinceDict in provinceArr) {
             Site *province = [[Site alloc]initWithDict:provinceDict];
             [provinces addObject:province];
         }
         [self.delegate GetProvinceRequestDidFinishedWithProvinces:provinces error:error];
     }];
}

/**获取城市列表
 *(必)access_token 采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 *(必)province 省份的省份代码。
 *capital 省份的首字母，a-z，可为空代表返回全部，默认为全部。
 *language 返回的语言版本，zh-cn：简体中文、zh-tw：繁体中文、english：英文，默认为zh-cn。
 */
- (void)GetCityRequestWithParma:(RequestCommonParma*)parma
{
    NSString *url = @"https://api.weibo.com/2/common/get_city.json";
    NSDictionary *parmas = [parma dictaryValue];
    [WBHttpRequest requestWithURL:url httpMethod:@"GET" params:parmas queue:nil withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error)
     {
         NSArray *citysArr = result;
         NSMutableArray *cities = [NSMutableArray new];
         for (NSDictionary *cityDict in citysArr) {
             Site *city = [[Site alloc]initWithDict:cityDict];
             [cities addObject:city];
         }
         [self.delegate GetCityRequestDidFinishedWithCities:cities error:error];
     }];
}

@end
