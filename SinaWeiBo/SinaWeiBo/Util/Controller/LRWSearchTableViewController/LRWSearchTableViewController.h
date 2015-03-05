//
//  LRWSearchTableViewController.h
//  微博SDK测试
//
//  Created by lrw on 15/2/3.
//  Copyright (c) 2015年 LRW. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LRWCreateCellInSearchOrResult.h"
@protocol LRWSearchTableViewControllerDelegate;
@interface LRWSearchTableViewController : UITableViewController
/**搜索类型 默认是 LRWSearchTypeTopic*/
@property (nonatomic, assign, readonly) LRWSearchType searchtype;
@property (nonatomic , weak) id<LRWSearchTableViewControllerDelegate> delegate;
- (instancetype)initWithType:(LRWSearchType)searchType;
/**选中cell的时候，是否隐藏结果控制器 , 默认是YES*/
@property (nonatomic, assign) BOOL hideResultControlWhenCellDidSelect;
@end



@protocol LRWSearchTableViewControllerDelegate <NSObject>
@optional
/**
 cell被点击时候会会调用
 */
- (void)searchTableViewController:(LRWSearchTableViewController *)viewController didClickCell:(UITableViewCell *)cell searchType:(LRWSearchType)searchType;

@end