//
//  PlaceRequest.h
//  WBTest
//
//  Created by mjx on 15/2/2.
//  Copyright (c) 2015年 MJX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WeiboSDK.h"
#import "Statu.h"
#import "StatuList.h"
#import "RequestPlaceParma.h"
#import "Poi.h"
#import "User.h"
#import "PoisCategory.h"

#pragma mark --- 位置服务请求代理 ---
@protocol PlaceRequestDelegate <NSObject>

@optional
#pragma mark -- 地点读取接口代理方法 --
/**完成获取地点详情触发的代理方法*/
- (void)PoisShowRequestByPoisIdDidFinishedWithPoi:(Poi*)poi error:(NSError*)error;
/**完成获取在某个地点签到的人的列表触发的代理方法*/
- (void)PoisUserRequestByPoisIdDidFinishedWithUsers:(NSArray*)users error:(NSError*)error;
/**完成获取地点照片列表触发的代理方法*/
- (void)PoisPhotosRequestByPoisIdDidFinishedWithStatus:(NSArray*)status error:(NSError*)error;
/**完成按省市查询地点触发的代理方法*/
- (void)PoisSearchRequestDidFinishedWithPois:(NSArray*)pois error:(NSError*)error;
/**完成获取地点分类触发的代理方法*/
- (void)PoisCategoryRequestDidFinishedWithPoisCategory:(NSArray*)poisCategory error:(NSError*)error;
#pragma mark -- 地点写入接口代理方法 --
/**完成签到同时可以上传一张图片触发的代理方法*/
- (void)AddCheckinWriteDidFinishedWithStatu:(Statu*)statu error:(NSError*)error;
/**完成添加照片触发的代理方法*/
- (void)AddPhotoWriteDidFinishedWithStatu:(Statu*)statu error:(NSError*)error;
/**添加点评触发的代理方法*/
- (void)AddTipWriteWithDidFinishedWithStatu:(Statu*)statu error:(NSError*)error;
#pragma mark -- 附近读取接口代理方法 --

/**完成通过位置请求微博触发的代理*/
- (void)Nearby_timelineRequestDidFinishedWithStatuList:(StatuList *)statulist ststus:(NSArray *)status error:(NSError *)error;
/**完成通过地点请求微博触发的代理*/
- (void)didFinishedPoi_timelineDataRequestDidFinishedWithStatuList:(StatuList *)statulist ststus:(NSArray *)status error:(NSError *)error;

/**完成获取附近地点触发的代理方法*/
- (void)PoisRequestByNearbyDidFinishedWithPois:(NSArray*)pois error:(NSError*)error;
/**完成获取附近发位置微博的人触发的代理方法*/
- (void)NearbyUsersRequestDidFinishedWithUsers:(NSArray*)users error:(NSError*)error;
/**完成获取附近照片触发的代理方法*/
- (void)NearbyphotosRequestDidFinishedWithStatus:(NSArray*)status error:(NSError*)error;


@end

#pragma mark --- 位置服务请求正文 ---
@interface PlaceRequest : NSObject
@property (nonatomic, strong) id<PlaceRequestDelegate> delegate;
#pragma mark -- 地点读取接口 --

/**获取某个地点的动态(微博)
 *access_token 采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 *poiid 需要查询的POI点ID。
 *since_id 若指定此参数，则返回ID比since_id大的微博（即比since_id时间晚的微博），默认为0。
 *max_id 若指定此参数，则返回ID小于或等于max_id的微博，默认为0。
 *count 单页返回的记录条数，最大为50，默认为20。
 *page 返回结果的页码，默认为1。
 *base_app 是否只获取当前应用的数据。0为否（所有数据），1为是（仅当前应用），默认为0。
 */
- (void)Poi_timelineDataRequestWithPramas:(RequestPlaceParma*)prama;

/**获取地点详情
 *(必)access_token 采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 *(必)poiid 需要查询的POI地点ID。
 *base_app 是否只获取当前应用的数据。0为否（所有数据），1为是（仅当前应用），默认为0。
 */
- (void)PoisShowRequestByPoisIdWithParma:(RequestPlaceParma*)parma;

/**获取在某个地点签到的人的列表
 *(必)access_token 采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 *(必)poiid 需要查询的POI地点ID。
 *count	false	int	单页返回的记录条数，默认为20，最大为50。
 *page	false	int	返回结果的页码，默认为1。
 *base_app	false	int	是否只获取当前应用的数据。0为否（所有数据），1为是（仅当前应用），默认为0。
 */
- (void)PoisUserRequestByPoisIdWithParma:(RequestPlaceParma*)parma;

/**获取地点照片列表
 *(必)access_token 采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 *(必)poiid 需要查询的POI地点ID。
 *count 单页返回的记录条数，默认为20，最大为50。
 *page 返回结果的页码，默认为1。
 *sort 排序方式，0：按时间、1：按热门，默认为0，目前只支持0。
 *base_app 是否只获取当前应用的数据。0为否（所有数据），1为是（仅当前应用），默认为0。
 */
- (void)PoisPhotosRequestByPoisIdWithParma:(RequestPlaceParma*)parma;

/**按省市查询地点
 *(必)access_token 采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 *(必)keyword 查询的关键词，必须进行URLencode。
 *city 城市代码，默认为全国搜索。
 *category 查询的分类代码，取值范围见：分类代码对应表。
 *page 返回结果的页码，默认为1。
 *count 单页返回的记录条数，默认为20，最大为50。
 */
- (void)PoisSearchRequestWithParma:(RequestPlaceParma*)parma;


/**获取地点分类
 *access_token 采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 *pid 父分类ID，默认为0。
 *flag 是否返回全部分类，0：只返回本级下的分类，1：返回全部分类，默认为0。
 */
- (void)PoisCategoryRequestWithParma:(RequestPlaceParma*)parma;

#pragma mark -- 地点写入接口 --
/**签到同时可以上传一张图片
 *access_token 采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 *poiid 需要签到的POI地点ID。
 *status 签到时发布的动态内容，必须做URLencode，内容不超过140个汉字。
 *pic 需要上传的图片，仅支持JPEG、GIF、PNG格式，图片大小小于5M。
 *public 是否同步到微博，1：是、0：否，默认为0。
 */
- (void)AddCheckinWriteWithParma:(RequestPlaceParma*)parma;

/**添加照片(和上面接口的作用一模一样
 *access_token 采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 *poiid 需要签到的POI地点ID。
 *status 签到时发布的动态内容，必须做URLencode，内容不超过140个汉字。
 *pic 需要上传的图片，仅支持JPEG、GIF、PNG格式，图片大小小于5M。
 *public 是否同步到微博，1：是、0：否，默认为0。
 */
- (void)AddPhotoWriteWithParma:(RequestPlaceParma*)parma;

/**添加点评
 *access_token 采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 *poiid 需要点评的POI地点ID。
 *status 点评时发布的动态内容，必须做URLencode，内容不超过140个汉字。
 *public 是否同步到微博，1：是、0：否，默认为0。
 */
- (void)AddTipWriteWithParma:(RequestPlaceParma*)parma;
#pragma mark -- 附近读取接口 --

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
- (void)Nearby_timelineRequestWithParma:(RequestPlaceParma*)parma;

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
- (void)PoisRequestByNearbyWithParma:(RequestPlaceParma*)parma;

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
- (void)NearbyUsersRequestWithParma:(RequestPlaceParma*)parma;

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
- (void)NearbyphotosRequestWithParma:(RequestPlaceParma*)parma;

 
@end
