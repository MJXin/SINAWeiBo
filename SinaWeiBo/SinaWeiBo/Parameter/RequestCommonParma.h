//
//  RequestCommonParma.h
//  WBTest
//
//  Created by mjx on 15/1/30.
//  Copyright (c) 2015年 MJX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+PropertyMethod.h"
@interface RequestCommonParma : NSObject
/**采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。*/
@property (nonatomic, strong) NSString *access_token;

/**返回的语言版本，zh-cn：简体中文、zh-tw：繁体中文、english：英文，默认为zh-cn。*/
@property (nonatomic, strong) NSString *language;

/**国家/省份/城市 的首字母(这个属性使用的时候注意在不同接口代表不同意义)，a-z，可为空代表返回全部，默认为全部。*/
@property (nonatomic, strong) NSString *capital;

/**国家的国家代码*/
@property (nonatomic, strong) NSString *country;

/**省份的省份代码。*/
@property (nonatomic, strong) NSString *province;

/** 使用access_token初始化
 */
- (instancetype)initWithAccess_token:(NSString*)access_token;

/** 转换为字典
 */
- (NSDictionary*)dictaryValue;


@end
