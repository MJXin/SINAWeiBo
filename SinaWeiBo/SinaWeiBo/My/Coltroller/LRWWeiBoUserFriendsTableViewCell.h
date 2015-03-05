//
//  LRWWeiBoUserFriendsTableViewCell.h
//  微博SDK测试
//
//  Created by lrw on 15/2/4.
//  Copyright (c) 2015年 LRW. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
@interface LRWWeiBoUserFriendsTableViewCell : UITableViewCell
@property (nonatomic, strong) User *user;
+ cellWithTableView:(UITableView *)tableView;
@end
