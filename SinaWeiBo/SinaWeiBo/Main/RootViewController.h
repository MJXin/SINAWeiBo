//
//  RootViewController.h
//  SinaWeiBo
//
//  Created by lrw on 15/2/10.
//  Copyright (c) 2015年 LMZ. All rights reserved.
//

#import <UIKit/UIKit.h>
@class StatuRequest,RequestStatuParma;
@interface RootViewController : UITabBarController
/**是否显示首页红点*/
- (void)showHomePagePoint:(BOOL)result;
/**显示首页*/
- (void)showHomePage;
/**开始检查最新微博*/
- (void)startExamineRequest:(StatuRequest *)request parma:(RequestStatuParma *)parma;
@end
