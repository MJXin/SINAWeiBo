//
//  Trend.h
//  WBTest
//
//  Created by mjx on 15/1/29.
//  Copyright (c) 2015年 MJX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+PropertyMethod.h"
@interface Trend : NSObject
/**话题名字*/
@property (nonatomic, strong) NSString *name;
/**和话题名字完全一样的字符串,意义不明*/
@property (nonatomic, strong) NSString *query;
/**意义不明*/
@property(nonatomic)NSInteger amount;
/**和amount完全一样的整数,意义不明*/
@property(nonatomic)NSInteger delta;

-(instancetype)initWithDict:(NSDictionary*)dict;
@end
