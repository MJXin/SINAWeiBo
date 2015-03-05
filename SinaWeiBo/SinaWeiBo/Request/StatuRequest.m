//
//  StatuRequest.m
//  WBTest
//
//  Created by mjx on 15/1/19.
//  Copyright (c) 2015年 MJX. All rights reserved.
//

#import "StatuRequest.h"
#import "WeiboSDK.h"
@implementation StatuRequest

#pragma mark -- 读取方法 --
/*
 *(不建议使用)获取当前登录用户及其所关注用户的最新微博
 */
- (void)Home_timelineDataRequestWithPramas:(RequestStatuParma *)prama
{
    NSDictionary *pramas = [prama dictaryValue];
    
    NSString *url =@"https://api.weibo.com/2/statuses/home_timeline.json";
    
    [WBHttpRequest requestWithURL:url httpMethod:@"GET" params:pramas queue:nil withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error)
     {
         NSDictionary *dict = result;
         StatuList *statuList = [[StatuList alloc]initWithDict:dict];
         NSArray *status = statuList.statuses;
         
         if (status && status.count!= 0) {
             Statu *temp = status[status.count-1];
             _max_id = temp.idstr;
             temp = status[0];
             _since_id = temp.idstr;
             _url = url;

         }
         
         
         [self.delegate didFinishedHome_timelineDataRequestWithStatuList:statuList ststus:status error:(NSError*)error];
     }
     ];
}

/*
 *(建议使用)获取当前登录用户及其所关注用户的最新微博
 */
- (void)Friends_timelineDataRequestWithPramas:(RequestStatuParma *)prama
{
    NSDictionary *pramas = [prama dictaryValue];
    NSString *url = @"https://api.weibo.com/2/statuses/friends_timeline.json";
    
    [WBHttpRequest requestWithURL:url httpMethod:@"GET" params:pramas queue:nil withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error)
     {
         NSDictionary *dict = result;
         StatuList *statuList = [[StatuList alloc]initWithDict:dict];
         NSArray *status = statuList.statuses;
         
         if (status && status.count!= 0) {
             Statu *temp = status[status.count-1];
             _max_id = temp.idstr;
             temp = status[0];
             _since_id = temp.idstr;
             _url = url;
             
         }
         
         [self.delegate didFinishedFriends_timelineDataRequestWithStatuList:statuList ststus:status error:(NSError*)error ];
     }
     ];
}

/*
 *获取当前登录用户及其所关注用户的最新微博的ID
 *注意获取的事ID
 */
- (void)Friends_timelineIdDataRequestWithPramas:(RequestStatuParma*)prama
{
    NSDictionary *pramas = [prama dictaryValue];
    NSString *url = @"https://api.weibo.com/2/statuses/friends_timeline/ids.json";
    
    [WBHttpRequest requestWithURL:url httpMethod:@"GET" params:pramas queue:nil withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error)
     {
         NSDictionary *dict = result;
         StatuList *statuList = [[StatuList alloc]initStatuesIdWithDict:dict];
         NSArray *statusID = statuList.statusesId;
         [self.delegate didFinishedFriends_timelineIdDataRequestWithStatuList:statuList ststusId:statusID error:error];
     }
     ];

}




/*
 *获取最新公共微博,返回结果非完全实时
 */
- (void)Public_timelineDataRequestWithPramas:(RequestStatuParma *)prama
{
    NSDictionary *pramas = [prama dictaryValue];
    NSString *url = @"https://api.weibo.com/2/statuses/public_timeline.json";
    [WBHttpRequest requestWithURL:url httpMethod:@"GET" params:pramas queue:nil withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error)
     {
         NSDictionary *dict = result;
         StatuList *statuList = [[StatuList alloc]initWithDict:dict];
         NSArray *status = statuList.statuses;
         
         if (status && status.count!= 0) {
             Statu *temp = status[status.count-1];
             _max_id = temp.idstr;
             temp = status[0];
             _since_id = temp.idstr;
             _url = url;
             
         }
         [self.delegate didFinishedPublic_timelineDataRequestWithStatuList:statuList ststus:status error:(NSError*)error];
     }
     ];
    
    
}

/*
 *获取某个用户最新发表的微博列表
 *获取自己的微博，参数uid与screen_name可以不填，则自动获取当前登录用户的微博；
 *指定获取他人的微博，参数uid与screen_name二者必选其一，且只能选其一；
 */
- (void)User_timelineDataRequestWithPramas:(RequestStatuParma *)prama
{
    NSDictionary *pramas = [prama dictaryValue];
    NSString *url =@"https://api.weibo.com/2/statuses/user_timeline.json";
    
    
    [WBHttpRequest requestWithURL:url httpMethod:@"GET" params:pramas queue:nil withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error)
     {
         NSDictionary *dict = result;
         StatuList *statuList = [[StatuList alloc]initWithDict:dict];
         NSArray *status = statuList.statuses;
         
         if (status && status.count!= 0) {
             Statu *temp = status[status.count-1];
             _max_id = temp.idstr;
             temp = status[0];
             _since_id = temp.idstr;
             _url = url;
             
         }
         [self.delegate didFinishedUser_timelineDataRequestWithStatuList:statuList ststus:status error:error];
     }
     ];
}

/*
 *获取某个用户最新发表的微博列表
 *获取的是Id
 *获取自己的微博，参数uid与screen_name可以不填，则自动获取当前登录用户的微博；
 *指定获取他人的微博，参数uid与screen_name二者必选其一，且只能选其一；
 */
- (void)User_timelineIdDataRequestWithPramas:(RequestStatuParma *)prama
{
    NSDictionary *pramas = [prama dictaryValue];
    NSString *url = @"https://api.weibo.com/2/statuses/user_timeline/ids.json";
    [WBHttpRequest requestWithURL:url httpMethod:@"GET" params:pramas queue:nil withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error)
     {
         NSDictionary *dict = result;
         StatuList *statuList = [[StatuList alloc]initStatuesIdWithDict:dict];
         NSArray *statusId = statuList.statusesId;
         [self.delegate didFinishedUser_timelineIdDataRequestWithStatuList:statuList ststusId:statusId error:error];
     }
     ];

}


/*
 *获取最新的提到登录用户的微博列表，即@我的微博
 */
-(void)MentionsDataRequestWithPramas:(RequestStatuParma *)prama
{
    NSDictionary *pramas = [prama dictaryValue];
    NSString *url = @"https://api.weibo.com/2/statuses/mentions.json";
    [WBHttpRequest requestWithURL:url httpMethod:@"GET" params:pramas queue:nil withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error)
     {
         NSDictionary *dict = result;
         StatuList *statuList = [[StatuList alloc]initWithDict:dict];
         NSArray *status = statuList.statuses;
         
         if (status && status.count!= 0) {
             Statu *temp = status[status.count-1];
             _max_id = temp.idstr;
             temp = status[0];
             _since_id = temp.idstr;
             _url = url;
             
         }
         
         [self.delegate didFinishedMentionsDataRequestWithStatuList:statuList ststus:status error:error];
     }
     ];
}

/*
 *获取最新的提到登录用户的微博Id，即@我的微博Id
 */
- (void)MentionsIdDataRequestWithPramas:(RequestStatuParma *)prama
{
    NSDictionary *pramas = [prama dictaryValue];
    NSString *url = @"https://api.weibo.com/2/statuses/mentions/ids.json";
    [WBHttpRequest requestWithURL:url httpMethod:@"GET" params:pramas queue:nil withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error)
     {
         NSDictionary *dict = result;
         StatuList *statuList = [[StatuList alloc]initStatuesIdWithDict:dict];
         NSArray *statusId = statuList.statusesId;
         [self.delegate didFinishedMentionsIdDataRequestWithStatuList:statuList ststusId:statusId error:error];
     }
     ];

}



/*
 *获取双向关注用户的最新微博
 */
-(void)Bilateral_timelineDataRequestWithPramas:(RequestStatuParma *)prama
{
    NSDictionary *pramas = [prama dictaryValue];
    NSString *url = @"https://api.weibo.com/2/statuses/bilateral_timeline.json";
    [WBHttpRequest requestWithURL:url httpMethod:@"GET" params:pramas queue:nil withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error)
     {
         NSDictionary *dict = result;
         StatuList *statuList = [[StatuList alloc]initWithDict:dict];
         NSArray *status = statuList.statuses;
         
         if (status && status.count!= 0) {
             Statu *temp = status[status.count-1];
             _max_id = temp.idstr;
             temp = status[0];
             _since_id = temp.idstr;
             _url = url;
             
         }
         
         [self.delegate didFinishedBilateral_timelineDataRequestWithStatuList:statuList ststus:status error:error];
     }
     ];
}

/**获取一条原创微博的最新转发微博
 */
- (void)Repost_timelineDataRequestWithPramas:(RequestStatuParma *)prama
{
    NSDictionary *pramas = [prama dictaryValue];
    NSString *url = @"https://api.weibo.com/2/statuses/repost_timeline.json";
    [WBHttpRequest requestWithURL:url httpMethod:@"GET" params:pramas queue:nil withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error)
     {
         
         NSDictionary *dict = result;
         if (dict.count == 0) {
             error = [NSError errorWithDomain:@"status_Id 错误" code:11111 userInfo:nil];
             [self.delegate didFinishedRepost_timelineDataRequestWithStatuList:nil ststus:nil error:error];
             return ;
         }

         //由于API的key与正常的不同,所以要调用专有方法处理这个key
         StatuList *statuList = [[StatuList alloc]initRepostsStatuesWithDict:dict];
         NSArray *status = statuList.statuses;
         
         if (status && status.count!= 0) {
             Statu *temp = status[status.count-1];
             _max_id = temp.idstr;
             temp = status[0];
             _since_id = temp.idstr;
             _url = url;
             
         }
         [self.delegate didFinishedRepost_timelineDataRequestWithStatuList:statuList ststus:status error:error];
     }
     ];

}

/**获取一条原创微博的最新转发微博的ID
 */
- (void)Repost_timelineIdDataRequestWithPramas:(RequestStatuParma *)prama
{
    NSDictionary *pramas = [prama dictaryValue];
    NSString *url = @"https://api.weibo.com/2/statuses/repost_timeline/ids.json";
    [WBHttpRequest requestWithURL:url httpMethod:@"GET" params:pramas queue:nil withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error)
     {
         NSDictionary *dict = result;
         if (dict.count == 0) {
             error = [NSError errorWithDomain:@"status_Id 错误" code:11111 userInfo:nil];
             [self.delegate didFinishedRepost_timelineIdDataRequestWithStatuList:nil ststusId:nil error:error];
             return ;
         }
         //由于API的key与正常的不同,所以要调用专有方法处理这个key
         StatuList *statuList = [[StatuList alloc]initRepostsStatuesIdWithDict:dict];
         NSArray *statusId = statuList.statusesId;
         [self.delegate didFinishedRepost_timelineIdDataRequestWithStatuList:statuList ststusId:statusId error:error];
     }
     ];
    
}

/**根据微博ID获取单条微博内容
 *必须填参数status_Id
 */
-(void)ShowStatuWithPramas:(RequestStatuParma *)prama
{
    NSDictionary *pramas = [prama dictaryValue];
    NSString *url =@"https://api.weibo.com/2/statuses/show.json";
    [WBHttpRequest requestWithURL:url httpMethod:@"GET" params:pramas queue:nil withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error)
     {
         NSDictionary *dict = result;
         Statu *statu = [[Statu alloc]initWithDict:dict];
         [self.delegate didFinishedShowStatuWithStatu:statu error:error];
     
     }
     ];

}


/**获取微博官方表情的详细信息
 *参数type是表情类别face:普通表情 ani:魔法表情 cartoon:动漫表情:默认为face。
 *参数language是语言类别,cnname:简体 twname:繁体默认为cnname。
 */
- (void)EmotionsRequestWithPramas:(RequestStatuParma *)prama
{
    NSDictionary *pramas = [prama dictaryValue];
    NSString *url = @"https://api.weibo.com/2/emotions.json";
    [WBHttpRequest requestWithURL:url httpMethod:@"GET" params:pramas queue:nil withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error)
     {
        
         NSArray *emotionsArr = result;
         NSMutableArray *emotions = [NSMutableArray new];
         for (NSDictionary *emotionDict in emotionsArr) {
             Emotions *emotion = [[Emotions alloc]initWithDict:emotionDict];
             [emotions addObject:emotion];
         }
         [self.delegate didFinishedEmotionsRequestWithEmotions:emotions];
         
     }
     ];
    
}

/**获取某个地点的动态
 *access_token 采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 *poiid 需要查询的POI点ID。
 *since_id 若指定此参数，则返回ID比since_id大的微博（即比since_id时间晚的微博），默认为0。
 *max_id 若指定此参数，则返回ID小于或等于max_id的微博，默认为0。
 *count 单页返回的记录条数，最大为50，默认为20。
 *page 返回结果的页码，默认为1。
 *base_app 是否只获取当前应用的数据。0为否（所有数据），1为是（仅当前应用），默认为0。
 */
- (void)Poi_timelineDataRequestWithPramas:(RequestStatuParma *)prama
{
    NSDictionary *pramas = [prama dictaryValue];
    NSString *url = @"https://api.weibo.com/2/place/poi_timeline.json";
    
    [WBHttpRequest requestWithURL:url httpMethod:@"GET" params:pramas queue:nil withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error)
     {
         NSDictionary *dict = result;
         StatuList *statuList = [[StatuList alloc]initWithDict:dict];
         NSArray *status = statuList.statuses;
         
         if (status && status.count!= 0) {
             Statu *temp = status[status.count-1];
             _max_id = temp.idstr;
             temp = status[0];
             _since_id = temp.idstr;
             _url = url;
             
         }
         
         [self.delegate didFinishedPoi_timelineDataRequestWithStatuList:statuList ststus:status error:error];
     }
     ];

}

/**获取某个用户的照片列表
 *access_token	false	string	采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 *uid	true	int64	需要查询的用户ID。
 *count	false	int	单页返回的记录条数，默认为20，最大为50。
 *page	false	int	返回结果的页码，默认为1。
 *base_app	false	int	是否只获取当前应用的数据。0为否（所有数据），1为是（仅当前应用），默认为0。
 */
- (void)UserPhotoDataRequestWithPramas:(RequestStatuParma*)prama
{
    NSDictionary *pramas = [prama dictaryValue];
    NSString *url = @"https://api.weibo.com/2/place/users/photos.json";
    
    [WBHttpRequest requestWithURL:url httpMethod:@"GET" params:pramas queue:nil withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error)
     {
        
         //NSLog(@"%@",result);
         NSArray *statusArr = result;
         NSMutableArray *status = [NSMutableArray new];
         for (NSDictionary *statuDict in statusArr) {
             Statu *statu = [[Statu alloc]initWithDict:statuDict];
             [status addObject:statu];
         }
         
         if (status && status.count!= 0) {
             Statu *temp = status[status.count-1];
             _max_id = temp.idstr;
             temp = status[0];
             _since_id = temp.idstr;
             _url = url;
             
         }
         [self.delegate didFinishedUserPhotoDataRequestWithStstus:status error:error];
     }
     ];

}




#pragma mark -- 写入方法 --
/**转发一条微博
 *(必)id要转发的微博ID。
 *(选)status添加的转发文本不填则默认为“转发微博”。
 *(选)is_comment是否在转发的同时发表评论，0：否、1：评论给当前微博、2：评论给原微博、3：都评论默认为0 。
 *(选)rip开发者上报的操作用户真实IP，形如：211.156.0.1。
 */

- (void)RepostWriteWithPramas:(RequestStatuParma *)prama
{
    NSDictionary *pramas = [prama dictaryValue];
    [WBHttpRequest requestWithURL:@"https://api.weibo.com/2/statuses/repost.json" httpMethod:@"POST" params:pramas queue:nil withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error)
     {
       
         [self.delegate didfinishedRepostWithError:error];
     }
     ];

    
}

/**删除一条微博
 *(必)id 删除微博的id
 */
- (void)DestroyWriteWithPramas:(RequestStatuParma *)prama
{
    NSDictionary *pramas = [prama dictaryValue];
    [WBHttpRequest requestWithURL:@"https://api.weibo.com/2/statuses/destroy.json" httpMethod:@"POST" params:pramas queue:nil withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error)
     {
         
         [self.delegate didfinishedDestroyWithError:error];
     }
     ];

}


/**发布一条新微博
 *status 要发布的微博文本内容，必须做URLencode，内容不超过140个汉字。
 visible 微博的可见性，0：所有人能看，1：仅自己可见，2：密友可见，3：指定分组可见，默认为0。
 list_id 微博的保护投递指定分组ID，只有当visible参数为3时生效且必选。
 lat 纬度，有效范围：-90.0到+90.0，+表示北纬，默认为0.0。
 long 经度，有效范围：-180.0到+180.0，+表示东经，默认为0.0。
 annotations 元数据，主要是为了方便第三方应用记录一些适合于自己使用的信息，每条微博可以包含一个或者多个元数据，必须以json字串的形式提交，字串长度不超过512个字符，具体内容可以自定。
 rip 开发者上报的操作用户真实IP，形如：211.156.0.1。
 */
- (void)UpdateWriteWithPramas:(RequestStatuParma *)prama
{
    NSDictionary *pramas = [prama dictaryValue];
    [WBHttpRequest requestWithURL:@"https://api.weibo.com/2/statuses/update.json" httpMethod:@"POST" params:pramas queue:nil withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error)
     {
         
         [self.delegate didfinishedUpdateWithError:error];
     }
     ];

}

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
- (void)UploadWriteWithPramas:(RequestStatuParma *)prama
{
    NSDictionary *pramas = [prama dictaryValue];
    [WBHttpRequest requestWithURL:@"https://upload.api.weibo.com/2/statuses/upload.json" httpMethod:@"POST" params:pramas queue:nil withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error)
     {
         
         [self.delegate didfinishedUploadWithError:error];
     }
     ];

}

#pragma -- 刷新方法 -- 

/**更新新收到的信息(就是屏幕最上面的下拉刷新,就是在上次请求后才更新的内容)
 *如果是请求下一页的内容不要用这个
 */
-(void)RefreshNewDataWithPramas:(RequestStatuParma *)aParma
{
    RequestStatuParma *parma = [[RequestStatuParma alloc]initWithDict:[aParma dictaryValue]];
    parma.since_id = self.since_id;
    NSDictionary *pramas = [parma dictaryValue];
    [WBHttpRequest requestWithURL:self.url httpMethod:@"GET" params:pramas queue:nil withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error)
     {
         NSDictionary *dict = result;
         StatuList *statuList = [[StatuList alloc]initWithDict:dict];
         NSArray *status = statuList.statuses;
         if (status && status.count!= 0) {
             Statu *temp = status[0];
             _since_id = temp.idstr;
         }
         [self.delegate didfinishedRefreshNewDataWithStatuList:statuList ststus:status error:error];
     }
     ];
}

/**加载下一页的信息(就是拉到屏幕最下面的加载下一页内容)
 *如果请求最新消息不要用这个方法
 *注意,如果是要第二页的内容传入的参数page不要填2,方法内部自动处理
 */
- (void)RefreshNextPageDataWithPramas:(RequestStatuParma *)aParma
{
   RequestStatuParma *parma = [[RequestStatuParma alloc]initWithDict:[aParma dictaryValue]];
    parma.max_id = self.max_id;
    
    //由于使用max_id会取到max_id微博本身,导致取得的第一条结果和上次尾部结果重复,所以后面要删掉第一个取得的微博,这样会导致取到的微博少了一条,所以取得微博需要比实际多一条.
    if(parma.count)
    {
    NSInteger count = [parma.count integerValue];
    count += 1;
    parma.count = [NSString stringWithFormat:@"%ld",count];
    }
    else
    {
        NSInteger count = 21;
        parma.count = [NSString stringWithFormat:@"%ld",count];
    }
    
    NSDictionary *pramas = [parma dictaryValue];
    [WBHttpRequest requestWithURL:self.url httpMethod:@"GET" params:pramas queue:nil withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error)
     {
         NSDictionary *dict = result;
         StatuList *statuList = [[StatuList alloc]initWithDict:dict];
         NSMutableArray *status = [NSMutableArray arrayWithArray:statuList.statuses];
         //由于使用max_id会取到max_id微博本身,导致取得的第一条结果和上次尾部结果重复,所以后面要删掉第一个取得的微博
         if (status && status.count != 0) {
             [status removeObjectAtIndex:0];
         }
         if (status && status.count!= 0) {
             Statu *temp = status[status.count-1];
             _max_id = temp.idstr;
         }
         
         [self.delegate didfinishedRefreshNextPageDataWithStatuList:statuList ststus:status error:error];
     }
     ];
}

//查看是否有新消息
-(void)HaveNewDataWithPramas:(RequestStatuParma *)aParma
{
    RequestStatuParma *parma = [[RequestStatuParma alloc]initWithDict:[aParma dictaryValue]];
    parma.since_id = self.since_id;
    NSDictionary *pramas = [parma dictaryValue];
    [WBHttpRequest requestWithURL:@"https://api.weibo.com/2/statuses/friends_timeline.json" httpMethod:@"GET" params:pramas queue:nil withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error)
     {
         NSDictionary *dict = result;
         StatuList *statuList = [[StatuList alloc]initWithDict:dict];
         NSArray *status = statuList.statuses;
         [self.delegate didfinishedHaveNewDataWithWithStatuList:statuList ststus:status error:error];
     }
     ];
}




@end
