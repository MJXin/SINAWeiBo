//
//  RequestShortURLParma.h
//  WBTest
//
//  Created by mjx on 15/1/30.
//  Copyright (c) 2015年 MJX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+PropertyMethod.h"
@interface RequestShortURLParma : NSObject

/**采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。*/
@property (nonatomic, strong) NSString *access_token;
/**需要转换的长链接，需要URLencoded，最多不超过20个。 多个url参数需要使用如下方式：url_long=aaa&url_long=bbb*/
@property (nonatomic, strong) NSString *url_long;
/**需要还原的短链接，需要URLencoded，最多不超过20个 。*/
@property (nonatomic, strong) NSString *url_short;
/**若指定此参数，则返回ID比since_id大的微博（即比since_id时间晚的微博），默认为0 */
@property (nonatomic, strong) NSString *since_id;
/**若指定此参数，则返回ID小于或等于max_id的微博，默认为0。 */
@property (nonatomic, strong) NSString *max_id;
/**单页返回的记录条数，最大不超过100，默认为20。 */
@property (nonatomic, strong) NSString *count;
/**返回结果的页码，默认为1。 */
@property (nonatomic, strong) NSString *page;


/** 使用access_token初始化
 */
- (instancetype)initWithAccess_token:(NSString*)access_token;

/** 转换为字典
 */
- (NSDictionary*)dictaryValue;
@end
