//
//  StatuParma.h
//  WBTest
//
//  Created by mjx on 15/1/20.
//  Copyright (c) 2015年 MJX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RequestStatuParma : NSObject
/**采用OAuth授权方式不需要此参数，其他授权方式为必填参数，数值为应用的AppKey。*/
@property (nonatomic, strong) NSString *source;
/**采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。 */
@property (nonatomic, strong) NSString *access_token;
/**若指定此参数，则返回ID比since_id大的微博（即比since_id时间晚的微博），默认为0 */
@property (nonatomic, strong) NSString *since_id;

/**需要查询的POI点ID */
@property (nonatomic, strong) NSString *poiid;

/**需要查询的用户ID 
 *注:这个参数只在请求用户微博时候需要,平时不要填
 *获取自己的微博，参数uid与screen_name可以不填，则自动获取当前登录用户的微博；
 *指定获取他人的微博，参数uid与screen_name二者必选其一，且只能选其一；
 */
@property (nonatomic, strong) NSString *uid;

/*
 *需要查询的用户昵称
 *注:这个参数只在需要用户id时候输入其他时候不要有
 *获取自己的微博，参数uid与screen_name可以不填，则自动获取当前登录用户的微博；
 *指定获取他人的微博，参数uid与screen_name二者必选其一，且只能选其一；
 */
@property (nonatomic, strong) NSString *screen_name;

/**若指定此参数，则返回ID小于或等于max_id的微博，默认为0。 */
@property (nonatomic, strong) NSString *max_id;
/**单页返回的记录条数，最大不超过100，默认为20。 */
@property (nonatomic, strong) NSString *count;
/**返回结果的页码，默认为1。 */
@property (nonatomic, strong) NSString *page;
/**是否只获取当前应用的数据。0为否（所有数据），1为是（仅当前应用），默认为0。 */
@property (nonatomic, strong) NSString *base_app;
/**过滤类型ID，0：全部、1：原创、2：图片、3：视频、4：音乐，默认为0。 */
@property (nonatomic, strong) NSString *feature;
/**(不要用!!)返回值中user字段开关，0：返回完整user字段、1：user字段仅返回user_id，默认为0。 */
@property (nonatomic, strong) NSString *trim_user;
/**作者筛选类型，0：全部、1：我关注的人、2：陌生人，默认为0。
 *这个参数只在请求所有转发这条微博的微博时候需要
 */
@property (nonatomic, strong) NSString *filter_by_author;

/**需要查询微博的Id
 *这个参数只在请求需要用到微博id的时候需要
 *并且是必填
 */
@property (nonatomic, strong) NSString *Id;

/**用于请求表情类型
 *只有在请求表情时候需要
 */
@property (nonatomic, strong) NSString *type;

/**用于请求图片时设置语言类型
 */
@property (nonatomic, strong) NSString *language;

/**添加的转发文本，必须做URLencode，内容不超过140个汉字，不填则默认为“转发微博”。
 */
@property (nonatomic, strong) NSString *status;

/**是否在转发的同时发表评论，0：否、1：评论给当前微博、2：评论给原微博、3：都评论，默认为0 。
 */
@property (nonatomic, strong) NSString *is_comment;

/**开发者上报的操作用户真实IP，形如：211.156.0.1。
 */
@property (nonatomic, strong) NSString *rip;

#pragma mark -- 写入微博参数 --

/**微博的可见性，0：所有人能看，1：仅自己可见，2：密友可见，3：指定分组可见，默认为0。 */
@property (nonatomic, strong) NSString *visible;
/**微博的保护投递指定分组ID，只有当visible参数为3时生效且必选。 */
@property (nonatomic, strong) NSString *list_id;
/**纬度，有效范围：-90.0到+90.0，+表示北纬，默认为0.0。 */
@property (nonatomic, strong) NSString *lat;
/**经度，有效范围：-180.0到+180.0，+表示东经，默认为0.0。 */
@property (nonatomic, strong) NSString *Long;
/**元数据，主要是为了方便第三方应用记录一些适合于自己使用的信息 */
@property (nonatomic, strong) NSString *annotations;
/**要上传的图片，仅支持JPEG、GIF、PNG格式，图片大小小于5M。*/
@property (nonatomic, strong) NSData *pic;





/** 使用access_token初始化
 */
- (instancetype)initWithAccess_token:(NSString*)access_token;

/**使用字典初始化
 */
- (instancetype)initWithDict:(NSDictionary*)dict;
 
/** 转换为字典
 */
- (NSDictionary*)dictaryValue;
@end
