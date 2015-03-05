//
//  Favorites.h
//  WBTest
//
//  Created by mjx on 15/1/27.
//  Copyright (c) 2015年 MJX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Statu.h"
#import "Tag.h"
#import "NSObject+PropertyMethod.h"
@interface Favorite : NSObject

/**收藏的微博 */
@property (nonatomic, strong) Statu *status;
/**收藏的微博Id */
@property (nonatomic, strong) NSString *statusId;
/**该收藏的标签 */
@property (nonatomic, strong) NSArray *tags;
/**该收藏的创建时间*/
@property (nonatomic, strong) NSString *favorited_time;

- (instancetype)initWithDict:(NSDictionary*)dict;
/**初始化收藏内容(微博为id)*/
-(instancetype)initStatusIdWithDict:(NSDictionary *)dict;
@end
