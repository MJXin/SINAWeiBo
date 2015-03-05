//
//  StatuLists.h
//  WBTest
//
//  Created by mjx on 15/1/20.
//  Copyright (c) 2015年 MJX. All rights reserved.
//  这个类是用来存放获取微博时候的整体JSON

#import <Foundation/Foundation.h>

@interface StatuList : NSObject
#warning 由于很多字段作用不明,先用id存放
@property (nonatomic, strong) NSArray *ad;
@property (nonatomic, strong) id hasvisible;
@property (nonatomic, strong) id interval;
@property (nonatomic, strong) id advertises;
@property (nonatomic, strong) id previous_sursor;
@property (nonatomic, strong) id uve_blank;
@property (nonatomic, strong) id total_number;
@property (nonatomic, strong) id has_unread;
@property (nonatomic, strong) id max_id;
/**存放微博的数组 */
@property (nonatomic, strong) NSArray *statuses;
/**存放微博的Id数组 */
@property (nonatomic, strong) NSArray *statusesId;
@property (nonatomic, strong) id next_cursor;
@property (nonatomic, strong) id since_id;

/**通过字典初始化JSON列表
 *当statuses是详细数据时调用
 */
- (StatuList*)initWithDict:(NSDictionary*)dict;

/**通过字典初始化JSON列表
 *当statuses是id时调用
 */
- (StatuList*)initStatuesIdWithDict:(NSDictionary *)dict;

/**通过字典初始化JSON列表
 *专用于请求所有转发的微博(因为api的key与正常不一样)
 */
- (StatuList*)initRepostsStatuesWithDict:(NSDictionary*)dict;

/**通过字典初始化JSON列表
 *请求Id
 *专用于请求所有转发的微博
 */
- (StatuList*)initRepostsStatuesIdWithDict:(NSDictionary*)dict;
@end
