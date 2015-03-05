//
//  AccountPrivacy.h
//  WBTest
//
//  Created by mjx on 15/1/27.
//  Copyright (c) 2015年 MJX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+PropertyMethod.h"
@interface AccountPrivacy : NSObject

/**注:下面有些值其实可以用bool表示,但是因为接口是整型,不确定是否会有0,1外其他值,所以直接用整型,使用使用判断数值即可*/
/**是否可以评论我的微博，0：所有人、1：关注的人、2：可信用户*/
@property(nonatomic)NSInteger comment;
/**是否开启地理信息，0：不开启、1：开启*/
@property(nonatomic)NSInteger geo;
/**是否可以给我发私信，0：所有人、1：我关注的人、2：可信用户 */
@property(nonatomic)NSInteger message;
/**是否可以通过真名搜索到我，0：不可以、1：可以 */
@property(nonatomic)NSInteger realname;
/**勋章是否可见，0：不可见、1：可见 */
@property(nonatomic)NSInteger badge;
/**是否可以通过手机号码搜索到我，0：不可以、1：可以 */
@property(nonatomic)NSInteger mobile;
/**是否开启webim， 0：不开启、1：开启 */
@property(nonatomic)NSInteger webim;

- (instancetype)initWithDict:(NSDictionary*)dict;
@end
