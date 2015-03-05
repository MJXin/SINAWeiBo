//
//  Url.h
//  WBTest
//
//  Created by mjx on 15/1/30.
//  Copyright (c) 2015年 MJX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+PropertyMethod.h"
#import "Statu.h"
#import "Comment.h"
@interface Url : NSObject

/**短链接 */
@property (nonatomic, strong) NSString *url_short;
/**原始长链接 */
@property (nonatomic, strong) NSString *url_long;
/**链接的类型，0：普通网页、1：视频、2：音乐、3：活动、5、投票 */
@property (nonatomic, strong) NSNumber *type;
/**短链的可用状态，true：可用、false：不可用*/
@property (nonatomic, strong) NSNumber *result;
/**短链在微博上的分享数*/
@property (nonatomic, strong) NSString *share_counts;
/**最新分享了短链的微博*/
@property (nonatomic, strong) NSArray *share_statuses;
/**短链在微博上的评论数*/
@property (nonatomic, strong) NSString *comment_counts;
/**最新分享了短链的评论*/
@property (nonatomic, strong) NSArray *share_comments;


-(instancetype)initWithDict:(NSDictionary*)dict;

@end
