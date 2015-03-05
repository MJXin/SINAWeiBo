//
//  TrendsList.h
//  WBTest
//
//  Created by mjx on 15/1/28.
//  Copyright (c) 2015年 MJX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Trend.h"
@interface TrendsList : NSObject

/**接口中的as_of参数,一般没用*/
@property (nonatomic, strong) NSNumber *as_of;
#warning 如此将key"trends"分解是基于trends中只有一个字典的情况,如果情况发生变化,这种提取将会出错,但是在"trend"中只有一个字典的时候,这种取法比较好
/**接口字典中"trends"的值被提取出来,这个是时间*/
@property (nonatomic, strong) NSString *date;
/**接口字典中"trends"的值被提取出来,这个是话题数组*/
@property (nonatomic, strong) NSArray *trends;

- (instancetype)initWithDict:(NSDictionary*)dict;

@end
