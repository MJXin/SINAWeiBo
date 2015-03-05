//
//  LRWUserFriendsTableViewController.m
//  微博SDK测试
//
//  Created by lrw on 15/2/4.
//  Copyright (c) 2015年 LRW. All rights reserved.
//

#import "LRWWeiBoUserFriendsTableViewController.h"
#import "FriendShipsRequest.h"
#import "SuggestionsRequest.h"
#import "PlaceRequest.h"
#import "AppDelegate.h"
#import "UIImageView+AFNetworking.h"
#import "LRWWeiBoUserFriendsTableViewCell.h"
#import "LRWWeiBoUserPageTableViewControl.h"
@interface LRWWeiBoUserFriendsTableViewController ()<FriendshipsRequestDelegate,LRWRefreshTableViewControllerDelegate,SuggestionsRequestDelegate,PlaceRequestDelegate>
{
    RequestFriendshipsParma *_friendshipsParma;
    FriendShipsRequest *_friendshipsRequest;
    SuggestionsRequest *_suggestionRequest;
    RequestSuggestionParma *_suggestionParma;
    PlaceRequest *_placeRequest;
    RequestPlaceParma *_placeParma;
    BOOL _isTopLoading;
    BOOL _isBottomLoading;
    NSMutableArray *_usersArray;
    LRWWeiBoFriendShipStyle _friendShipStyle;
}
@end

@implementation LRWWeiBoUserFriendsTableViewController
- (instancetype)initWithFriendShipStyle:(LRWWeiBoFriendShipStyle)friendShipStyle
{
    if (self = [super initWithStyle:UITableViewStyleGrouped]) {
        _friendShipStyle = friendShipStyle;
    }
    return self;
}
- (instancetype)initWithStyle:(UITableViewStyle)style
{
    if (self = [super initWithStyle:UITableViewStyleGrouped]) {
        _friendShipStyle = LRWWeiBoFriendShipStyleFriends;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self showTopView];
    self.title = [self getControllerTitle:_friendShipStyle];
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - 获取数据
#pragma mark 获取最新数据
- (void)getNewData
{
    _isTopLoading = YES;
    AppDelegate *appDelegate =  (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (appDelegate.currentUID) {
        if (_friendshipsRequest == nil) {
            _friendshipsRequest = [FriendShipsRequest new];
            _friendshipsParma = [[RequestFriendshipsParma alloc] initWithAccess_token:appDelegate.currentAccessToken];
            _friendshipsParma.uid = appDelegate.currentUID;
            _friendshipsParma.suid = appDelegate.currentUID;
            _friendshipsRequest.delegate = self;
        }
        _friendshipsParma.page = @"1";
        if (_friendShipStyle == LRWWeiBoFriendShipStyleFriends) {
            [_friendshipsRequest FriendsInCommonRequestWithParma:_friendshipsParma];
        }
        else if (_friendShipStyle == LRWWeiBoFriendShipStyleFans)
        {
            [_friendshipsRequest FollowersRequestWithParma:_friendshipsParma];
        }
        else if(_friendShipStyle == LRWWeiBoFriendShipStyleAttention)
        {
            [_friendshipsRequest FriendsRequestWithParma:_friendshipsParma];
        }
        else if (_friendShipStyle == LRWWeiBoFriendShipStylePlace)
        {
            if (_placeRequest == nil) {
                PlaceRequest *request = [PlaceRequest new];
                _placeRequest = request;
                request.delegate = self;
                RequestPlaceParma *parma = [[RequestPlaceParma alloc]initWithAccess_token:appDelegate.currentAccessToken];
                _placeParma = parma;
                parma.page = @"1";
                parma.count = @"30";
                parma.Long = @"113.2550312019";
                parma.lat = @"23.1323049748";
            }
            [_placeRequest NearbyUsersRequestWithParma:_placeParma];
        }
        //下面是调用推荐类的不同方法
        else
        {
            if (!_suggestionRequest) {
                _suggestionRequest = [SuggestionsRequest new];
                _suggestionRequest.delegate = self;
                _suggestionParma = [[RequestSuggestionParma alloc]initWithAccess_token:appDelegate.currentAccessToken];
                [self changeRequestSuggestionParma:_friendShipStyle];
            }
            _suggestionParma.page = @"1";
            [_suggestionRequest HotUsersSuggestionRequestWithParma:_suggestionParma];
        }
    }
    else
    {
        
    }
}
- (void)getNextPageData
{
    _isBottomLoading = YES;
    AppDelegate *appDelegate =  (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (appDelegate.currentUID) {
        if (_friendshipsRequest == nil) {
            _friendshipsRequest = [FriendShipsRequest new];
            _friendshipsParma = [[RequestFriendshipsParma alloc] initWithAccess_token:appDelegate.currentAccessToken];
            _friendshipsParma.uid = appDelegate.currentUID;
            _friendshipsRequest.delegate = self;
        }
        _friendshipsParma.page = [NSString stringWithFormat:@"%ld",[_friendshipsParma.page integerValue] + 1];
        if (_friendShipStyle == LRWWeiBoFriendShipStyleFriends) {
            [_friendshipsRequest FriendsInCommonRequestWithParma:_friendshipsParma];
        }
        else if (_friendShipStyle == LRWWeiBoFriendShipStyleFans)
        {
            [_friendshipsRequest FollowersRequestWithParma:_friendshipsParma];
        }
        else if (_friendShipStyle == LRWWeiBoFriendShipStyleAttention)
        {
            [_friendshipsRequest FriendsRequestWithParma:_friendshipsParma];
        }
        else if (_friendShipStyle == LRWWeiBoFriendShipStylePlace)
        {
            _placeParma.page =[NSString stringWithFormat:@"%ld",[_placeParma.page integerValue] + 1];
            [_placeRequest NearbyUsersRequestWithParma:_placeParma];
        }
        else
        {
            _suggestionParma.page = [NSString stringWithFormat:@"%ld",[_suggestionParma.page integerValue] + 1];
            [_suggestionRequest HotUsersSuggestionRequestWithParma:_suggestionParma];
        }
    }
    else
    {
        
    }
}
#pragma mark 获取标题
/**根据LRWWeiBoFriendShipStyle属性设置控制器标题*/
- (NSString *)getControllerTitle:(LRWWeiBoFriendShipStyle)style
{
    NSString *title;
    switch (style) {
        case LRWWeiBoFriendShipStyleFriends:
            title = @"好友列表";
            break;
        case LRWWeiBoFriendShipStyleFans:
            title = @"粉丝列表";
            break;
        case LRWWeiBoFriendShipStyleAttention:
            title = @"关注列表";
            break;
        case LRWWeiBoFriendShipStyleSpecial:
            title = @"人气关注";
            break;
        case LRWWeiBoFriendShipStyleEnt:
            title = @"影视明星列表";
            break;
        case LRWWeiBoFriendShipStyleFashion:
            title = @"时尚列表";
            break;
        case LRWWeiBoFriendShipStyleCartoon:
            title = @"动漫列表";
            break;
        case LRWWeiBoFriendShipStyleBusiness:
            title = @"商界列表";
            break;
        case LRWWeiBoFriendShipStylePlace:
            title = @"附近的人";
        default:
            break;
    }
    return title;
}
#pragma mark - 获取周边的人
- (void)NearbyUsersRequestDidFinishedWithUsers:(NSArray *)users error:(NSError *)error
{
    BOOL isNew = [_friendshipsParma.page isEqualToString:@"1"];
    if (isNew) {
        [self hideTopView];
    }
    else
    {
        [self hideBottomView];
    }

    if (!error) {
        if (isNew) {
            _usersArray  = [NSMutableArray arrayWithArray:users];
        }
        else
        {
            [_usersArray addObjectsFromArray:users];
        }
        [self.tableView reloadData];
    }
}
#pragma mark - 根据Style修改RequestSuggestionParma的参数，请求不同的数据
/**根据Style修改RequestSuggestionParma的参数，请求不同的数据*/
- (void)changeRequestSuggestionParma:(LRWWeiBoFriendShipStyle)style
{
    switch (style) {
        case LRWWeiBoFriendShipStyleSpecial://人气关注
            _suggestionParma.category = @"default";
            break;
        case LRWWeiBoFriendShipStyleEnt://影视明星
            _suggestionParma.category = @"ent";
            break;
        case LRWWeiBoFriendShipStyleFashion://时尚
            _suggestionParma.category = @"fashion";
            break;
        case LRWWeiBoFriendShipStyleCartoon://动漫
            _suggestionParma.category = @"cartoon";
            break;
        case LRWWeiBoFriendShipStyleBusiness://商界
            _suggestionParma.category = @"business";
            break;
        default:
            break;
    }
}
#pragma mark - 通过SuggsetionRequset(推荐类) 获得人气关注、影视明星、体育、动漫、商界等数据
- (void)HotUsersSuggestionRequestDidFinishedWithUsers:(NSArray *)users error:(NSError *)error
{
    BOOL isNew = [_friendshipsParma.page isEqualToString:@"1"];
    if (isNew) {
        [self hideTopView];
    }
    else
    {
        [self hideBottomView];
    }
    
    if (_isBottomLoading && ![_friendshipsParma.page isEqualToString:@"1"]) {
        _isBottomLoading = NO;
        [self hideBottomView];
    }
    if (!error) {
        if (isNew) {
            _usersArray  = [NSMutableArray arrayWithArray:users];
        }
        else
        {
            [_usersArray addObjectsFromArray:users];
        }
        [self.tableView reloadData];
    }
}
#pragma mark - 关注列表
- (void)FriendsRequestDidFinishedWithFriendShipsList:(FriendShipsList *)friendShipsList Friends:(NSArray *)users error:(NSError *)error
{
    BOOL isNew = [_friendshipsParma.page isEqualToString:@"1"];
    if (isNew) {
        [self hideTopView];
    }
    else
    {
        [self hideBottomView];
    }
    
    if (_isBottomLoading && ![_friendshipsParma.page isEqualToString:@"1"]) {
        _isBottomLoading = NO;
        [self hideBottomView];
    }
    if (!error) {
        if (isNew) {
            _usersArray  = [NSMutableArray arrayWithArray:users];
        }
        else
        {
            [_usersArray addObjectsFromArray:users];
        }
        [self.tableView reloadData];
    }
}
#pragma mark - 好友列表
- (void)FriendsInCommonRequestDidFinishedWithFriendShipsList:(FriendShipsList *)friendShipsList Friends:(NSArray *)users error:(NSError *)error
{
    BOOL isNew = [_friendshipsParma.page isEqualToString:@"1"];
    if (isNew) {
        [self hideTopView];
    }
    else
    {
        [self hideBottomView];
    }
    
    if (_isBottomLoading && ![_friendshipsParma.page isEqualToString:@"1"]) {
        _isBottomLoading = NO;
        [self hideBottomView];
    }
    if (!error) {
        if (isNew) {
            _usersArray  = [NSMutableArray arrayWithArray:users];
        }
        else
        {
            [_usersArray addObjectsFromArray:users];
        }
        [self.tableView reloadData];
    }
}
#pragma mark - 粉丝列表
- (void)FollowersRequestDidFinishedWithFriendShipsList:(FriendShipsList *)friendShipsList Friends:(NSArray *)users error:(NSError *)error
{
    BOOL isNew = [_friendshipsParma.page isEqualToString:@"1"];
    if (isNew) {
        [self hideTopView];
    }
    else
    {
        [self hideBottomView];
    }
    
    if (_isBottomLoading && ![_friendshipsParma.page isEqualToString:@"1"]) {
        _isBottomLoading = NO;
        [self hideBottomView];
    }
    if (!error) {
        if (isNew) {
            _usersArray  = [NSMutableArray arrayWithArray:users];
        }
        else
        {
            [_usersArray addObjectsFromArray:users];
        }
        [self.tableView reloadData];
    }
}


#pragma mark - 刷新控制器代理方法
- (void)refreshTableViewControllerBottomViewDidStartLoding:(LRWRefreshTableViewController *)tableViewController
{
    [self getNextPageData];
}

- (void)refreshTableViewControllerHeadViewDidStartLoding:(LRWRefreshTableViewController *)tableViewController
{
   [self getNewData];
}


#pragma mark - Table view datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _usersArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LRWWeiBoUserFriendsTableViewCell *cell = [LRWWeiBoUserFriendsTableViewCell cellWithTableView:tableView];
    cell.user = _usersArray[indexPath.row];
    return cell;
}
#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1.0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LRWWeiBoUserFriendsTableViewCell *cell = (LRWWeiBoUserFriendsTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    LRWWeiBoUserPageTableViewControl * controller = [LRWWeiBoUserPageTableViewControl new];
    controller.user = cell.user;
    [self.navigationController pushViewController:controller animated:YES];
}
@end
