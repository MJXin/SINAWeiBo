//
//  AppSearchSuggestion.h
//  WBTest
//
//  Created by mjx on 15/1/29.
//  Copyright (c) 2015年 MJX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+PropertyMethod.h"

@interface AppSearchSuggestion : NSObject
/**App的名称*/
@property (nonatomic, strong) NSString *apps_name;
/**不确定是否是成员数量*/
@property (nonatomic, strong) NSNumber *members_count;
-(instancetype)initWithDict:(NSDictionary*)dict;
@end
