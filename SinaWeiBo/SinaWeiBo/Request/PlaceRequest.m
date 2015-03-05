//
//  PlaceRequest.m
//  WBTest
//
//  Created by mjx on 15/2/2.
//  Copyright (c) 2015年 MJX. All rights reserved.
//

#import "PlaceRequest.h"

@implementation PlaceRequest
/**获取地点详情
 *access_token 采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 *poiid 需要查询的POI地点ID。
 *base_app 是否只获取当前应用的数据。0为否（所有数据），1为是（仅当前应用），默认为0。
 */
- (void)PoisShowRequestByPoisIdWithParma:(RequestPlaceParma *)parma
{
    NSString *url = @"https://api.weibo.com/2/place/pois/show.json";
    NSDictionary *parmas = [parma dictaryValue];
    [WBHttpRequest requestWithURL:url httpMethod:@"GET" params:parmas queue:nil withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error)
     {
         Poi *poi = [[Poi alloc]initWithDict:result];
         [self.delegate PoisShowRequestByPoisIdDidFinishedWithPoi:poi error:error];
     }];
    
}

/**获取在某个地点签到的人的列表
 *access_token	false	string	采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 *poiid	true	string	需要查询的POI地点ID。
 *count	false	int	单页返回的记录条数，默认为20，最大为50。
 *page	false	int	返回结果的页码，默认为1。
 *base_app	false	int	是否只获取当前应用的数据。0为否（所有数据），1为是（仅当前应用），默认为0。
 */
- (void)PoisUserRequestByPoisIdWithParma:(RequestPlaceParma*)parma
{
    NSString *url = @"https://api.weibo.com/2/place/pois/users.json";
    NSDictionary *parmas = [parma dictaryValue];
    [WBHttpRequest requestWithURL:url httpMethod:@"GET" params:parmas queue:nil withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error)
     {
         NSDictionary *dict = result;
         
         NSArray *userArr = dict[@"users"];
         NSMutableArray *users = [NSMutableArray new];
         for (NSDictionary *userdict in userArr) {
             User *user = [[User alloc]initWithDict:userdict];
             [users addObject:user];
         }
         [self.delegate PoisUserRequestByPoisIdDidFinishedWithUsers:users error:error];
         
     }];
}

/**获取地点照片列表
 *access_token 采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 *poiid 需要查询的POI地点ID。
 *count 单页返回的记录条数，默认为20，最大为50。
 *page 返回结果的页码，默认为1。
 *sort 排序方式，0：按时间、1：按热门，默认为0，目前只支持0。
 *base_app 是否只获取当前应用的数据。0为否（所有数据），1为是（仅当前应用），默认为0。
 */
- (void)PoisPhotosRequestByPoisIdWithParma:(RequestPlaceParma*)parma
{
    NSDictionary *pramas = [parma dictaryValue];
    NSString *url = @"https://api.weibo.com/2/place/pois/photos.json";
    
    [WBHttpRequest requestWithURL:url httpMethod:@"GET" params:pramas queue:nil withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error)
     {
         
         NSDictionary *dict = result;
         StatuList *statuList = [[StatuList alloc]initWithDict:dict];
         NSArray *status = statuList.statuses;
         [self.delegate PoisPhotosRequestByPoisIdDidFinishedWithStatus:status error:error];
     }];
}

/**按省市查询地点
 *access_token 采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 *keyword 查询的关键词，必须进行URLencode。
 *city 城市代码，默认为全国搜索。
 *category 查询的分类代码，取值范围见：分类代码对应表。
 *page 返回结果的页码，默认为1。
 *count 单页返回的记录条数，默认为20，最大为50。
 */
- (void)PoisSearchRequestWithParma:(RequestPlaceParma*)parma
{
    NSString *url = @"https://api.weibo.com/2/place/pois/search.json";
    NSDictionary *parmas = [parma dictaryValue];
    [WBHttpRequest requestWithURL:url httpMethod:@"GET" params:parmas queue:nil withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error)
     {
         NSDictionary *dict = result;
         
         NSArray *poisArr = dict[@"pois"];
         NSMutableArray *pois = [NSMutableArray new];
         for (NSDictionary *poisdict in poisArr) {
             Poi *poi = [[Poi alloc]initWithDict:poisdict];
             [pois addObject:poi];
         }
         [self.delegate PoisSearchRequestDidFinishedWithPois:pois error:error];
         
     }];

}

/**获取地点分类
 *access_token 采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 *pid 父分类ID，默认为0。
 *flag 是否返回全部分类，0：只返回本级下的分类，1：返回全部分类，默认为0。
 */
- (void)PoisCategoryRequestWithParma:(RequestPlaceParma*)parma
{
    NSString *url = @"https://api.weibo.com/2/place/pois/category.json";
    NSDictionary *parmas = [parma dictaryValue];
    [WBHttpRequest requestWithURL:url httpMethod:@"GET" params:parmas queue:nil withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error)
     {
         NSArray *poisCategoryArr = result;
         NSMutableArray *poisCategorys = [NSMutableArray new];
         for (NSDictionary *poisCategorydict in poisCategoryArr) {
             PoisCategory *poisCategory = [[PoisCategory alloc]initWithDict:poisCategorydict];
             [poisCategorys addObject:poisCategory];
         }
         [self.delegate PoisCategoryRequestDidFinishedWithPoisCategory:poisCategorys error:error];
         
     }];

}

/**签到同时可以上传一张图片
 *access_token 采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 *poiid 需要签到的POI地点ID。
 *status 签到时发布的动态内容，必须做URLencode，内容不超过140个汉字。
 *pic 需要上传的图片，仅支持JPEG、GIF、PNG格式，图片大小小于5M。
 *public 是否同步到微博，1：是、0：否，默认为0。
 */
- (void)AddCheckinWriteWithParma:(RequestPlaceParma*)parma
{
    NSString *url = @"https://api.weibo.com/2/place/pois/add_checkin.json";
    NSDictionary *parmas = [parma dictaryValue];
    [WBHttpRequest requestWithURL:url httpMethod:@"POST" params:parmas queue:nil withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error)
     {
         NSDictionary *dict = result;
         Statu *statu = [[Statu alloc]initWithDict:dict];
         [self.delegate AddCheckinWriteDidFinishedWithStatu:statu error:error];
         
     }];
    
}

/**添加照片(好像和上面接口的作用一模一样)
 *返回都是参数错误,但是已经按照参数要求填了
 *access_token 采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 *poiid 需要签到的POI地点ID。
 *status 签到时发布的动态内容，必须做URLencode，内容不超过140个汉字。
 *pic 需要上传的图片，仅支持JPEG、GIF、PNG格式，图片大小小于5M。
 *public 是否同步到微博，1：是、0：否，默认为0。
 */
- (void)AddPhotoWriteWithParma:(RequestPlaceParma*)parma
{
    NSString *url = @"https://api.weibo.com/2/place/pois/add_photo.json";
    NSDictionary *parmas = [parma dictaryValue];
    [WBHttpRequest requestWithURL:url httpMethod:@"POST" params:parmas queue:nil withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error)
     {
         NSDictionary *dict = result;
         Statu *statu = [[Statu alloc]initWithDict:dict];
         [self.delegate AddPhotoWriteDidFinishedWithStatu:statu error:error];
     }];
 
}

/**添加点评
 *access_token 采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 *poiid 需要点评的POI地点ID。
 *status 点评时发布的动态内容，必须做URLencode，内容不超过140个汉字。
 *public 是否同步到微博，1：是、0：否，默认为0。
 */
- (void)AddTipWriteWithParma:(RequestPlaceParma*)parma
{
    NSString *url = @"https://api.weibo.com/2/place/pois/add_tip.json";
    NSDictionary *parmas = [parma dictaryValue];
    [WBHttpRequest requestWithURL:url httpMethod:@"POST" params:parmas queue:nil withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error)
     {
         NSDictionary *dict = result;
         Statu *statu = [[Statu alloc]initWithDict:dict];
         [self.delegate AddTipWriteWithDidFinishedWithStatu:statu error:error];
     }];
}

/**获取某个位置周边的动态
 *access_token 采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 *lat 纬度。有效范围：-90.0到+90.0，+表示北纬。
 *long 经度。有效范围：-180.0到+180.0，+表示东经。
 *range 搜索范围，单位米，默认2000米，最大11132米。
 *starttime 开始时间，Unix时间戳。
 *endtime 结束时间，Unix时间戳。
 *sort 排序方式。默认为0，按时间排序；为1时按与中心点距离进行排序。
 *count 单页返回的记录条数，最大为50，默认为20。
 *page 返回结果的页码，默认为1。
 *base_app 是否只获取当前应用的数据。0为否（所有数据），1为是（仅当前应用），默认为0。
 *offset 传入的经纬度是否是纠偏过，0：没纠偏、1：纠偏过，默认为0。
 */
- (void)Nearby_timelineRequestWithParma:(RequestPlaceParma*)parma
{
    NSDictionary *pramas = [parma dictaryValue];
    NSString *url = @"https://api.weibo.com/2/place/nearby_timeline.json";
    
    [WBHttpRequest requestWithURL:url httpMethod:@"GET" params:pramas queue:nil withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error)
     {
         NSDictionary *dict = result;
         StatuList *statuList = [[StatuList alloc]initWithDict:dict];
         NSArray *status = statuList.statuses;
         
//         if (status && status.count!= 0) {
//             Statu *temp = status[status.count-1];
//             _max_id = temp.idstr;
//             temp = status[0];
//             _since_id = temp.idstr;
//             _url = url;
//             
//         }
         
         [self.delegate Nearby_timelineRequestDidFinishedWithStatuList:statuList ststus:status error:error];
     }
     ];
}

/**获取附近地点
 *access_token 采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 *lat 纬度，有效范围：-90.0到+90.0，+表示北纬。
 *long 经度，有效范围：-180.0到+180.0，+表示东经。
 *range 查询范围半径，默认为2000，最大为10000，单位米。
 *q 查询的关键词，必须进行URLencode。
 *category 查询的分类代码，取值范围见：分类代码对应表。
 *count 单页返回的记录条数，默认为20，最大为50。
 *page 返回结果的页码，默认为1。
 *sort 排序方式，0：按权重，1：按距离，3：按签到人数。默认为0。
 *offset 传入的经纬度是否是纠偏过，0：没纠偏、1：纠偏过，默认为0。
 */
- (void)PoisRequestByNearbyWithParma:(RequestPlaceParma*)parma
{
    NSString *url = @"https://api.weibo.com/2/place/nearby/pois.json";
    NSDictionary *parmas = [parma dictaryValue];
    [WBHttpRequest requestWithURL:url httpMethod:@"GET" params:parmas queue:nil withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error)
     {
         NSDictionary *dict = result;
         
         NSArray *poisArr = dict[@"pois"];
         NSMutableArray *pois = [NSMutableArray new];
         for (NSDictionary *poisdict in poisArr) {
             Poi *poi = [[Poi alloc]initWithDict:poisdict];
             [pois addObject:poi];
         }
         [self.delegate PoisRequestByNearbyDidFinishedWithPois:pois error:error];
         
     }];

}

/**获取附近发位置微博的人
 *access_token 采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 *lat 纬度。有效范围：-90.0到+90.0，+表示北纬。
 *long 经度。有效范围：-180.0到+180.0，+表示东经。
 *range 搜索范围，单位米，默认2000米，最大11132米。
 *starttime 开始时间，Unix时间戳。
 *endtime 结束时间，Unix时间戳。
 *sort 排序方式。默认为0，按时间排序；为1时按与中心点距离进行排序。
 *count 单页返回的记录条数，最大为50，默认为20。
 *page 返回结果的页码，默认为1。
 *base_app 是否只获取当前应用的数据。0为否（所有数据），1为是（仅当前应用），默认为0。
 *offset 传入的经纬度是否是纠偏过，0：没纠偏、1：纠偏过，默认为0。
 */
- (void)NearbyUsersRequestWithParma:(RequestPlaceParma*)parma
{
    NSString *url = @"https://api.weibo.com/2/place/nearby/users.json";
    NSDictionary *parmas = [parma dictaryValue];
    [WBHttpRequest requestWithURL:url httpMethod:@"GET" params:parmas queue:nil withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error)
     {
         NSDictionary *dict = result;
         
         NSArray *userArr = dict[@"users"];
         NSMutableArray *users = [NSMutableArray new];
         for (NSDictionary *userdict in userArr) {
             User *user = [[User alloc]initWithDict:userdict];
             [users addObject:user];
         }
         [self.delegate NearbyUsersRequestDidFinishedWithUsers:users error:error];
     }];
}

/**获取附近照片
 *access_token 采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 *lat 纬度。有效范围：-90.0到+90.0，+表示北纬。
 *long 经度。有效范围：-180.0到+180.0，+表示东经。
 *range 搜索范围，单位米，默认2000米，最大11132米。
 *starttime 开始时间，Unix时间戳。
 *endtime 结束时间，Unix时间戳。
 *sort 排序方式。默认为0，按时间排序；为1时按与中心点距离进行排序。
 *count 单页返回的记录条数，最大为50，默认为20。
 *page 返回结果的页码，默认为1。
 *base_app 是否只获取当前应用的数据。0为否（所有数据），1为是（仅当前应用），默认为0。
 *offset 传入的经纬度是否是纠偏过，0：没纠偏、1：纠偏过，默认为0。
 */
- (void)NearbyphotosRequestWithParma:(RequestPlaceParma*)parma
{
    NSDictionary *pramas = [parma dictaryValue];
    NSString *url = @"https://api.weibo.com/2/place/nearby/photos.json";
    
    [WBHttpRequest requestWithURL:url httpMethod:@"GET" params:pramas queue:nil withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error)
     {
         
         NSDictionary *dict = result;
         StatuList *statuList = [[StatuList alloc]initWithDict:dict];
         NSArray *status = statuList.statuses;
         [self.delegate NearbyphotosRequestDidFinishedWithStatus:status error:error];
     }];

}


@end
