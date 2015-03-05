//
//  AccountRequest.h
//  WBTest
//
//  Created by mjx on 15/1/27.
//  Copyright (c) 2015年 MJX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RequestAccountParma.h"
#import "AccountPrivacy.h"
#import "WeiboSDK.h"
#import "User.h"
#pragma mark --- AccountRequest类代理 ---
@protocol AccountRequestDelegate <NSObject>
@optional
/**完成请求登陆用户隐私设置代理方法*/
- (void)PrivacyRequestdidFinishedWithAccountPrivacy:(AccountPrivacy*)accountPrivacy error:(NSError*)error;
/**完成获取用户Uid代理方法*/
- (void)UidRequestdidFinishedWithUid:(NSString*)Uid error:(NSError*)error;
/**完成退出登陆的代理方法,返回的是用户*/
- (void)EndSeddionWritedidFinishedWithUser:(User *)user error:(NSError *)error;
@end





#pragma mark --- AccountRequest类正文 ---
@interface AccountRequest : NSObject
@property (nonatomic, strong) id<AccountRequestDelegate> delegate;
/**获取当前登录用户的隐私设置
 *access_token采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 */
- (void)PrivacyRequestWithParma:(RequestAccountParma*)parma;

/**OAuth授权之后，获取授权用户的UID
 *access_token 采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 */
- (void)UidRequestWithParma:(RequestAccountParma*)parma;

/**退出登陆
 *access_token 采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 */
- (void)EndSeddionWriteWithParma:(RequestAccountParma*)parma;
@end
