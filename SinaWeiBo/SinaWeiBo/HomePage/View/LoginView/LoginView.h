//
//  LoginView.h
//  SinaWeiBo
//
//  Created by lrw on 15/2/27.
//  Copyright (c) 2015年 LMZ. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol  LoginViewDelegate;
@interface LoginView : UIView
@property (nonatomic, assign) id<LoginViewDelegate> delegate;
@end

@protocol  LoginViewDelegate<NSObject>
@optional
/**登录按钮被点击*/
- (void)loginViewLoginBtnClick:(LoginView *)sender;
@end