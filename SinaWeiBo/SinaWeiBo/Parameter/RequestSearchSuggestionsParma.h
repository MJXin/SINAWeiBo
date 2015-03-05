//
//  RequestSearchParma.h
//  WBTest
//
//  Created by mjx on 15/1/29.
//  Copyright (c) 2015年 MJX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+PropertyMethod.h"
@interface RequestSearchSuggestionsParma : NSObject
/**采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。*/
@property (nonatomic, strong) NSString *access_token;
/**搜索的关键字，必须做URLencoding。*/
@property (nonatomic, strong) NSString *q;
/**返回的记录条数，默认为10。*/
@property (nonatomic, strong) NSString *count;
/**联想类型，0：关注、1：粉丝。*/
@property (nonatomic, strong) NSString *type;

/** 使用access_token初始化
 */
- (instancetype)initWithAccess_token:(NSString*)access_token;

/** 转换为字典
 */
- (NSDictionary*)dictaryValue;

@end
