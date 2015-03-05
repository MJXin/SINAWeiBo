//
//  SearchSuggestionsRequest.m
//  WBTest
//
//  Created by mjx on 15/1/29.
//  Copyright (c) 2015年 MJX. All rights reserved.
//

#import "SearchSuggestionsRequest.h"

@implementation SearchSuggestionsRequest

/**搜索用户时的联想搜索建议
 *access_token 采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 *q 搜索的关键字，必须做URLencoding。
 *count 返回的记录条数，默认为10。
 */
- (void)UserSearchSuggestionRequestWithParma:(RequestSearchSuggestionsParma*)parma
{
    NSString *url = @"https://api.weibo.com/2/search/suggestions/users.json";
    NSDictionary *parmas = [parma dictaryValue];
    [WBHttpRequest requestWithURL:url httpMethod:@"GET" params:parmas queue:nil withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error)
     {
         NSArray *SuggestionUsers = result;
         NSMutableArray *userSearchSuggestions = [NSMutableArray new];
         for (NSDictionary *userDict in SuggestionUsers) {
             UserSearchSuggestion *user = [[UserSearchSuggestion alloc]initWithDict:userDict];
             [userSearchSuggestions addObject:user];
         }
         [self.delegate UserSearchSuggestionRequestDidFinishedWithUserSearchSuggestions:userSearchSuggestions error:error];
     }];
    
}

/**搜索学校时的联想搜索建议
 *access_token 采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 *q 搜索的关键字，必须做URLencoding。
 *count 返回的记录条数，默认为10。
 *type 学校类型，0：全部、1：大学、2：高中、3：中专技校、4：初中、5：小学，默认为0。
 */
- (void)SchoolsSearchSuggestionRequestWithParma:(RequestSearchSuggestionsParma*)parma
{
    NSString *url = @"https://api.weibo.com/2/search/suggestions/schools.json";
    NSDictionary *parmas = [parma dictaryValue];
    [WBHttpRequest requestWithURL:url httpMethod:@"GET" params:parmas queue:nil withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error)
     {
         NSArray *suggestionSchools = result;
         NSMutableArray *schoolSearchSuggestions = [NSMutableArray new];
         for (NSDictionary *schoolDict in suggestionSchools) {
             SchoolSearchSuggestion *school = [[SchoolSearchSuggestion alloc]initWithDict:schoolDict];
             [schoolSearchSuggestions addObject:school];
         }
         [self.delegate SchoolsSearchSuggestionRequestDidFinishedWithSchoolSearchSuggestions:schoolSearchSuggestions error:error];
     }];
    
}

/**搜索公司时的联想搜索建议
 *access_token 采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 *q 搜索的关键字，必须做URLencoding。
 *count 返回的记录条数，默认为10。
 */
- (void)CompaniesSearchSuggestionRequestWithParma:(RequestSearchSuggestionsParma*)parma
{
    NSString *url = @"https://api.weibo.com/2/search/suggestions/companies.json";
    NSDictionary *parmas = [parma dictaryValue];
    [WBHttpRequest requestWithURL:url httpMethod:@"GET" params:parmas queue:nil withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error)
     {
         NSArray *suggestioncompanies = result;
         NSMutableArray *companiesSearchSuggestions = [NSMutableArray new];
         for (NSDictionary *companiesDict in suggestioncompanies) {
             CompaniesSearchSuggestion *companies = [[CompaniesSearchSuggestion alloc]initWithDict:companiesDict];
             [companiesSearchSuggestions addObject:companies];
         }
         [self.delegate CompaniesSearchSuggestionRequestDidFinishedWithCompaniesSearchSuggestions:companiesSearchSuggestions error:error];
     }];
}

/**搜索APP时的联想搜索建议
 *access_token 采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 *q 搜索的关键字，必须做URLencoding。
 *count 返回的记录条数，默认为10。
 */
- (void)AppsSearchSuggestionRequestWithParma:(RequestSearchSuggestionsParma*)parma
{
    NSString *url = @"https://api.weibo.com/2/search/suggestions/apps.json";
    NSDictionary *parmas = [parma dictaryValue];
    [WBHttpRequest requestWithURL:url httpMethod:@"GET" params:parmas queue:nil withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error)
     {
         NSArray *suggestionApps = result;
         NSMutableArray *appSearchSuggestions = [NSMutableArray new];
         for (NSDictionary *appDict in suggestionApps) {
             AppSearchSuggestion *app = [[AppSearchSuggestion alloc]initWithDict:appDict];
             [appSearchSuggestions addObject:app];
         }
         [self.delegate AppsSearchSuggestionRequestDidFinishedWithAppSearchSuggestions:appSearchSuggestions error:error];
          }];
}

/**@用户时的联想建议
 *access_token 采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 *q 搜索的关键字，必须做URLencoding。
 *count 返回的记录条数，默认为10。
 *type 联想类型，0：关注、1：粉丝。
 *range 联想范围，0：只联想关注人、1：只联想关注人的备注、2：全部，默认为2。
 */
- (void)AtUserSuggestionRequestWithParma:(RequestSearchSuggestionsParma*)parma
{
    NSString *url = @"https://api.weibo.com/2/search/suggestions/at_users.json";
    NSDictionary *parmas = [parma dictaryValue];
    [WBHttpRequest requestWithURL:url httpMethod:@"GET" params:parmas queue:nil withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error)
     {
         NSArray *suggestions = result;
         NSMutableArray *atUserSuggestions = [NSMutableArray new];
         for (NSDictionary *atuserDict in suggestions) {
             AtUserSuggestion *atUserSuggestion = [[AtUserSuggestion alloc]initWithDict:atuserDict];
             [atUserSuggestions addObject:atUserSuggestion];
         }
         [self.delegate AtUserSuggestionRequestDidFinishedWithAtUserSuggestions:atUserSuggestions error:error];
         
     }];
    

}


@end
