//
//  UserRequest.h
//  WBTest
//
//  Created by mjx on 15/1/23.
//  Copyright (c) 2015年 MJX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RequestUserParma.h"
#import "User.h"
@protocol UserRequestDelegate <NSObject>

@optional
/**完成请求用户数据代理方法,代理通过user获取user数据*/
- (void)UserRequestWithUserIddidFinishedWithUser:(User*)user error:(NSError*)error;
/**完成通过个性化域名查询用户方法,代理通过user获取user数据*/
- (void)UserRequestWithDomaindidFinishedWithUser:(User*)user error:(NSError*)error;

@end
#pragma -- UserRequest类正文 --
@interface UserRequest : NSObject

@property (nonatomic, strong) id<UserRequestDelegate> delegate;

/**根据用户ID获取用户信息
 *(必)access_token 采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 *参数uid与screen_name二者必选其一，且只能选其一；
 *uid 需要查询的用户ID。
 *screen_name 需要查询的用户昵称。
 */
-(void)UserRequestWithUserIdPramas:(RequestUserParma *)parma;

/*通过个性化域名获取用户资料以及用户最新的一条微博
 *(必)access_token 采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 *(必)domain 需要查询的个性化域名。
 */
- (void)UserRequestWithDomainPramas:(RequestUserParma*)parma;
@end
