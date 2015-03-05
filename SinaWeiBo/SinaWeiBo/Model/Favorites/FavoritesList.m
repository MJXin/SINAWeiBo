//
//  FavoritesList.m
//  WBTest
//
//  Created by mjx on 15/1/27.
//  Copyright (c) 2015年 MJX. All rights reserved.
//

#import "FavoritesList.h"

@implementation FavoritesList

- (instancetype)initWithDict:(NSDictionary*)dict
{
    if (self = [super init]) {
        NSMutableDictionary *mDict = [self StandardizePropertyDictionary:dict];
        
        //将FavoritesList中favorites数组取出,将其中字典全部转换为对象重新存入
        if(mDict[@"favorites"])
        {
            NSArray *temp = mDict[@"favorites"];
            NSMutableArray *favorites = [NSMutableArray new];
            for (NSDictionary *dict in temp) {
                Favorite *favorite = [[Favorite alloc]initWithDict:dict];
                [favorites addObject:favorite];
            }
            [mDict setObject:favorites forKey:@"favorites"];
        }
        
        [self setValuesForKeysWithDictionary:mDict];
        
        
    }
    return self;
}

- (instancetype)initFavoriteIdWithDict:(NSDictionary*)dict;
{
    if (self = [super init]) {
        NSMutableDictionary *mDict = [self StandardizePropertyDictionary:dict];
        
        //将FavoritesList中favorites数组取出,将其中字典全部转换为对象重新存入
        if(mDict[@"favorites"])
        {
            NSArray *temp = mDict[@"favorites"];
            NSMutableArray *favorites = [NSMutableArray new];
            for (NSDictionary *dict in temp) {
                Favorite *favorite = [[Favorite alloc]initStatusIdWithDict:dict];
                [favorites addObject:favorite];
            }
            [mDict setObject:favorites forKey:@"favorites"];
        }
        
        [self setValuesForKeysWithDictionary:mDict];
        
        
    }
    return self;
}

- (instancetype)initTagsWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        NSMutableDictionary *mDict = [self StandardizePropertyDictionary:dict];
        
        //将FavoritesList中favorites数组取出,将其中字典全部转换为对象重新存入
        if(mDict[@"tags"])
        {
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

- (instancetype)initTagsIdWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        NSMutableDictionary *mDict = [self StandardizePropertyDictionary:dict];
        
        //将FavoritesList中favorites数组取出,将其中字典全部转换为对象重新存入
        if(mDict[@"tags"])
        {
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
