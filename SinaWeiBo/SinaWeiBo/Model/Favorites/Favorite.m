//
//  Favorites.m
//  WBTest
//
//  Created by mjx on 15/1/27.
//  Copyright (c) 2015年 MJX. All rights reserved.
//

#import "Favorite.h"

@implementation Favorite

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        NSMutableDictionary *mDict = [self StandardizePropertyDictionary:dict];
        
        //将favorite字典中的status转换为对象,重新存入字典
        if (mDict[@"status"])
        {
            Statu *status = [[Statu alloc]initWithDict:mDict[@"status"]];
           
            [mDict setObject:status forKey:@"status"];
        }
        
        //将favorite字典中的tags数组数组取出,将其中所有元素转换为对象重新存回去
        if (mDict[@"tags"]) {
            NSArray *temp = mDict[@"tags"];
            NSMutableArray *tags = [NSMutableArray new];
            for (NSDictionary *dict in temp) {
                Tag *tag = [[Tag alloc]initWithDict:dict];
                [tags addObject:tag];
            }
            [mDict setObject:tags forKey:@"tags"];
        }
        
        [self setValuesForKeysWithDictionary:mDict];
    }
    return self;
}

/**初始化收藏内容(微博为id)*/
-(instancetype)initStatusIdWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        NSMutableDictionary *mDict = [self StandardizePropertyDictionary:dict];
        
        //将favorite字典中的status处理为statusId
        if (mDict[@"status"])
        {
            [mDict setObject:mDict[@"status"] forKey:@"statusId"];
            [mDict removeObjectForKey:@"status"];
        }
        
        //将favorite字典中的tags数组数组取出,将其中所有元素转换为对象重新存回去
        if (mDict[@"tags"]) {
            NSArray *temp = mDict[@"tags"];
            NSMutableArray *tags = [NSMutableArray new];
            for (NSDictionary *dict in temp) {
                Tag *tag = [[Tag alloc]initWithDict:dict];
                [tags addObject:tag];
            }
            [mDict setObject:tags forKey:@"tags"];
        }
        
        [self setValuesForKeysWithDictionary:mDict];
    }
    return self;
}
@end
