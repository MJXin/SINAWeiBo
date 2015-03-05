//
//  StatuLists.m
//  WBTest
//
//  Created by mjx on 15/1/20.
//  Copyright (c) 2015年 MJX. All rights reserved.
//

#import "StatuList.h"
#import "NSObject+PropertyMethod.h"
#import "Statu.h"
@implementation StatuList
/**通过字典初始化JSON列表
 *当statuses是详细数据时调用
 */
- (StatuList *)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        
        NSMutableDictionary *mDict = [self StandardizePropertyDictionary:dict];
        NSArray *statusesDict = mDict[@"statuses"];
        NSMutableArray *statuses = [NSMutableArray new];
        
        for (NSDictionary *dict in statusesDict) {
            Statu *temp = [[Statu alloc]initWithDict:dict];
            [statuses addObject:temp];
        }
        [mDict setObject:statuses forKey:@"statuses"];
        [self setValuesForKeysWithDictionary:mDict];
    }
    
    return self;
}

/**通过字典初始化JSON列表
 *当statuses是id时调用
 */
- (StatuList*)initStatuesIdWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        NSMutableDictionary *mDict = [self StandardizePropertyDictionary:dict];
        NSArray *statuses = mDict[@"statuses"];
        NSMutableArray *statusesId = [NSMutableArray new];
        
        for (NSString *Id in statuses) {
            [statusesId addObject:Id];
        }
        
        [mDict setObject:statusesId forKey:@"statusesId"];
        [mDict removeObjectForKey:@"statuses"];
        [self setValuesForKeysWithDictionary:mDict];
    }
    
    return self;
}

/**通过字典初始化JSON列表
 *专用于请求所有转发的微博
 */
- (StatuList*)initRepostsStatuesWithDict:(NSDictionary*)dict
{
    if (self = [super init]) {
        
        NSMutableDictionary *mDict = [dict mutableCopy];
        if (!mDict[@"reposts"]) {
            return nil;
        }
        [mDict setObject:mDict[@"reposts"] forKey:@"statuses"];
        mDict = [self StandardizePropertyDictionary:mDict];
        NSArray *statusesDict = mDict[@"statuses"];
        NSMutableArray *statuses = [NSMutableArray new];
        
        for (NSDictionary *dict in statusesDict) {
            Statu *temp = [[Statu alloc]initWithDict:dict];
            [statuses addObject:temp];
        }
        [mDict setObject:statuses forKey:@"statuses"];
        [self setValuesForKeysWithDictionary:mDict];
    }
    
    return self;
}

/**通过字典初始化JSON列表
 *请求Id
 *专用于请求所有转发的微博
 */
- (StatuList*)initRepostsStatuesIdWithDict:(NSDictionary*)dict
{
    if (self = [super init]) {
        NSMutableDictionary *mDict = [self StandardizePropertyDictionary:dict];
        NSArray *statuses = mDict[@"statuses"];
        NSMutableArray *statusesId = [NSMutableArray new];
        
        for (NSString *Id in statuses) {
            [statusesId addObject:Id];
        }
        
        [mDict setObject:statusesId forKey:@"statusesId"];
        [mDict removeObjectForKey:@"statuses"];
        [self setValuesForKeysWithDictionary:mDict];
    }
    
    return self;
}






@end
