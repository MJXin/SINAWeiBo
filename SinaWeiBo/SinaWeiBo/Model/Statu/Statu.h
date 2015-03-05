//
//  Home_TimeLine.h
//  WBTest
//
//  Created by mjx on 15/1/18.
//  Copyright (c) 2015年 MJX. All rights reserved.
//  单条微博数据

#import <Foundation/Foundation.h>
#import "Geo.h"
#import "NSObject+PropertyMethod.h"

@class User;
@interface Statu: NSObject

/**微博创建时间*/
@property (nonatomic, copy) NSString *created_at;
/**微博ID*/
@property (nonatomic, assign) NSInteger Id;
/**微博MID*/
@property (nonatomic, assign) NSInteger mid;
/**字符串型的微博ID*/
@property (nonatomic, copy) NSString *idstr;
/**微博信息内容*/
@property (nonatomic, copy) NSString *text;
/**微博来源*/
@property (nonatomic, copy) NSString *source;
/**是否已收藏，true：是，false：否*/
@property (nonatomic, assign) BOOL favorited;
/**是否被截断，true：是，false：否*/
@property (nonatomic, assign) BOOL truncated;
/**（暂未支持）回复ID*/
@property (nonatomic, copy) NSString *in_reply_to_status_id;
/**（暂未支持）回复人UID*/
@property (nonatomic, copy) NSString *in_reply_to_user_id;
/**（暂未支持）回复人昵称*/
@property (nonatomic, copy) NSString *in_reply_to_screen_name;
/**缩略图片地址，没有时不返回此字段*/
@property (nonatomic, copy) NSString *thumbnail_pic;
/**中等尺寸图片地址，没有时不返回此字段*/
@property (nonatomic, copy) NSString *bmiddle_pic;
/**原始图片地址，没有时不返回此字段*/
@property (nonatomic, copy) NSString *original_pic;
/**地理信息字段*/
@property (nonatomic, strong) Geo *geo;
/**微博作者的用户信息字段*/
@property (nonatomic, strong) User *user;
/**被转发的原微博信息字段，当该微博为转发微博时返回*/
@property (nonatomic, strong) Statu *retweeted_status;
/**是否转发微博*/
@property (nonatomic) BOOL is_retweeted_status;
/**转发数*/
@property (nonatomic, assign) NSInteger reposts_count;
/**评论数*/
@property (nonatomic, assign) NSInteger comments_count;
/**表态数*/
@property (nonatomic, assign) NSInteger attitudes_count;
/**暂未支持*/
@property (nonatomic, assign) NSInteger mlevel;
/**微博的可见性及指定可见分组信息。该object中type取值，0：普通微博，1：私密微博，3：指定分组微博，4：密友微博；list_id为分组的组号*/
@property (nonatomic, strong) id visible;
/**微博配图ID。多图时返回多图ID，用来拼接图片url。用返回字段thumbnail_pic的地址配上该返回字段的图片ID，即可得到多个图片url。*/
@property (nonatomic, strong) id pic_ids;
/**微博流内的推广微博ID*/
@property (nonatomic, strong) id ad;
//-------------------------------------------文档没有提到的字段
/**所有缩略图url，没有就返回空*/
@property (nonatomic, strong) NSArray *pic_urls;
@property (nonatomic, assign) NSInteger source_type;


/**未知用途*/
@property (nonatomic, strong) NSString *darwin_tags;
@property (nonatomic, strong) NSString *rid;
@property (nonatomic, strong) NSString *pid;
@property (nonatomic, strong) id position;
@property (nonatomic, strong) id annotations;
@property (nonatomic, strong) id mblogtype;
@property (nonatomic,strong) id original_createtime;


- (Statu*)initWithDict:(NSDictionary*)dict;

- (NSDictionary *)dictaryValue;

@end
