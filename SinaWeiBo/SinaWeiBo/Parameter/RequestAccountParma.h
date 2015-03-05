//
//  RequestAccountParma.h
//  WBTest
//
//  Created by mjx on 15/1/27.
//  Copyright (c) 2015年 MJX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+PropertyMethod.h"
@interface RequestAccountParma : NSObject
/**采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。 */
@property (nonatomic, strong) NSString *access_token;

/** 使用access_token初始化
 */
- (instancetype)initWithAccess_token:(NSString*)access_token;

/** 转换为字典
 */
- (NSDictionary*)dictaryValue;
@end
