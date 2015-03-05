//
//  LRWResultViewController.h
//  微博SDK测试
//
//  Created by lrw on 15/2/3.
//  Copyright (c) 2015年 LRW. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LRWSearchTableViewController.h"
@protocol LRWResultViewControllerDelegate;
@interface LRWResultViewController : UITableViewController<UISearchResultsUpdating>
@property (nonatomic , weak) id<LRWResultViewControllerDelegate> delegate;
@property (nonatomic, strong) NSArray *dataArray;
/**搜索类型 默认是 LRWSearchTypeTopic*/
@property (nonatomic, assign, readonly) LRWSearchType searchtype;
- (instancetype)initWithType:(LRWSearchType)searchType;
@end



@protocol LRWResultViewControllerDelegate <NSObject>
/**结果集控制器，cell被点击*/
- (void)resultViewController:(LRWResultViewController *)viewController didClickCell:(UITableViewCell *)cell searchType:(LRWSearchType)searchType;
@end