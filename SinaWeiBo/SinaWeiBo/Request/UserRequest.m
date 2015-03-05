//
//  UserRequest.m
//  WBTest
//
//  Created by mjx on 15/1/23.
//  Copyright (c) 2015年 MJX. All rights reserved.
//

#import "UserRequest.h"
#import "WeiboSDK.h"
#import "User.h"
@implementation UserRequest

/**根据用户ID获取用户信息
 *access_token 采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 *参数uid与screen_name二者必选其一，且只能选其一；
 *uid 需要查询的用户ID。
 *screen_name 需要查询的用户昵称。
 */
-(void)UserRequestWithUserIdPramas:(RequestUserParma *)parma
{
    NSDictionary *parmas = [parma dictaryValue];
    NSString *url = @"https://api.weibo.com/2/users/show.json";
    [WBHttpRequest requestWithURL:url httpMethod:@"GET" params:parmas queue:nil withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error)
     {
         NSDictionary *dict = result;
         User *user = [[User alloc]initWithDict:dict];
         [self.delegate UserRequestWithUserIddidFinishedWithUser:user error:error];
     }
     ];
    
}

/*通过个性化域名获取用户资料以及用户最新的一条微博
 *(必)access_token 采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 *(必)domain 需要查询的个性化域名。
 */
- (void)UserRequestWithDomainPramas:(RequestUserParma*)parma
{
    NSDictionary *pramas = [parma dictaryValue];
    NSString *url = @"https://api.weibo.com/2/users/domain_show.json";
    [WBHttpRequest requestWithURL:url httpMethod:@"GET" params:pramas queue:nil withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error)
     {
         NSDictionary *dict = result;
         User *user = [[User alloc]initWithDict:dict];
         [self.delegate UserRequestWithDomaindidFinishedWithUser:user error:error];
     }
     ];

}




@end
