//
//  CompaniesSearchSuggestion.h
//  WBTest
//
//  Created by mjx on 15/1/29.
//  Copyright (c) 2015年 MJX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+PropertyMethod.h"
@interface CompaniesSearchSuggestion : NSObject

/**公司名字 */
@property (nonatomic, strong) NSString *suggestion;

-(instancetype)initWithDict:(NSDictionary*)dict;

@end
