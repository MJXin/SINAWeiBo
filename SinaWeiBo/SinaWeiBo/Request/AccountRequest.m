//
//  AccountRequest.m
//  WBTest
//
//  Created by mjx on 15/1/27.
//  Copyright (c) 2015年 MJX. All rights reserved.
//

#import "AccountRequest.h"

@implementation AccountRequest

/**获取当前登录用户的隐私设置
 *access_token采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 */
- (void)PrivacyRequestWithParma:(RequestAccountParma*)parma
{
    NSString *url = @"https://api.weibo.com/2/account/get_privacy.json";
    NSDictionary *parmas = [parma dictaryValue];
    [WBHttpRequest requestWithURL:url httpMethod:@"GET" params:parmas queue:nil withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error)
    {
        NSDictionary *dict = result;
        AccountPrivacy *privacy = [[AccountPrivacy alloc]initWithDict:dict];
        [self.delegate PrivacyRequestdidFinishedWithAccountPrivacy:privacy error:error];
    }];
    
}

/**OAuth授权之后，获取授权用户的UID
 *access_token 采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 */
- (void)UidRequestWithParma:(RequestAccountParma*)parma
{
    NSString *url = @"https://api.weibo.com/2/account/get_uid.json";
    NSDictionary *parmas = [parma dictaryValue];
    [WBHttpRequest requestWithURL:url httpMethod:@"GET" params:parmas queue:nil withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error)
     {
         NSDictionary *dict = result;
         NSString *uid;
         if (dict[@"uid"]) {
             uid = dict[@"uid"];
             
         }
         [self.delegate UidRequestdidFinishedWithUid:uid error:error];
        
     }];
}

/**退出登陆
 *access_token 采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 */
- (void)EndSeddionWriteWithParma:(RequestAccountParma*)parma
{
    NSString *url = @"https://api.weibo.com/2/account/end_session.json";
    NSDictionary *parmas = [parma dictaryValue];
    [WBHttpRequest requestWithURL:url httpMethod:@"GET" params:parmas queue:nil withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error)
     {
         NSDictionary *dict = result;
         User *user = [[User alloc]initWithDict:dict];
         
         [self.delegate EndSeddionWritedidFinishedWithUser:user error:error];
     }
     ];

}
@end
