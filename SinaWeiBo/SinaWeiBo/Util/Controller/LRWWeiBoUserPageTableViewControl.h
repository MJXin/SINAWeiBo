//
//  LRWWeiBoUserPageTableViewControl.h
//  微博SDK测试
//
//  Created by lrw on 15/1/30.
//  Copyright (c) 2015年 LRW. All rights reserved.
//

#import "LRWWeiBoUserHomePageTableViewController.h"
@class User;
@interface LRWWeiBoUserPageTableViewControl : LRWWeiBoUserHomePageTableViewController
@property (nonatomic, strong) User *user;
@property (nonatomic, copy) NSString *userName;
@end
