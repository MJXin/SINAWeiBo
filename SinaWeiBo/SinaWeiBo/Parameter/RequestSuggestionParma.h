//
//  RequestSuggestionParma.h
//  WBTest
//
//  Created by mjx on 15/1/29.
//  Copyright (c) 2015年 MJX. All rights reserved.
//  推荐请求

#import <Foundation/Foundation.h>
#import "NSObject+PropertyMethod.h"

@interface RequestSuggestionParma : NSObject

/**采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。*/
@property (nonatomic, strong) NSString *access_token;

/**推荐分类，返回某一类别的推荐用户，默认为default，如果不在以下分类中，返回空列表，default：人气关注、ent：影视名星、music：音乐、sports：体育、fashion：时尚、art：艺术、cartoon：动漫、games：游戏、trip：旅行、food：美食、health：健康、literature：文学、stock：炒股、business：商界、tech：科技、house：房产、auto：汽车、fate：命理、govern：政府、medium：媒体、marketer：营销专家。
 */
@property (nonatomic, strong) NSString *category;
/**单页返回的记录条数，默认为10。*/
@property (nonatomic, strong) NSString *count;
/**返回结果的页码，默认为1*/
@property (nonatomic, strong) NSString *page;
/**微博正文内容，必须做URLEncode，UTF-8编码 。*/
@property (nonatomic, strong) NSString *content;
/**返回结果数目，默认为10。*/
@property (nonatomic, strong) NSString *num;
/**用户id*/
@property (nonatomic, strong) NSString *uid;

/** 使用access_token初始化
 */
- (instancetype)initWithAccess_token:(NSString*)access_token;

/** 转换为字典
 */
- (NSDictionary*)dictaryValue;
@end
