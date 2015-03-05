//
//  UnRead.h
//  WBTest
//
//  Created by mjx on 15/1/30.
//  Copyright (c) 2015年 MJX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+PropertyMethod.h"
@interface UnRead : NSObject

/**新微博未读数 */
@property (nonatomic, strong) NSNumber *status;
/**新粉丝数 */
@property (nonatomic, strong) NSNumber *follower;
/**新评论数 */
@property (nonatomic, strong) NSNumber *cmt;
/**新私信数 */
@property (nonatomic, strong) NSNumber *dm;
/**新提及我的微博数 */
@property (nonatomic, strong) NSNumber *mention_status;
/**新提及我的评论数 */
@property (nonatomic, strong) NSNumber *mention_cmt;
/**微群消息未读数 */
@property (nonatomic, strong) NSNumber *group;
/**私有微群消息未读数 */
@property (nonatomic, strong) NSNumber *private_group;
/**新通知未读数*/
@property (nonatomic, strong) NSNumber *notice;
/**新邀请未读数 */
@property (nonatomic, strong) NSNumber *invite;
/**新勋章数 */
@property (nonatomic, strong) NSNumber *badge;
/**相册消息未读数 */
@property (nonatomic, strong) NSNumber *photo;
/**不知道啥玩意 {{{3}}}*/
@property (nonatomic, strong) NSNumber *msgbox;

-(instancetype)initWithDict:(NSDictionary*)dict;
@end
