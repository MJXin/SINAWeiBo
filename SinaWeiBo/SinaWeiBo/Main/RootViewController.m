//
//  RootViewController.m
//  SinaWeiBo
//
//  Created by lrw on 15/2/10.
//  Copyright (c) 2015年 LMZ. All rights reserved.
//

#import "RootViewController.h"
#import "LRWImageTabBar.h"
#import "SendStatuViewController.h"
#import "Statu.h"
#import "StatuRequest.h"
#import "AppDelegate.h"
#import "ShouyeViewController.h"
@interface RootViewController ()<LRWImageTabBarDelegate,UITabBarControllerDelegate,StatuRequestDelegate>
{
    LRWImageTabBar *_imageBar;
    StatuRequest *_request;
    RequestStatuParma *_parma;
    NSTimer *_timer;
}
@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //覆盖原来的tabBar
    self.delegate = self;
    self.tabBar.tintColor = [UIColor orangeColor];
    _imageBar = [[LRWImageTabBar alloc] initWithFrame:self.tabBar.bounds];
    _imageBar.delegate = self;
    [self.tabBar addSubview:_imageBar];
    
    [_imageBar lrw_addTabBarButtonNormalImageName:@"tabbar_home" selectedImageName:@"tabbar_home_selected"];
    
    [_imageBar lrw_addTabBarButtonNormalImageName:@"tabbar_message_center" selectedImageName:@"tabbar_message_center_selected"];
    
    [_imageBar lrw_addTabBarButtonNormalImageName:@"wl_tabbar_compose_button" selectedImageName:@"wl_tabbar_compose_button_highlighted"];
    
    [_imageBar lrw_addTabBarButtonNormalImageName:@"tabbar_discover" selectedImageName:@"tabbar_discover_selected"];

    [_imageBar lrw_addTabBarButtonNormalImageName:@"tabbar_profile" selectedImageName:@"tabbar_profile_selected"];
}
- (void)startExamineRequest:(StatuRequest *)request parma:(RequestStatuParma *)parma
{
    _parma = parma;
    _request = [[StatuRequest alloc] init];
    _request.since_id = request.since_id;
    _request.delegate = self;
    _timer = [NSTimer scheduledTimerWithTimeInterval:10
                                              target:self
                                            selector:@selector(showRedPoint:) userInfo:nil
                                             repeats:NO];
}

- (void)showRedPoint:(id)timer
{
    [_request HaveNewDataWithPramas:_parma];
}
- (void)didfinishedHaveNewDataWithWithStatuList:(StatuList *)statulist ststus:(NSArray *)status error:(NSError *)error
{
    if (!error && status.count > 0) {
        [self showHomePagePoint:YES];
    }
}

- (void)showHomePagePoint:(BOOL)result
{
    if (result) {
        [_imageBar lrw_showRedPointAtIndexs:@[@0]];
    }
    else
    {
        [_imageBar lrw_showRedPointAtIndexs:nil];
    }
}
- (void)showHomePage
{
    [_imageBar lrw_selectTabBatButtonAtIndex:0];
    ShouyeViewController *homePageC = [[(UINavigationController *)self.childViewControllers.firstObject viewControllers] firstObject];
    [homePageC showLoginView];
}
#pragma mark - tabBarController 代理 判断item能否被点击
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    if (![(AppDelegate *)[[UIApplication sharedApplication] delegate] currentAccessToken]) {
        return;
    }
    if (item == self.tabBar.items[2]) {
        SendStatuViewController* sendStatu = [[SendStatuViewController alloc]init];
        [self presentViewController:sendStatu animated:YES completion:nil];
        return;
    }
    [_imageBar lrw_selectTabBatButtonAtIndex:(int)[self.tabBar.items indexOfObject:item]];
}

#pragma mark - tabBarController 代理 判断item能否被点击
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    if (![(AppDelegate *)[[UIApplication sharedApplication] delegate] currentAccessToken]) {
        return NO;
    }
    if (viewController.view.tag == 123456789) {
        return NO;
    }
    return YES;
}

- (void)lrw_tabBar:(LRWImageTabBar *)tabBar tabBarButtonIndexFrom:(NSInteger)from to:(NSInteger)to
{
    UIViewController *fromController = self.viewControllers[from];
    UIViewController *toController = self.viewControllers[to];
    fromController.tabBarController.tabBar.hidden = NO;
    fromController.hidesBottomBarWhenPushed = NO;
    toController.tabBarController.tabBar.hidden = NO;
    toController.hidesBottomBarWhenPushed = NO;
    if (to == 2) {
        
    }
    else
    {
        self.selectedIndex = to;
        //[_imageBar lrw_selectTabBatButtonAtIndex:to];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
