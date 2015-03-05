//
//  TableViewController.h
//  微博个人主页控制器
//
//  Created by lrw on 15/1/30.
//  Copyright (c) 2015年 LRW. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol LRWWeiBoUserHomePageTableViewControllerDelegate;
@interface LRWWeiBoUserHomePageTableViewController : UITableViewController
@property (nonatomic , weak) id<LRWWeiBoUserHomePageTableViewControllerDelegate> delegate;
/**设置背景图片*/
- (void)setBackgroundImage:(UIImage *)image;
/**设置用户头像*/
- (void)setUserIcon:(UIImage *)image;
/**设置vip图标*/
- (void)setVipIcon:(UIImage *)image;
/**设置性别图标*/
- (void)setSexIcon:(UIImage *)image;
/**设置用户名称*/
- (void)setScreenName:(NSString *)name;
/**设置粉丝标签内容*/
- (void)setShowFans:(NSString *)fans;
/**设置关注标签内容*/
- (void)setShowFocusOn:(NSString *)focusOn;
/**设置简介标签内容*/
- (void)setIntroduction:(NSString *)text;
/**显示中部旋转菊花*/
- (void)startCenterRefreshing;
/**隐藏中部旋转菊花*/
- (void)stopCenterRefreshing;
/**顶部开始刷新*/
- (void)startTopRefreshing;
/**顶部结束刷新*/
- (void)stopTopRefreshing;
/**底部开始刷新*/
- (void)startBottomRefreshing;
/**底部结束刷新*/
- (void)stopBottomRefreshing;
/**是否能够显示关注按钮*/
- (void)canClickFocusOnBtn:(BOOL)can;
/**点击关注按钮会调用这个方法，你要实现*/
- (void)focusOn:(UIButton *)btn;
@end

@protocol LRWWeiBoUserHomePageTableViewControllerDelegate <NSObject>
@optional
/**点击工具栏按钮触发方法*/
- (void)weiBoUserHomePageTableViewController:(LRWWeiBoUserHomePageTableViewController *)controller didClickBtnInToolBar:(NSInteger)index;
/**顶部刷新方法*/
- (void)weiBoUserHomePageTableViewControllerTopRefresing:(LRWWeiBoUserHomePageTableViewController *)controller;
/**底部刷新方法*/
- (void)weiBoUserHomePageTableViewControllerBottomRefresing:(LRWWeiBoUserHomePageTableViewController *)controller;

@end