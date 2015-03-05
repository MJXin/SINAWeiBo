//
//  LRWWeiBoDropDownListView.h
//  下拉列表
//
//  Created by lrw on 15/1/28.
//  Copyright (c) 2015年 LRW. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol LRWWeiBoDropDownListViewDelegate;
@interface LRWWeiBoDropDownListView : UIImageView
@property (nonatomic , weak) id<LRWWeiBoDropDownListViewDelegate> delegate;
/**
 为下拉列表传入数据,
 数组里面是一个字典,一个字典代表一个分组数据
 格式: @{@"title" : @"one group",@"rows" : @[@"1",@"2","3"]}
 title表示分组名称，rows表示分组里面的数据，只能为字符串
 */
@property (nonatomic, strong) NSArray *listData;
/**是否显示工具栏,默认是NO*/
@property (nonatomic, assign) BOOL showToolBar;
@property (nonatomic, strong) NSString *toolBarTitle;
@property (nonatomic, assign) CGFloat toolBarHeight;
@property (nonatomic, strong) UIFont *toolBarFont;
@property (nonatomic, strong) UIColor *toolBarTextColor;
- (void)selectGroup:(NSInteger)group row:(NSInteger)row;
@end



@protocol LRWWeiBoDropDownListViewDelegate <NSObject>
@optional
/**下拉列表某一行被点击*/
- (void)weiboDropDownListView:(LRWWeiBoDropDownListView *)listView didSelectedRowInGroup:(NSInteger)group row:(NSInteger)row text:(NSString *)text;
/**点击工具栏*/
- (void)weiboDropDownListViewDidClickToolBar:(LRWWeiBoDropDownListView *)listView ;
@end