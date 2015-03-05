//
//  AppDelegate.m
//  SinaWeiBo
//
//  Created by mjx on 15/2/4.
//  Copyright (c) 2015年 LMZ. All rights reserved.
//


#import "AppDelegate.h"
#import "MenuController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "ShouyeViewController.h"
#import "LRWWeiBoUserTableViewController.h"
#import "LRWWeiBoKeyBoardToolBar.h"
#import "LRWPhotoAlbumViewController.h"
#import "DiscoverTableViewController.h"
#import "LRWGetAllImagesOrVideosFromIPhone.h"
#import "MessageViewController.h"
#import "SendStatuViewController.h"
#import "FriendShipsRequest.h"
#import "RequestUserParma.h"
#import "UserRequest.h"
#define MAppkey @"496450570"
#define MRedirectURL @"https://api.weibo.com/oauth2/default.html"
#define Mwbtoken @"2.00JCy8pB0QTDbXe7b457a65eHnLwDB"
#define MwbUserId @"1676391597"
#define Zwbtoken @"2.00QQgbnC7EgnqC2605fe88a8uNtL8B"
#define ZwbUserId @"2565286720"
#define Lwbtoken @"2.00O7zUkC0xqSi950cafee298oHacdC"
#define LwbUserId @"2519363070"
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#import "RootViewController.h"

@interface AppDelegate ()<LRWWeiBoKeyBoardToolBarDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,LRWPhotoAlbumViewControllerDelegate,FriendshipsRequestDelegate, UserRequestDelegate>
{
    UITabBarController *_tab;
    FriendShipsRequest *_friendShipsRequest;
    RequestFriendshipsParma *_friendshipsParma;
    ShouyeViewController *_shouyeViewController;
}
@end

@implementation AppDelegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [WeiboSDK enableDebugMode:YES];
    [WeiboSDK registerApp:MAppkey];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    RootViewController *rootViewController = [RootViewController new];
    _shouyeViewController = [ShouyeViewController new];
    UINavigationController *vc0 = [[UINavigationController alloc] initWithRootViewController:_shouyeViewController];
    vc0.navigationBar.tintColor = [UIColor blackColor];
    vc0.title = @"首页";
    UINavigationController *vc1 = [[UINavigationController alloc] initWithRootViewController:[MessageViewController new]];
    vc1.navigationBar.tintColor = [UIColor blackColor];
    vc1.title = @"消息";
    
    UINavigationController *vc2 = [[UINavigationController alloc] initWithRootViewController:[UIViewController new]];
    vc2.view.tag = 123456789;
    vc2.title = @" ";
    
    UINavigationController *vc3 = [[UINavigationController alloc]initWithRootViewController:[DiscoverTableViewController new]];
    vc3.navigationBar.tintColor = [UIColor blackColor];
    vc3.title = @"发现";
    
    UINavigationController *vc4 = [[UINavigationController alloc] initWithRootViewController:[LRWWeiBoUserTableViewController new]];
    vc4.navigationBar.tintColor = [UIColor blackColor];
    vc4.title = @"我";
    rootViewController.viewControllers = @[vc0,vc1,vc2,vc3,vc4];
    
    self.window.rootViewController = rootViewController;
    [self.window makeKeyAndVisible];
    
    //读本地登陆凭证
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    self.currentUID = [userDefaults objectForKey:@"UID"];
    self.currentAccessToken = [userDefaults objectForKey:@"AccessToken"];
    
//    self.currentUID = MwbUserId;
//    self.currentAccessToken = Mwbtoken;
    
//    self.currentUID = LwbUserId;
//    self.currentAccessToken = Lwbtoken;

//    self.currentUID = ZwbUserId;
//    self.currentAccessToken = Zwbtoken;
    
    [self requestUser];
    
    [self getIDS];
    return YES;
}

#pragma mark - 请求用户完整数据
-(void)requestUser
{
    if (self.currentAccessToken&&self.currentUID) {
        RequestUserParma* parma = [[RequestUserParma alloc]initWithAccess_token:self.currentAccessToken];
        parma.uid = self.currentUID;
        UserRequest* request = [[UserRequest alloc]init];
        request.delegate = self;
        [request UserRequestWithUserIdPramas:parma];
    }
}

#pragma mark - 请求用户的代理方法
-(void)UserRequestWithUserIddidFinishedWithUser:(User *)user error:(NSError *)error
{
    if (!error) {
        NSLog(@"用户数据请求成功");
        _currentUser = user;
    }
    else
    {
        NSLog(@"用户数据请求失败:%@",error);
    }
}

- (NSArray *)myFriendsID
{
    if (!_myFriendsID) {
    }
    return _myFriendsID;
}
- (void)getIDS
{
    _friendShipsRequest = [FriendShipsRequest new];
    _friendShipsRequest.delegate = self;
    _friendshipsParma = [[RequestFriendshipsParma alloc] initWithAccess_token:self.currentAccessToken];
    _friendshipsParma.count = @"200";
    [_friendShipsRequest FriendsIdRequestWithParma:_friendshipsParma];

}
- (void)FriendsIdRequestDidFinishedWithFriendShipsList:(FriendShipsList *)friendShipsList FriendsId:(NSArray *)usersId error:(NSError *)error
{
    NSMutableArray *ids = [NSMutableArray array];
    for (id object in usersId) {
        [ids addObject:[NSString stringWithFormat:@"%@",object]];
    }
    _myFriendsID = ids;
}

-(void)TurnToSendStatuController
{
    SendStatuViewController* sendStatu = [[SendStatuViewController alloc]init];
    [_tab presentViewController:sendStatu animated:YES completion:nil];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [WeiboSDK handleOpenURL:url delegate:self];
}
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return [WeiboSDK handleOpenURL:url delegate:self];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


- (void)didReceiveWeiboRequest:(WBBaseRequest *)request
{
    
}

- (void)didReceiveWeiboResponse:(WBBaseResponse *)response
{
    NSLog(@"请求完成");
    if ([response isKindOfClass:WBAuthorizeResponse.class])
    {
//        NSString *title = NSLocalizedString(@"认证结果", nil);
//        NSString *message = [NSString stringWithFormat:@"%@: %d\nresponse.userId: %@\nresponse.accessToken: %@\n%@: %@\n%@: %@", NSLocalizedString(@"响应状态", nil), (int)response.statusCode,[(WBAuthorizeResponse *)response userID], [(WBAuthorizeResponse *)response accessToken],  NSLocalizedString(@"响应UserInfo数据", nil), response.userInfo, NSLocalizedString(@"原请求UserInfo数据", nil), response.requestUserInfo];
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
//                                                        message:message
//                                                       delegate:nil
//                                              cancelButtonTitle:NSLocalizedString(@"确定", nil)
//                                              otherButtonTitles:nil];
//        
        self.currentAccessToken = [(WBAuthorizeResponse *)response accessToken];
        self.currentUID = [(WBAuthorizeResponse *)response userID];

        NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:self.currentUID forKey:@"UID"];
        [userDefaults setObject:self.currentAccessToken forKey:@"AccessToken"];
        [_shouyeViewController hideLoginView];
        
        [self requestUser];
//        [alert show];
    }

}


@end
