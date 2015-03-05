//
//  FavoritesList.h
//  WBTest
//
//  Created by mjx on 15/1/27.
//  Copyright (c) 2015年 MJX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+PropertyMethod.h"
#import "Favorite.h"
@interface FavoritesList : NSObject

/**收藏微博数组 */
@property (nonatomic, strong) NSArray *favorites;

/**这个属性不知道啥用,先留着*/
@property (nonatomic) NSInteger total_number;

/**标签数组,请求标签的时候使用*/
@property (nonatomic, strong) NSArray *tags;

/**标签Id数组.请求标签数组使用*/
@property (nonatomic, strong) NSArray *tagsId;

- (instancetype)initWithDict:(NSDictionary*)dict;

/**请求收藏微博Id时调用此方法*/
- (instancetype)initFavoriteIdWithDict:(NSDictionary*)dict;

/**请求收藏标签的时候调用此方法*/
- (instancetype)initTagsWithDict:(NSDictionary*)dict;
/**请求收藏标签Id的时候调用此方法*/
- (instancetype)initTagsIdWithDict:(NSDictionary*)dict;

@end
