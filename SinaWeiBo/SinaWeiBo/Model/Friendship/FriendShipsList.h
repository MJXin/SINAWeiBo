//
//  FriendShipsList.h
//  WBTest
//
//  Created by mjx on 15/1/23.
//  Copyright (c) 2015年 MJX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FriendShipsList : NSObject

/**用户数组*/
@property (nonatomic, strong) NSArray *users;
@property (nonatomic, strong) NSArray *usersId;

/**以下作用未知*/
@property (nonatomic, strong) NSString *next_cursor;
@property (nonatomic, strong) NSString *previous_cursor;
@property (nonatomic, strong) NSString *total_number;

/**通过字典初始化JSON列表
 */
- (FriendShipsList*)initWithDict:(NSDictionary*)dict;

/**通过字典初始化用户ID
 *当用户数据是ID时候使用
 */
- (FriendShipsList *)initUsersIdWithDict:(NSDictionary *)dict;

@end
