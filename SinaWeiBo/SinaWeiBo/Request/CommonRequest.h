//
//  CommonRequest.h
//  WBTest
//
//  Created by mjx on 15/1/30.
//  Copyright (c) 2015年 MJX. All rights reserved.
//  公共服务请求

#import <Foundation/Foundation.h>
#import "RequestCommonParma.h"
#import "WeiboSDK.h"
#import "Site.h"
#pragma mark --- 公共服务请求类代理 ---

@protocol CommonRequestDelegate <NSObject>

@optional
/**获取时区配置表后触发的代理方法*/
- (void)GetTimezoneRequestDidFinishedWithDictary:(NSDictionary*)timeZone error:(NSError*)error;
/**获取获取国家列表后触发的代理方法*/
- (void)GetCountryRequestDidFinishedWithCountrys:(NSArray*)countrys error:(NSError*)error;
/**获取省份列表后触发的代理方法*/
- (void)GetProvinceRequestDidFinishedWithProvinces:(NSArray*)provinces error:(NSError*)error;
/**获取城市列表后触发的代理方法*/
- (void)GetCityRequestDidFinishedWithCities:(NSArray*)cities error:(NSError*)error;



@end

#pragma mark --- 公共服务请求类正文 ---
@interface CommonRequest : NSObject
@property (nonatomic, strong) id<CommonRequestDelegate> delegate;
/**获取时区配置表
 *access_token 采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 *language 返回的语言版本，zh-cn：简体中文、zh-tw：繁体中文、english：英文，默认为zh-cn。
 */
- (void)GetTimezoneRequestWithParma:(RequestCommonParma*)parma;

/**获取国家列表
 *access_token 采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 *capital 国家的首字母，a-z，可为空代表返回全部，默认为全部。
 *language 返回的语言版本，zh-cn：简体中文、zh-tw：繁体中文、english：英文，默认为zh-cn。
 */
- (void)GetCountryRequestWithParma:(RequestCommonParma*)parma;

/**获取省份列表
 *(必)access_token 采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 *(必)country 国家的国家代码。
 *capital 省份的首字母，a-z，可为空代表返回全部，默认为全部。
 *language 返回的语言版本，zh-cn：简体中文、zh-tw：繁体中文、english：英文，默认为zh-cn。
 */
- (void)GetProvinceRequestWithParma:(RequestCommonParma*)parma;

/**获取城市列表
 *(必)access_token 采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 *(必)province 省份的省份代码。
 *capital 省份的首字母，a-z，可为空代表返回全部，默认为全部。
 *language 返回的语言版本，zh-cn：简体中文、zh-tw：繁体中文、english：英文，默认为zh-cn。
 */
- (void)GetCityRequestWithParma:(RequestCommonParma*)parma;


@end
