//
//  SearchSuggestionsRequest.h
//  WBTest
//
//  Created by mjx on 15/1/29.
//  Copyright (c) 2015年 MJX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WeiboSDK.h"
#import "RequestSearchSuggestionsParma.h"
#import "UserSearchSuggestion.h"
#import "SchoolSearchSuggestion.h"
#import "CompaniesSearchSuggestion.h"
#import "AppSearchSuggestion.h"
#import "AtUserSuggestion.h"
#pragma mark --- 搜索建议请求类代理 ---

@protocol SearchSuggestionsRequestDelegate <NSObject>

@optional
/**完成请求搜索用户时的联想搜索建议后触发的代理方法 数组中存放的是UserSearchSuggestion类*/
- (void)UserSearchSuggestionRequestDidFinishedWithUserSearchSuggestions:(NSArray*)userSearchSuggestions error:(NSError*)error;
/**完成请求搜索学校时的搜索建议后触发的代理方法 数组中存放的是SchoolSearchSuggestion类*/
- (void)SchoolsSearchSuggestionRequestDidFinishedWithSchoolSearchSuggestions:(NSArray*)schoolSearchSuggestions error:(NSError*)error;
/**完成请求搜索公司时的搜索建议后触发的代理方法 数组中存放的是CompaniesSearchSuggestion类*/
- (void)CompaniesSearchSuggestionRequestDidFinishedWithCompaniesSearchSuggestions:(NSArray*)companiesSearchSuggestions error:(NSError*)error;
/**完成请求搜索APP时的搜索建议后触发的代理方法 数组中存放的是AppSearchSuggestion类*/
- (void)AppsSearchSuggestionRequestDidFinishedWithAppSearchSuggestions:(NSArray*)appSearchSuggestions error:(NSError*)error;
/**完成请求艾特用户的联想后触发的代理方法 数组中存放的是AtUserSuggestion类*/
- (void)AtUserSuggestionRequestDidFinishedWithAtUserSuggestions:(NSArray*)atUserSuggestions error:(NSError*)error;
@end

#pragma mark --- 搜索建议请求类正文 ---
@interface SearchSuggestionsRequest : NSObject

@property (nonatomic, strong) id<SearchSuggestionsRequestDelegate> delegate;
#pragma mark -- 搜索联想接口 -- 

/**搜索用户时的联想搜索建议
 *(必)access_token 采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 *(必)q 搜索的关键字，必须做URLencoding。
 *count 返回的记录条数，默认为10。
 */
- (void)UserSearchSuggestionRequestWithParma:(RequestSearchSuggestionsParma*)parma;

/**搜索学校时的联想搜索建议
 *(必)access_token 采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 *(必)q 搜索的关键字，必须做URLencoding。
 *count 返回的记录条数，默认为10。
 *type 学校类型，0：全部、1：大学、2：高中、3：中专技校、4：初中、5：小学，默认为0。
 */
- (void)SchoolsSearchSuggestionRequestWithParma:(RequestSearchSuggestionsParma*)parma;

/**搜索公司时的联想搜索建议
 *(必)access_token 采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 *(必)q 搜索的关键字，必须做URLencoding。
 *count 返回的记录条数，默认为10。
 */
- (void)CompaniesSearchSuggestionRequestWithParma:(RequestSearchSuggestionsParma*)parma;

/**搜索APP时的联想搜索建议
 *(必)access_token 采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 *(必)q 搜索的关键字，必须做URLencoding。
 *count 返回的记录条数，默认为10。
 */
- (void)AppsSearchSuggestionRequestWithParma:(RequestSearchSuggestionsParma*)parma;

/**@用户时的联想建议
 *(必)access_token 采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 *(必)q 搜索的关键字，必须做URLencoding。
 *count 返回的记录条数，默认为10。
 *type 联想类型，0：关注、1：粉丝。
 *range 联想范围，0：只联想关注人、1：只联想关注人的备注、2：全部，默认为2。
 */
- (void)AtUserSuggestionRequestWithParma:(RequestSearchSuggestionsParma*)parma;


@end
