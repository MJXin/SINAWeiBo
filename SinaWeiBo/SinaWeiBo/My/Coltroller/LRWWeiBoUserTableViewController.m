//
//  LRWWeiBoUserTableViewController.m
//  微博SDK测试
//
//  Created by lrw on 15/2/4.
//  Copyright (c) 2015年 LRW. All rights reserved.
//

#import "LRWWeiBoUserTableViewController.h"
#import "User.h"
#import "UIImageView+AFNetworking.h"
#import "AppDelegate.h"
#import "UserRequest.h"
#import "NSObject+PropertyMethod.h"
#import "LRWWeiBoUserPageTableViewControl.h"
#import "LRWWeiBoUserFriendsTableViewController.h"
#import "LRWWeiBoUserPhotosTableViewController.h"
#import "LRWWeiBoUserWeiBoTableViewController.h"
#import "LRWWeiBoUserFavoritTableViewController.h"
#import "RootViewController.h"
@interface LRWWeiBoUserTableViewController ()<UserRequestDelegate>
{
    __weak IBOutlet UIImageView *vipIcon;
    /**粉丝数*/
    __weak IBOutlet UILabel *fensiCountLabel;
    /**关注数*/
    __weak IBOutlet UILabel *guanzuCountLabel;
    /**微博数*/
    __weak IBOutlet UILabel *weiboCountLabel;
    /**用户简介*/
    __weak IBOutlet UILabel *userIntroduce;
    /**用户呢称*/
    __weak IBOutlet UILabel *userName;
    /**用户头像*/
    __weak IBOutlet UIImageView *userIcon;
    UIEdgeInsets _edge;
    BOOL _isLoading;
    UserRequest *_userRequest;
    RequestUserParma *_userParma;
}
- (IBAction)weiboClick:(UIButton *)sender;
- (IBAction)guanzhuClick:(UIButton *)sender;
- (IBAction)fensiClick:(UIButton *)sender;
@property (nonatomic, strong) User *user;

@end

@implementation LRWWeiBoUserTableViewController
- (instancetype)init
{
    self = [[UIStoryboard storyboardWithName:@"LRWWeiBoUserTableViewController" bundle:[NSBundle mainBundle]] instantiateInitialViewController];
    _edge = UIEdgeInsetsMake(64, 0, 44, 0);
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我";
    AppDelegate *appDelegate =  (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (appDelegate.currentUID) {
        if (_userRequest == nil) {
            _userRequest = [UserRequest new];
            _userParma = [[RequestUserParma alloc] initWithAccess_token:appDelegate.currentAccessToken];
            _userParma.uid = appDelegate.currentUID;
            _userRequest.delegate = self;
        }
        _isLoading = YES;
        [self showLoading];
        [_userRequest UserRequestWithUserIdPramas:_userParma];
    }
    else
    {
        
    }
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    self.hidesBottomBarWhenPushed = YES;
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:0];
    [self showLoading];
    self.hidesBottomBarWhenPushed = NO;
    self.tabBarController.tabBar.hidden = NO;
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
    self.hidesBottomBarWhenPushed = YES;
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self hideLoading];
    self.tableView.scrollEnabled = YES;
    self.tableView.contentInset = _edge;
}

- (void)UserRequestWithUserIddidFinishedWithUser:(User *)user error:(NSError *)error
{
    _isLoading = NO;
    [self hideLoading];
    if (!error) {
        self.user = user;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (IBAction)weiboClick:(UIButton *)sender {
    LRWWeiBoUserWeiBoTableViewController *controller = [[LRWWeiBoUserWeiBoTableViewController alloc] init];
    controller.showNavagationBar = YES;
    [self.navigationController pushViewController:controller animated:YES];
}

- (IBAction)guanzhuClick:(UIButton *)sender {
    LRWWeiBoUserFriendsTableViewController *controller = [[LRWWeiBoUserFriendsTableViewController alloc] initWithFriendShipStyle:LRWWeiBoFriendShipStyleAttention];
    controller.showNavagationBar = YES;
    [self.navigationController pushViewController:controller animated:YES];
}

- (IBAction)fensiClick:(UIButton *)sender {
    LRWWeiBoUserFriendsTableViewController *controller = [[LRWWeiBoUserFriendsTableViewController alloc] initWithFriendShipStyle:LRWWeiBoFriendShipStyleFans];
    controller.showNavagationBar = YES;
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark - 设置数据
- (void)setUser:(User *)user
{
    _user = user;
    //NSLog(@"%@",[user properties_aps]);
    NSURL *url = [NSURL URLWithString:user.profile_image_url];
    [userIcon setImageWithURL:url];
    userName.text = user.screen_name;
    userIntroduce.text = user.Description;
    weiboCountLabel.text = [NSString stringWithFormat:@"%ld",user.statuses_count];
    guanzuCountLabel.text = [NSString stringWithFormat:@"%ld",user.friends_count];
    fensiCountLabel.text = [NSString stringWithFormat:@"%ld",user.followers_count];
    NSInteger vipRank = user.mbrank.integerValue;

    NSString *vipIconName = vipRank ? [NSString stringWithFormat:@"common_icon_membership_level%ld",vipRank] :
    [NSString stringWithFormat:@"common_icon_membership_expired"];
    vipIcon.image = [UIImage imageNamed:vipIconName];
    //微博等级
    UITableViewCell *weibodengjicell = (UITableViewCell *)[self.tableView viewWithTag:4];
    weibodengjicell.textLabel.text = [NSString stringWithFormat:@"微博等级 Lv%@",user.urank];
}

#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10.0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1.0;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    switch (cell.tag) {
        case 1:
        {
            if (_user) {
                LRWWeiBoUserPageTableViewControl *userPageTableViewController = [LRWWeiBoUserPageTableViewControl new];
                userPageTableViewController.user = _user;
                [self.navigationController pushViewController:userPageTableViewController animated:YES];
            }
        }
            break;
        case 3:
        {
            LRWWeiBoUserFriendsTableViewController *controller = [[LRWWeiBoUserFriendsTableViewController alloc] initWithFriendShipStyle:LRWWeiBoFriendShipStyleFriends];
            controller.showNavagationBar = YES;
            [self.navigationController pushViewController:controller animated:YES];
        }
            break;
        case 6:
        {
            LRWWeiBoUserPhotosTableViewController *controller = [[LRWWeiBoUserPhotosTableViewController alloc] initWithIndex:0];
            controller.showNavagationBar = YES;
            [self.navigationController pushViewController:controller animated:YES];
        }
            break;
        case 7:
        {
            LRWWeiBoUserFavoritTableViewController *controller = [LRWWeiBoUserFavoritTableViewController new];
            controller.showNavagationBar = YES;
            [self.navigationController pushViewController:controller animated:YES];
        }
            break;
        case 12:
        {
            [(AppDelegate *)[[UIApplication sharedApplication] delegate] setCurrentAccessToken:nil];
            NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
            [userDefaults setObject:nil forKey:@"UID"];
            [userDefaults setObject:nil forKey:@"AccessToken"];

            RootViewController *rootViewController = (RootViewController *)[self.view.window rootViewController];
            [rootViewController showHomePage];
        }
            break;
        default:
            break;
    }
}
#pragma mark - 显示网络加载状态
- (void)showLoading
{
    if (_isLoading) {
       [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    }
}
#pragma mark - 隐藏网络加载状态
- (void)hideLoading
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}
@end
