//
//  ViewController.h
//  自定义refreshController
//
//  Created by lrw on 15/1/23.
//  Copyright (c) 2015年 LRW. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol LRWRefreshTableViewControllerDelegate;
@interface LRWRefreshTableViewController : UITableViewController
/**是否显示导航栏*/
@property (nonatomic, assign) BOOL showNavagationBar;
/**是否显示底部工具栏*/
@property (nonatomic, assign) BOOL showToolBar;
/**到达顶部和底部显示阴影的高度,默认是5*/
@property (nonatomic, assign) CGFloat shadowHeight;
/**阴影不透明度,默认是0.5*/
@property (nonatomic, assign) CGFloat shadowOpacity;
/**顶部视图字体,默认 systemFontOfSize:14*/
@property (nonatomic, strong) UIFont *topViewFont;
/**底部视图字体,默认 systemFontOfSize:11*/
@property (nonatomic, strong) UIFont *bottomViewFont;

@property (nonatomic , weak) id<LRWRefreshTableViewControllerDelegate> delegate;
/**显示顶部视图，并且进入加载状态*/
- (void)showTopView;
/**隐藏顶部视图，并且推出加载状态*/
- (void)hideTopView;
/**隐藏底部视图，并推出加载状态*/
- (void)hideBottomView;


@end

@protocol LRWRefreshTableViewControllerDelegate <NSObject>
@optional
/**顶部视图进入加载状态*/
- (void)refreshTableViewControllerHeadViewDidStartLoding:(LRWRefreshTableViewController *)tableViewController;
/**顶部视图退出加载状态*/
- (void)refreshTableViewControllerHeadViewDidEndLoding:(LRWRefreshTableViewController *)tableViewController;
/**底部视图进入加载状态*/
- (void)refreshTableViewControllerBottomViewDidStartLoding:(LRWRefreshTableViewController *)tableViewController;
/**底部视图退出加载状态*/
- (void)refreshTableViewControllerBottomViewDidEndLoding:(LRWRefreshTableViewController *)tableViewController;
@end


