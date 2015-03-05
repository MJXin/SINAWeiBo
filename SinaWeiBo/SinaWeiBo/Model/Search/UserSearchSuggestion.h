//
//  SearchSuggestion.h
//  WBTest
//
//  Created by mjx on 15/1/29.
//  Copyright (c) 2015年 MJX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+PropertyMethod.h"
@interface UserSearchSuggestion : NSObject

/**建议用户名字 */
@property (nonatomic, strong) NSString *screen_name;
/**建议用户的id */
@property (nonatomic, strong) NSNumber *uid;
/**建议用户的粉丝数量 */
@property (nonatomic, strong) NSNumber *followers_count;

-(instancetype)initWithDict:(NSDictionary*)dict;
@end
