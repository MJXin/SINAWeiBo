//
//  RequestFriendshipsParma.h
//  WBTest
//
//  Created by mjx on 15/1/23.
//  Copyright (c) 2015年 MJX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RequestFriendshipsParma : NSObject

/**采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 */
@property (nonatomic, strong) NSString *access_token;

/**需要查询的用户UID。 */
@property (nonatomic, strong) NSString *uid;
/**需要获取共同关注关系的用户UID，默认为当前登录用户。*/
@property (nonatomic, strong) NSString *suid;
/**需要查询的用户昵称。 */
@property (nonatomic, strong) NSString *screen_name;
/**单页返回的记录条数，默认为50，最大不超过200。 */
@property (nonatomic, strong) NSString *count;
/**返回结果的游标，下一页用返回值里的next_cursor，上一页用previous_cursor，默认为0。*/
@property (nonatomic, strong) NSString *cursor;
/**返回结果的页码，默认为1。*/
@property (nonatomic, strong) NSString *page;
/**返回值中user字段中的status字段开关，0：返回完整status字段、1：status字段仅返回status_id，默认为1。 */
@property (nonatomic, strong) NSString *trim_status;
/**排序类型，0：按关注时间最近排序，默认为0。*/
@property (nonatomic, strong) NSString *sort;
/**开发者上报的操作用户真实IP，形如：211.156.0.1。*/
@property (nonatomic, strong) NSString *rip;

/**源用户的UID。id和昵称只需要一个*/
@property (nonatomic, strong) NSString *source_id;
/**源用户的微博昵称 id和昵称只需要一个*/
@property (nonatomic, strong) NSString *source_screen_name;
/**目标用户的UID。id和昵称只需要一个*/
@property (nonatomic, strong) NSString *target_id;
/**目标用户的微博昵称。id和昵称只需要一个*/
@property (nonatomic, strong) NSString *target_screen_name;


/**以access_token初始化 */
-(instancetype)initWithAccess_token:(NSString*)access_token;
/**转化为字典*/
- (NSDictionary *)dictaryValue;
@end
