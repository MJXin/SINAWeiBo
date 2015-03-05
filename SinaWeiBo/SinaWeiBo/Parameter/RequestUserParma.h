//
//  RequestUserParma.h
//  WBTest
//
//  Created by mjx on 15/1/23.
//  Copyright (c) 2015年 MJX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+PropertyMethod.h"
@interface RequestUserParma : NSObject

/**采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
*/
@property (nonatomic, strong) NSString *access_token;

/**需要查询的用户ID
 *参数uid与screen_name二者必选其一，且只能选其一；
 */
@property (nonatomic, strong) NSString *uid;

/**需要查询的用户昵称 
 *参数uid与screen_name二者必选其一，且只能选其一；
 */
@property (nonatomic, strong) NSString *screen_name;

/**需要查询的个性化域名
 
 */
@property (nonatomic, strong) NSString *domain;

- (instancetype)initWithAccess_token:(NSString*)access_token;
/** 转换为字典
 */
- (NSDictionary*)dictaryValue;

@end
