//
//  RequestFavoritesParma.h
//  WBTest
//
//  Created by mjx on 15/1/27.
//  Copyright (c) 2015年 MJX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+PropertyMethod.h"
@interface RequestFavoritesParma : NSObject

/**采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。 */
@property (nonatomic, strong) NSString *access_token;
/**单页返回的记录条数，默认为50。 */
@property (nonatomic, strong) NSString *count;
/**返回结果的页码，默认为1。 */
@property (nonatomic, strong) NSString *page;
/**需要使用的收藏Id,就是微博的id*/
@property (nonatomic, strong) NSString *Id;
/**需要查询的标签ID,注意微博收藏的id是跟着名字走的,名字变了id也变*/
@property (nonatomic, strong) NSString *tid;

/**需要使用的多个微博的id的字符串形式,每个id之间要以逗号分隔*/
@property (nonatomic, strong) NSString *ids;
/**需要更新的标签内容，必须做URLencode，用半角逗号分隔，最多不超过2条。*/
@property (nonatomic, strong) NSString *tags;
/**需要将标签改成的内容，必须做URLencode。注意微博收藏的id是跟着名字走的,名字变了id也变*/
@property (nonatomic, strong) NSString *tag;

/** 使用access_token初始化
 */
- (instancetype)initWithAccess_token:(NSString*)access_token;

/** 转换为字典
 */
- (NSDictionary*)dictaryValue;
@end
