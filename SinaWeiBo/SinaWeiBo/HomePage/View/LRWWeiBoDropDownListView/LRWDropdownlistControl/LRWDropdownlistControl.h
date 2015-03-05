//
//  LRWDropdownlistControl.h
//  下拉列表
//
//  Created by lrw on 15/1/28.
//  Copyright (c) 2015年 LRW. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol LRWDropdownlistControlDelegate;
@interface LRWDropdownlistControl : UITableViewController
@property (nonatomic , weak) id<LRWDropdownlistControlDelegate> delegate;
/**
 为下拉列表传入数据,
 数组里面是一个字典,一个字典代表一个分组数据
 格式: @{@"title" : @"one group",@"rows" : @[@"1",@"2","3"]}
 title表示分组名称，rows表示分组里面的数据，只能为字符串
 */
- (void)setData:(NSArray *)listData;
- (void)selectedRowInNSIndexPath:(NSIndexPath *)indexPath;
@end

@protocol LRWDropdownlistControlDelegate <NSObject>
@optional
/**哪一行被点击*/
- (void)dropdownlistControl:(LRWDropdownlistControl *)listControl didSelectedRowInGroup:(NSInteger)group row:(NSInteger)row;
@end