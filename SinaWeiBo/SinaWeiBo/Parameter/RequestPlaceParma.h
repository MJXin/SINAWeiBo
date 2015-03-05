//
//  RequestPlaceParma.h
//  WBTest
//
//  Created by mjx on 15/2/2.
//  Copyright (c) 2015年 MJX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+PropertyMethod.h"
@interface RequestPlaceParma : NSObject

/**采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。*/
@property (nonatomic, strong) NSString *access_token;
/**需要查询的POI点ID */
@property (nonatomic, strong) NSString *poiid;
/**是否只获取当前应用的数据。0为否（所有数据），1为是（仅当前应用），默认为0。 */
@property (nonatomic, strong) NSString *base_app;

/**单页返回的记录条数，默认为20，最大为50。 */
@property (nonatomic, strong) NSString *count;
/**返回结果的页码，默认为1。 */
@property (nonatomic, strong) NSString *page;
/**查询的关键词，必须进行URLencode。*/
@property (nonatomic, strong) NSString *keyword;
/**城市代码，默认为全国搜索*/
@property (nonatomic, strong) NSString *city;
/**查询的分类代码，取值范围见：分类代码对应表*/
@property (nonatomic, strong) NSString *category;
/**查询的关键词，必须进行URLencode。*/
@property (nonatomic, strong) NSString *q;
/**要发布的签到(点评,微博)*/
@property (nonatomic, strong) NSString *status;
/**要上传的图片*/
@property (nonatomic, strong) NSString *pic;
/**是否同步到微博*/
@property (nonatomic, strong) NSString *Public;

/**纬度。有效范围：-90.0到+90.0，+表示北纬。*/
@property (nonatomic, strong) NSString *lat;
/**经度。有效范围：-180.0到+180.0，+表示东经。*/
@property (nonatomic, strong) NSString *Long;
/**搜索范围，单位米，默认2000米，最大11132米。*/
@property (nonatomic, strong) NSString *range;
/**开始时间，Unix时间戳。*/
@property (nonatomic, strong) NSString *starttime;
/**结束时间，Unix时间戳*/
@property (nonatomic, strong) NSString *endtime;
/**排序方式。默认为0，按时间排序；为1时按与中心点距离进行排序*/
@property (nonatomic, strong) NSString *sort;
/**传入的经纬度是否是纠偏过，0：没纠偏、1：纠偏过，默认为0。*/
@property (nonatomic, strong) NSString *offset;

/** 使用access_token初始化
 */
- (instancetype)initWithAccess_token:(NSString*)access_token;

/** 转换为字典
 */
- (NSDictionary*)dictaryValue;
@end
