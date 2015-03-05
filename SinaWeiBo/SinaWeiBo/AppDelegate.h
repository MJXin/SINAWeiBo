//
//  AppDelegate.h
//  SinaWeiBo
//
//  Created by mjx on 15/2/4.
//  Copyright (c) 2015年 LMZ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeiboSDK.h"

@class User;

@interface AppDelegate : UIResponder <UIApplicationDelegate,WeiboSDKDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, copy) NSString *currentUID;
@property (nonatomic, copy) NSString *currentAccessToken;
@property (nonatomic, strong) NSArray *myFriendsID;
@property (nonatomic, strong)User* currentUser;

@end

