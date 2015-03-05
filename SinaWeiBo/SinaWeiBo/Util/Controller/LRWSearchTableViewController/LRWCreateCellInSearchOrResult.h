//
//  LRWCreateCellInSearchOrResult.h
//  微博SDK测试
//
//  Created by lrw on 15/2/4.
//  Copyright (c) 2015年 LRW. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Trend.h"
#import "User.h"
#import "UIImageView+AFNetworking.h"
//cell的高度
#define SEARCHCELLHEIGHT 40
typedef enum{
    //搜索话题
    LRWSearchTypeTopic = 0,
    //搜索好友
    LRWSearchTypeAt
}LRWSearchType;
@interface LRWCreateCellInSearchOrResult : NSObject
/**创建联系人cell*/
+ (UITableViewCell *)createTopicCellInTableView:(UITableView *)tableView searchType:(LRWSearchType)searchType cellData:(Trend *)data;

/**获取关注人cell*/
+ (UITableViewCell *)createAtCellInTableView:(UITableView *)tableView searchType:(LRWSearchType)searchType cellData:(User *)data;
@end
