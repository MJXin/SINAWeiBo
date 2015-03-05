//
//  StatuRequest.h
//  WBTest
//
//  Created by mjx on 15/1/19.
//  Copyright (c) 2015年 MJX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Statu.h"
#import "RequestStatuParma.h"
#import "StatuList.h"
#import "Emotions.h"
#pragma mark --- StatuRequest类协议 ---
@protocol StatuRequestDelegate <NSObject>

@optional
#pragma mark -- 读取方法代理 --
/**完成Home_timeline请求调用的方法,代理可以通过参数ststus获得微博数据
 *使用前先对error进行判断
 */
- (void)didFinishedHome_timelineDataRequestWithStatuList:(StatuList*)statulist ststus:(NSArray*)status error:(NSError*)error;
/**完成Friends_timeline请求调用的方法,代理可以通过参数ststus获取微博数据
 *使用前先对error进行判断
 */
- (void)didFinishedFriends_timelineDataRequestWithStatuList:(StatuList*)statulist ststus:(NSArray*)status error:(NSError*)error;

/**完成Friends_timelineId请求调用的方法,代理可以通过参数ststusId获取微博Id
 *使用前先对error进行判断
 */
- (void)didFinishedFriends_timelineIdDataRequestWithStatuList:(StatuList*)statulist ststusId:(NSArray*)statusId error:(NSError*)error;


/**完成Public_timeline请求调用的方法,代理可以通过参数ststus获取微博数据
 *使用前先对error进行判断
 */
- (void)didFinishedPublic_timelineDataRequestWithStatuList:(StatuList *)statulist ststus:(NSArray *)status error:(NSError*)error;

/**完成User_timeline请求调用的方法,代理可以通过参数ststus获取微博数据
 *使用前先对error进行判断
 */
- (void)didFinishedUser_timelineDataRequestWithStatuList:(StatuList *)statulist ststus:(NSArray *)status error:(NSError*)error;

/**完成User_timelineId请求调用的方法,代理可以通过参数ststusId获取微博Id
 *使用前先对error进行判断
 */
- (void)didFinishedUser_timelineIdDataRequestWithStatuList:(StatuList *)statulist ststusId:(NSArray *)statusId error:(NSError*)error;

/**完成Mentions请求调用的方法,代理可以通过参数ststus获取微博数据
 *使用前先对error进行判断
 */
- (void)didFinishedMentionsDataRequestWithStatuList:(StatuList *)statulist ststus:(NSArray *)status error:(NSError*)error;

/**完成MentionsId请求调用的方法,代理可以通过参数ststus获取微博Id
 *使用前先对error进行判断
 */
- (void)didFinishedMentionsIdDataRequestWithStatuList:(StatuList *)statulist ststusId:(NSArray *)statusId error:(NSError*)error;


/**完成Bilateral_time请求调用的方法,代理可以通过参数ststus获取微博数据
 *使用前先对error进行判断
 */
- (void)didFinishedBilateral_timelineDataRequestWithStatuList:(StatuList *)statulist ststus:(NSArray *)status error:(NSError*)error;

/**完成Repost_timeline获取指定微博的转发微博列表,代理可以通过参数ststus获取微博数据
 *使用前先对error进行判断
 */
- (void)didFinishedRepost_timelineDataRequestWithStatuList:(StatuList *)statulist ststus:(NSArray *)status error:(NSError *)error;

/**完成Repost_timeline获取指定微博的转发微博列表,代理可以通过参数ststus获取微博数据
 *使用前先对error进行判断
 */
- (void)didFinishedRepost_timelineIdDataRequestWithStatuList:(StatuList *)statulist ststusId:(NSArray *)statusId error:(NSError *)error;

/**完成Show根据微博ID获取单条微博内容
 */
- (void)didFinishedShowStatuWithStatu:(Statu *)statu error:(NSError *)error;

/**完成Emotions请求,代理可通过emotions获取图片*/
- (void)didFinishedEmotionsRequestWithEmotions:(NSArray*)emotions;

/**完成通过地点请求微博触发的代理*/
- (void)didFinishedPoi_timelineDataRequestWithStatuList:(StatuList *)statulist ststus:(NSArray *)status error:(NSError *)error;

/**完成获取某个用户的照片列表触发的代理方法,代理需要从statu中获取照片链接*/
- (void)didFinishedUserPhotoDataRequestWithStstus:(NSArray *)status error:(NSError *)error;

#pragma mark -- 写入代理 --
/**完成转发请求,代理可以通过error确认*/
- (void)didfinishedRepostWithError:(NSError*)error;

/**完成删除请求,代理可以通过error确认*/
- (void)didfinishedDestroyWithError:(NSError*)error;

/*完成发微博请求,代理可以通过error确认*/
- (void)didfinishedUpdateWithError:(NSError*)error;

/*完成发带图片的微博请求,代理可以通过error确认*/
- (void)didfinishedUploadWithError:(NSError*)error;

#pragma mark -- 刷新代理 --
- (void)didfinishedRefreshNewDataWithStatuList:(StatuList *)statulist ststus:(NSArray *)status error:(NSError *)error;
- (void)didfinishedRefreshNextPageDataWithStatuList:(StatuList *)statulist ststus:(NSArray *)status error:(NSError *)error;
-(void)didfinishedHaveNewDataWithWithStatuList:(StatuList *)statulist ststus:(NSArray *)status error:(NSError *)error;
@end

#pragma mark --- StatuRequest类正文 ---
@interface StatuRequest : NSObject
@property(nonatomic,strong)Statu *statu;
@property(nonatomic,strong)NSArray *status;
@property(nonatomic,strong)id<StatuRequestDelegate> delegate;

#pragma mark -- 读取方法 --
/**(不建议使用)获取当前登录用户及其所关注用户的最新微博
 */
- (void)Home_timelineDataRequestWithPramas:(RequestStatuParma*)prama;

/**(建议使用)获取当前登录用户及其所关注用户的最新微博
 */
- (void)Friends_timelineDataRequestWithPramas:(RequestStatuParma*)prama;

/**获取当前登录用户及其所关注用户的最新微博的ID
 *注意获取的只是ID
 */
- (void)Friends_timelineIdDataRequestWithPramas:(RequestStatuParma*)prama;


/**获取最新公共微博,返回结果非完全实时
 */
- (void)Public_timelineDataRequestWithPramas:(RequestStatuParma*)prama;


/**获取某个用户最新发表的微博列表
 *获取自己的微博，参数uid与screen_name可以不填，则自动获取当前登录用户的微博；
 *指定获取他人的微博，参数uid与screen_name二者必选其一，且只能选其一；
 */
- (void)User_timelineDataRequestWithPramas:(RequestStatuParma*)prama;

/**获取用户发布的微博的ID
 *注意只是ID
 */
- (void)User_timelineIdDataRequestWithPramas:(RequestStatuParma*)prama;

/**获取最新的提到登录用户的微博列表，即@我的微博
 */
- (void)MentionsDataRequestWithPramas:(RequestStatuParma*)prama;

/**获取最新的提到登录用户的微博Id，即@我的微博ID
 */
- (void)MentionsIdDataRequestWithPramas:(RequestStatuParma*)prama;

/**获取双向关注用户的最新微博
 */
- (void)Bilateral_timelineDataRequestWithPramas:(RequestStatuParma*)prama;

/**获取一条原创微博的最新转发微博
 *注意必填参数status_Id
 */
- (void)Repost_timelineDataRequestWithPramas:(RequestStatuParma*)prama;

/**获取一条原创微博的最新转发微博的ID
 *注意必填参数status_Id
 */
- (void)Repost_timelineIdDataRequestWithPramas:(RequestStatuParma*)prama;

/**根据微博ID获取单条微博内容
 *必须填参数status_Id
 */
- (void)ShowStatuWithPramas:(RequestStatuParma*)prama;

/**获取微博官方表情的详细信息
 *参数type是表情类别face:普通表情 ani:魔法表情 cartoon:动漫表情:默认为face。
 *参数language是语言类别,cnname:简体 twname:繁体默认为cnname。
 */
- (void)EmotionsRequestWithPramas:(RequestStatuParma*)prama;


/**获取某个地点的动态(微博)
 *access_token 采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 *poiid 需要查询的POI点ID。
 *since_id 若指定此参数，则返回ID比since_id大的微博（即比since_id时间晚的微博），默认为0。
 *max_id 若指定此参数，则返回ID小于或等于max_id的微博，默认为0。
 *count 单页返回的记录条数，最大为50，默认为20。
 *page 返回结果的页码，默认为1。
 *base_app 是否只获取当前应用的数据。0为否（所有数据），1为是（仅当前应用），默认为0。
 */
- (void)Poi_timelineDataRequestWithPramas:(RequestStatuParma*)prama;

/**获取某个用户的照片列表
 *access_token	false	string	采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 *uid	true	int64	需要查询的用户ID。
 *count	false	int	单页返回的记录条数，默认为20，最大为50。
 *page	false	int	返回结果的页码，默认为1。
 *base_app	false	int	是否只获取当前应用的数据。0为否（所有数据），1为是（仅当前应用），默认为0。
 */
- (void)UserPhotoDataRequestWithPramas:(RequestStatuParma*)prama;

#pragma mark -- 写入方法 --

/**转发一条微博
 *(必)id要转发的微博ID。
 *(选)status添加的转发文本不填则默认为“转发微博”。
 *(选)is_comment是否在转发的同时发表评论，0：否、1：评论给当前微博、2：评论给原微博、3：都评论默认为0 。
 *(选)rip开发者上报的操作用户真实IP，形如：211.156.0.1。
 */
- (void)RepostWriteWithPramas:(RequestStatuParma*)prama;

/**删除一条微博
 *(必)id 删除微博的id
 */
- (void)DestroyWriteWithPramas:(RequestStatuParma*)prama;

/**发布一条新微博(注这是纯文字发表)
 *status 要发布的微博文本内容，必须做URLencode，内容不超过140个汉字。
 visible 微博的可见性，0：所有人能看，1：仅自己可见，2：密友可见，3：指定分组可见，默认为0。
 list_id 微博的保护投递指定分组ID，只有当visible参数为3时生效且必选。
 lat 纬度，有效范围：-90.0到+90.0，+表示北纬，默认为0.0。
 long 经度，有效范围：-180.0到+180.0，+表示东经，默认为0.0。
 annotations 元数据，主要是为了方便第三方应用记录一些适合于自己使用的信息，每条微博可以包含一个或者多个元数据，必须以json字串的形式提交，字串长度不超过512个字符，具体内容可以自定。
 rip 开发者上报的操作用户真实IP，形如：211.156.0.1。
 */
- (void)UpdateWriteWithPramas:(RequestStatuParma*)prama;


/**发布一条带图片的微博(这是带图片的微博)
 *status 要发布的微博文本内容，必须做URLencode，内容不超过140个汉字。
 pic 要上传的图片，仅支持JPEG、GIF、PNG格式，图片大小小于5M。
 visible 微博的可见性，0：所有人能看，1：仅自己可见，2：密友可见，3：指定分组可见，默认为0。
 list_id 微博的保护投递指定分组ID，只有当visible参数为3时生效且必选。
 lat 纬度，有效范围：-90.0到+90.0，+表示北纬，默认为0.0。
 long 经度，有效范围：-180.0到+180.0，+表示东经，默认为0.0。
 annotations 元数据，主要是为了方便第三方应用记录一些适合于自己使用的信息，每条微博可以包含一个或者多个元数据，必须以json字串的形式提交，字串长度不超过512个字符，具体内容可以自定。
 rip 开发者上报的操作用户真实IP，形如：211.156.0.1。
 */
- (void)UploadWriteWithPramas:(RequestStatuParma*)prama;


#pragma mark -- 刷新方法 -- 
//刷新方法目前未实现微博ID请求的刷新,应该不会用到
#warning -- 覆盖式的刷新方式,不确定是否有bug,例如有数据组A和B,目前是A数据组,但是应用跳到B组数据后会把记录A组的最大最小Id覆盖.若是从A到B再到A时A的数据是完全重新加载就没有问题.如果A跳到B跳回A,A用的是以前的数据需要以前的id进行更新就会出错.

/**若指定此参数，则返回ID比since_id大的微博（即比since_id时间晚的微博），默认为0
 */
@property (nonatomic, strong) NSString *since_id;

/**若指定此参数，则返回ID小于或等于max_id的微博，默认为0
 */
@property (nonatomic, strong, readonly) NSString *max_id;

/**本次请求的数据组所用的url
 */
@property (nonatomic ,strong, readonly)NSString *url;

/**更新新收到的信息(就是屏幕最上面的下拉刷新,就是在上次请求后才更新的内容)
 *如果是请求下一页的内容不要用这个
 */
- (void)RefreshNewDataWithPramas:(RequestStatuParma*)parma;

/**加载下一页的信息(就是拉到屏幕最下面的加载下一页内容)
 *如果请求最新消息不要用这个方法
 */
- (void)RefreshNextPageDataWithPramas:(RequestStatuParma *)parma;

/**查看是否有新消息
 */
-(void)HaveNewDataWithPramas:(RequestStatuParma *)aParma;


#warning -- 非覆盖式刷新方法,既分别单独记录每个不同组的请求最大最小id,但是这样的弊端是方法会很多.目前不用
/*
- (void)Home_timelineRefreshNewDataWithPramas:(RequestStatuParma*)parma;
- (void)Home_timelineRefreshNextPageDataWithPramas:(RequestStatuParma*)parma;

- (void)Friends_timelineRefreshNewDataWithPramas:(RequestStatuParma*)parma;
- (void)Friends_timelineRefreshNextPageDataWithPramas:(RequestStatuParma*)parma;


- (void)Public_timelineRefreshNewDataWithPramas:(RequestStatuParma*)parma;
- (void)Public_timelineRefreshNextPageDataWithPramas:(RequestStatuParma*)parma;

- (void)User_timelineRefreshNewDataWithPramas:(RequestStatuParma*)parma;
- (void)User_timelineRefreshNextPageDataWithPramas:(RequestStatuParma*)parma;

- (void)Bilateral_timelineRefreshNewDataWithPramas:(RequestStatuParma*)parma;
- (void)Bilateral_timelineRefreshNextPageDataWithPramas:(RequestStatuParma*)parma;

- (void)Repost_timelineRefreshNewDataWithPramas:(RequestStatuParma*)parma;
- (void)Repost_timelineRefreshNextPageDataWithPramas:(RequestStatuParma*)parma;
*/



@end
