//
//  User.h
//  WBTest
//
//  Created by mjx on 15/1/19.
//  Copyright (c) 2015年 MJX. All rights reserved.
//  用户信息

#import <Foundation/Foundation.h>
@class Statu;
@interface User : NSObject
/**用户UID*/
@property(nonatomic,assign)	NSInteger Id;
/**字符串型的用户UID*/
@property(nonatomic,strong) NSString *idstr;
/**用户昵称 */
@property(nonatomic,strong) NSString *screen_name;
/**友好显示名称 */
@property(nonatomic,strong) NSString *name;
/**用户所在省级ID	 */
@property(nonatomic) NSInteger province;
/**用户所在城市ID */
@property(nonatomic) NSInteger city;
/**用户所在地 */
@property(nonatomic,strong) NSString *locaton;
/**用户个人描述 */
@property(nonatomic,strong) NSString *Description;
/**用户博客地址 */
@property(nonatomic,strong)NSString *url;
/**用户头像地址（中图 */
@property(nonatomic,strong)NSString *profile_image_url;
/**用户的微博统一URL地址 */
@property(nonatomic,strong)NSString *profile_url;
/**用户的个性化域名 */
@property(nonatomic,strong)NSString *domain;
/**用户的微号 */
@property(nonatomic,strong)NSString *weihao;
/**性别，m：男、f：女、n：未知 */
@property(nonatomic,strong)NSString *gender;
/**粉丝数	 */
@property(nonatomic)NSInteger followers_count;
/**关注数 */
@property(nonatomic)NSInteger friends_count;
/**微博数 */
@property(nonatomic)NSInteger statuses_count;
/**收藏数 */
@property(nonatomic)NSInteger favourites_count;
/**用户创建（注册）时间 */
@property(nonatomic,strong)NSString *created_at;
/**暂未支持 */
@property(nonatomic)BOOL following;
/**是否允许所有人给我发私信，true：是，false：否 */
@property(nonatomic)BOOL allow_all_act_msg;
/**是否允许标识用户的地理位置，true：是，false：否*/
@property(nonatomic)BOOL geo_enabled;
/**是否是微博认证用户，即加V用户，true：是，false：否 */
@property(nonatomic)BOOL verified;
/**暂未支持 */
@property(nonatomic)NSInteger verified_type;
/**用户备注信息，只有在查询用户关系时才返回此字段 */
@property(nonatomic,strong)NSString *remark;
/**用户的最近一条微博信息字段 详细 */
@property(nonatomic,strong)Statu *status;
/**是否允许所有人对我的微博进行评论，true：是，false：否 */
@property(nonatomic)BOOL allow_all_comment;
/**用户头像地址（大图），180×180像素 */
@property(nonatomic,strong)NSString *avatar_large;
/**用户头像地址（高清），高清头像原图 */
@property(nonatomic,strong)NSString *avatar_hd;
/**认证原因 */
@property(nonatomic,strong)NSString *verified_reason;
/**该用户是否关注当前登录用户，true：是，false：否 */
@property(nonatomic)BOOL follow_me;
/**用户的在线状态，0：不在线、1：在线 */
@property(nonatomic)BOOL online_status;
/**用户的互粉数 */
@property(nonatomic)NSInteger bi_followers_count;
/**用户当前的语言版本，zh-cn：简体中文，zh-tw：繁体中文，en：英语 */
@property(nonatomic,strong)NSString *lang;

/**以下内容文档没给 未知作用 */
@property (nonatomic, strong) id cover_image_phone;
@property (nonatomic, strong) id urank;
@property (nonatomic, strong) id Class;
@property (nonatomic, strong) id verified_contact_email;
@property (nonatomic, strong) id verified_contact_mobile;
@property (nonatomic, strong) id location;
@property (nonatomic, strong) NSString *mbrank;
@property (nonatomic, strong) id cover_image;
@property (nonatomic, strong) id verified_trade;
@property (nonatomic, strong) id mbtype;
@property (nonatomic, strong) id verified_source_url;
@property (nonatomic, strong) id verified_contact_name;
@property (nonatomic, strong) id block_word;
@property (nonatomic, strong) id credit_score;
@property (nonatomic, strong) id star;
@property (nonatomic, strong) id verified_level;
@property (nonatomic, strong) id block_app;
@property (nonatomic, strong) id verified_reason_url;
@property (nonatomic, strong) id verified_reason_modified;
@property (nonatomic, strong) id verified_source;
@property (nonatomic, strong) id pagefriends_count;
@property (nonatomic, strong) id ptype;
@property (nonatomic, strong) id verified_state;
@property (nonatomic, strong) id ability_tags;


- (User*)initWithDict:(NSDictionary*)dict;

@end
