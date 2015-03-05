//
//  LRWWeiBoUserPageTableViewControl.m
//  微博SDK测试
//
//  Created by lrw on 15/1/30.
//  Copyright (c) 2015年 LRW. All rights reserved.
//
#define BACKGROUNDCOLOR [UIColor colorWithRed:239/255.0 green:239/255.0 blue:244/255.0 alpha:1]
#define HOMEPAGECELLHEIGHT 50//首页cell高度
#import "LRWWeiBoUserPageTableViewControl.h"
#import "UserRequest.h"
#import "LRWWeiBoCell.h"
#import "StatusFrame.h"
#import "Statu.h"
#import "StatuRequest.h"
#import "RequestStatuParma.h"
#import "LRWWeiBoContentView.h"
#import "AppDelegate.h"
#import "LRWWeiBoShowImageController.h"
#import "LRWWeiBoPresentAnimation.h"
#import "LRWWeiBoDismissAnimation.h"
#import "LRWWeiBoUserPageHomePageCell.h"
#import "NSObject+PropertyMethod.h"
#import "LRWWeiBoImagesCell.h"
#import "LRWWeiBoImageToStatu.h"
#import "LRWSearchTableViewController.h"
#import "LRWWeiBoWebController.h"
#import "FriendShipsRequest.h"
#import "SendCommentController.h"
#import "StatuDetialViewController.h"
@interface LRWWeiBoUserPageTableViewControl ()<NSURLConnectionDataDelegate,LRWWeiBoCellDelegate,LRWWeiBoUserHomePageTableViewControllerDelegate,StatuRequestDelegate,UserRequestDelegate,UIViewControllerTransitioningDelegate,LRWWeiBoImagesCellDelegate,FriendshipsRequestDelegate>
{
    LRWWeiBoPresentAnimation *_presentAnimation;
    LRWWeiBoDismissAnimation *_dismissAnimation;
    //用户头像
    NSMutableData *_userImageData;
    NSURLConnection *_userConnection;
    //背景图片
    NSMutableData *_backgroundImageData;
    NSURLConnection *_backgroundConnection;
    
    NSMutableArray *_statusesArray;
    NSMutableArray *_cellsFrameArray;
    NSMutableArray *_allImagesArray;
    StatuRequest *_statuRquest;
    RequestStatuParma *_parma;
    FriendShipsRequest *_friendsRquest;
    RequestFriendshipsParma *_friendsParma;
    //显示第几个选项卡
    NSInteger _btnIndex;
    
    //是否显示最后加载
    BOOL _showBottomLoading;
    //是否显示最新加载
    BOOL _showTopLoading;
    
    //请求用户信息
    UserRequest *_userRequest;
    RequestUserParma *_userParma;
}
@end

@implementation LRWWeiBoUserPageTableViewControl
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = BACKGROUNDCOLOR;
    //初始化动画效果
    _presentAnimation = [LRWWeiBoPresentAnimation new];
    _dismissAnimation = [LRWWeiBoDismissAnimation new];
    self.delegate = self;
    _statusesArray = [NSMutableArray array];
    _cellsFrameArray = [NSMutableArray array];
    _allImagesArray = [NSMutableArray array];
    _btnIndex = 1;
    self.tableView.separatorStyle = UITableViewScrollPositionNone;
    
    //初始化关注方法
    _friendsRquest = [FriendShipsRequest new];
    _friendsRquest.delegate = self;
    AppDelegate *appDelegate =  (AppDelegate *)[[UIApplication sharedApplication] delegate];
    _friendsParma = [[RequestFriendshipsParma alloc] initWithAccess_token:appDelegate.currentAccessToken];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setUserName:(NSString *)userName
{
    _userName = userName;
    AppDelegate *appDelegate =  (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (appDelegate.currentUID) {
        if (_userRequest == nil) {
            _userRequest = [UserRequest new];
            _userParma = [[RequestUserParma alloc] initWithAccess_token:appDelegate.currentAccessToken];
            _userRequest.delegate = self;
        }
        _userParma.screen_name = userName;
        [_userRequest UserRequestWithUserIdPramas:_userParma];
    }
    else
    {
        
    }
}

- (void)setUser:(User *)user
{
    _user = user;

    for (NSString *userID in ((AppDelegate *)[[UIApplication sharedApplication] delegate]).myFriendsID) {
        if ([userID isEqualToString:user.idstr]) {
            [self canClickFocusOnBtn:NO];
        }
    }
    NSString *backgroundImageURLStr;
    if (user.cover_image_phone) {
        backgroundImageURLStr = [NSString stringWithFormat:@"%@",user.cover_image_phone];
    }
    else
    {
        backgroundImageURLStr =  @"http://ww1.sinaimg.cn/crop.0.0.640.640/549d0121tw1egm1kjly3jj20hs0hsq4f.jpg";
    }
    [self setUpBackgroundImage:[NSURL URLWithString:backgroundImageURLStr]];
    
    [self setScreenName:user.screen_name];
    [self setIntroduction:user.Description];
    [self setShowFans:[NSString stringWithFormat:@"%ld",user.followers_count]];
    [self setShowFocusOn:[NSString stringWithFormat:@"%ld",user.friends_count]];
    [self setUpUserImage:[NSURL URLWithString:user.profile_image_url]];
    NSString *sexImageName = [user.gender isEqualToString:@"f"] ? @"list_female" : @"list_male";
    [self setSexIcon:[UIImage imageNamed:sexImageName]];
    NSInteger vipRank = user.mbrank.integerValue;
    NSString *vipIconName = vipRank ? [NSString stringWithFormat:@"common_icon_membership_level%ld",user.mbrank.integerValue] :
    [NSString stringWithFormat:@"common_icon_membership_expired"];
    [self setVipIcon:[UIImage imageNamed:vipIconName]];
    [self getHomePage];
}

- (void)setUpUserImage:(NSURL *)imageUrl
{
    NSURLRequest *request = [NSURLRequest requestWithURL:imageUrl];
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:NO];
    _userConnection = connection;
    [connection start];
}
- (void)setUpBackgroundImage:(NSURL *)imageUrl
{
    NSURLRequest *request = [NSURLRequest requestWithURL:imageUrl];
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:NO];
    _backgroundConnection = connection;
    [connection start];
}


- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    if (!_userImageData) {
        _userImageData = [NSMutableData data];
    }
    if (!_backgroundImageData) {
        _backgroundImageData = [NSMutableData data];
    }
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    if (connection == _userConnection) {
        [_userImageData appendData:data];
    }
    else if (connection == _backgroundConnection)
    {
        [_backgroundImageData appendData:data];
    }
    
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    if (connection == _userConnection) {
        UIImage *image = [UIImage imageWithData:_userImageData];
        [self setUserIcon:image];
    }
    else if (connection == _backgroundConnection)
    {
        UIImage *image = [UIImage imageWithData:_backgroundImageData];
        [self setBackgroundImage:image];
    }
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


#pragma mark - 表视图 数据源
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
    return _statusesArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _statusesArray.count;
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (_showTopLoading && indexPath.row == 0) {
        return [self createTopLoadingCell:tableView];
    }
    if (_showBottomLoading && indexPath.row == _statusesArray.count - 1) {
        return [self createBtoomLoadingCell:tableView];
    }


    if (_btnIndex == 0) {
        NSDictionary *dic = _statusesArray[indexPath.row];
        NSString *ID = @"user_page_home_page_cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (cell == nil) {
            cell = [[LRWWeiBoUserPageHomePageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        }
        [(LRWWeiBoUserPageHomePageCell *)cell name].text = dic.allKeys.firstObject;
        [(LRWWeiBoUserPageHomePageCell *)cell value].text = dic[dic.allKeys.firstObject];
        return cell;
    }
    else if (_btnIndex == 1) {
        LRWWeiBoCell *weiboCell = [LRWWeiBoCell cellWithTableView:tableView];
        weiboCell.weiboContentView.status = _statusesArray[indexPath.row];
        weiboCell.weiboContentView.statusFrame = _cellsFrameArray[indexPath.row];
        weiboCell.delegate = self;
        return weiboCell;
    }
    else{
        LRWWeiBoImagesCell *cell = [tableView dequeueReusableCellWithIdentifier:@"weibo_images_cell"];
        if (cell == nil) {
            cell = [LRWWeiBoImagesCell new];
            cell.delegate = self;
        }
        cell.dataArray = _statusesArray[indexPath.row];
        cell.backgroundColor = BACKGROUNDCOLOR;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}





#pragma mark - 表视图 代理

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_showTopLoading && indexPath.row == 0) {
        return 30;//显示顶部加载
    }
    if (_showBottomLoading && indexPath.row == _statusesArray.count - 1) {
        return 30;//显示底部加载
    }
    
    
    
    if (_btnIndex == 0) {
        return HOMEPAGECELLHEIGHT;
    }
    else if (_btnIndex == 1)
    {
        StatusFrame *frames = _cellsFrameArray[indexPath.section];
        frames = _cellsFrameArray[indexPath.row];

        return frames.cellHeight + 10;
    }
    else
    {
        return (self.tableView.bounds.size.width - 4) / 3.0;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selected = NO;
}

#pragma mark - 关注按钮的方法
static bool focusOnBtnCanClick = YES;
- (void)focusOn:(UIButton *)btn
{
    if (!focusOnBtnCanClick) {
        return;
    }
    NSString *title = [btn titleForState:(UIControlStateNormal)];
    if ([title isEqualToString:@"关注"]) {
        [self canClickFocusOnBtn:NO];
        //发送关注
        _friendsParma.uid = _user.idstr;
        [_friendsRquest CreatFriendshipsWriteWithParma:_friendsParma];
    }
    else
    {
        [self canClickFocusOnBtn:YES];
        _friendsParma.uid = _user.idstr;
        [_friendsRquest DestroyfriendshipsWriteWithParma:_friendsParma];
        //取消关注
    }
    focusOnBtnCanClick = NO;
}
- (void)CreatFriendshipsWriteDidFinishedWithUser:(User *)user error:(NSError *)error
{
    if (error) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"失败" message:error.localizedDescription delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
        [self canClickFocusOnBtn:YES];
    }
    focusOnBtnCanClick = YES;
}
- (void)DestroyfriendshipsWriteDidFinishedWithUser:(User *)user error:(NSError *)error
{
    if (error) {
        NSLog(@"%@",error.userInfo);
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"失败" message:error.localizedDescription delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];

        [self canClickFocusOnBtn:NO];
    }
    focusOnBtnCanClick = YES;
}


#pragma mark - 主页代理方法
- (void)weiBoUserHomePageTableViewController:(LRWWeiBoUserHomePageTableViewController *)controller didClickBtnInToolBar:(NSInteger)index
{
    _btnIndex = index;
    [_statusesArray removeAllObjects];
    [_cellsFrameArray removeAllObjects];
    [self.tableView reloadData];
    [self getHomePage];
}
- (void)weiBoUserHomePageTableViewControllerTopRefresing:(LRWWeiBoUserHomePageTableViewController *)controller
{
    NSLog(@"开始顶部刷新");
    if (_btnIndex == 0)
    {
        [self stopTopRefreshing];
        return;
    }
    [self showTopLoadingCell];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (_statusesArray.count != 0) {
            [_statuRquest RefreshNewDataWithPramas:_parma];
        }
        else
        {
            [self getHomePage];
        }
    });
}

- (void)weiBoUserHomePageTableViewControllerBottomRefresing:(LRWWeiBoUserHomePageTableViewController *)controller
{
    NSLog(@"开始底部刷新");
    if (_btnIndex == 0)
    {
        [self stopBottomRefreshing];
        return;
    }
    [self showBottomLoadingCell];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        _parma.page = [NSString stringWithFormat:@"%ld",[_parma.page integerValue] + 1];
        [_statuRquest RefreshNextPageDataWithPramas:_parma];
    });
}

#pragma mark 创建顶部加载视图
- (UITableViewCell *)createTopLoadingCell:(UITableView *)tableView;
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"top_loading_cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"top_loading_cell"];
        cell.backgroundColor = [UIColor clearColor];
    }
    UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:(UIActivityIndicatorViewStyleGray)];
    [activityView startAnimating];
    activityView.center = CGPointMake(tableView.bounds.size.width * 0.5 - 0.5 * activityView.bounds.size.width, 15);
    [cell.contentView addSubview:activityView];
    UILabel *label = [UILabel new];
    label.text = @"正在更新...";
    label.font = [UIFont systemFontOfSize:10];
    label.frame = CGRectMake(tableView.bounds.size.width * 0.5, 0, 50, 30);
    [cell.contentView addSubview:label];
    return cell;
}
- (void)showTopLoadingCell
{
    _showTopLoading = YES;
    [_statusesArray insertObject:@"" atIndex:0];
    [_cellsFrameArray insertObject:@"" atIndex:0];
    [self.tableView reloadData];
 
}
#pragma mark 创建底部加载视图
- (UITableViewCell *)createBtoomLoadingCell:(UITableView *)tableView;
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"bottom_loading_cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"bottom_loading_cell"];
        cell.backgroundColor = [UIColor clearColor];
    }
    UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:(UIActivityIndicatorViewStyleGray)];
    [activityView startAnimating];
    activityView.center = CGPointMake(tableView.bounds.size.width * 0.5 - 0.5 * activityView.bounds.size.width, 15);
    [cell.contentView addSubview:activityView];
    UILabel *label = [UILabel new];
    label.text = @"加载中...";
    label.font = [UIFont systemFontOfSize:11];
    label.frame = CGRectMake(tableView.bounds.size.width * 0.5, 0, 50, 30);
    [cell.contentView addSubview:label];
    return cell;
}
- (void)showBottomLoadingCell
{
    _showBottomLoading = YES;
    [_statusesArray addObject:@""];
    [_cellsFrameArray addObject:@""];
    [self.tableView reloadData];

}

#pragma mark - 获取数据方法
#pragma mark 获取微博数据
- (void)getHomePage
{
    [self startCenterRefreshing];
    AppDelegate *appDelegate =  (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (appDelegate.currentUID) {
        if (_statuRquest == nil) {
            _statuRquest = [StatuRequest new];
            _parma = [[RequestStatuParma alloc] initWithAccess_token:appDelegate.currentAccessToken];
            _statuRquest.delegate = self;
        }
        
        //判断调用哪个接口
        switch (_btnIndex) {
            case 0:{
                [_statusesArray addObjectsFromArray:@[@{@"呢称" : _user.screen_name ? _user.screen_name : @""},
                                                      @{@"备注" : _user.remark ? [NSString stringWithFormat:@"%@",_user.remark] : @""},
                                                      @{@"性别" : [_user.gender isEqualToString:@"m"] ? @"男" : @"女"},
                                                      @{@"所在地" : [_user properties_aps][@"location"]},
                                                      @{@"简介" : _user.Description ? _user.Description : @""},
                                                      @{@"信用积分" : _user.credit_score ? [NSString stringWithFormat:@"%@",_user.credit_score] : @""},
                                                      @{@"注册时间" : [NSString stringWithFormat:@"%@",_user.created_at]}]];
                [self.tableView reloadData];
                [self stopCenterRefreshing];
            }
                break;
            case 1:{
                _parma.feature = @"0";
                _parma.page = @"1";
                [_statuRquest User_timelineDataRequestWithPramas:_parma];
            }
                break;
            case 2:{
                _parma.feature = @"2";
                _parma.page = @"1";
                [_statuRquest User_timelineDataRequestWithPramas:_parma];
            }
                break;
            default:
                break;
        }
    }
    else
    {
        
    }
}

#pragma mark - 接收数据回调方法
/**根据图片数组修改数据源*/
- (void)updateStatusArrayByImagesArray
{
    [_statusesArray removeAllObjects];
    NSMutableArray *aCellData = [NSMutableArray array];
    for (NSInteger index = 0; index < _allImagesArray.count ; ++index) {
        [aCellData addObject:_allImagesArray[index]];
        if ((index + 1) % 3 == 0) {
            [_statusesArray addObject:aCellData];
            aCellData = [NSMutableArray array];
        }
    }
    if (aCellData.count < 3 && aCellData.count > 0) {
        [_statusesArray addObject:aCellData];
    }
}


- (void)didFinishedUser_timelineDataRequestWithStatuList:(StatuList *)statulist ststus:(NSArray *)status error:(NSError *)error
{
    if (_btnIndex == 0) {
        return;
    }
    [self stopCenterRefreshing];
    if (error) {
        NSLog(@"加载首页%@",error);
    }
    else
    {
        NSLog(@"刷新了%ld条数据",status.count);
        if (_btnIndex == 1) {
            for (Statu *aStatu in status) {
                StatusFrame *frames = [StatusFrame new];
                frames.status = aStatu;
                [_cellsFrameArray addObject:frames];
                aStatu.user = _user;
            }
            [_statusesArray addObjectsFromArray:status];
        }
        else
        {
            [_allImagesArray removeAllObjects];
            for (Statu *aStatu in status) {
                for (NSString *url in aStatu.pic_urls) {
                    [_allImagesArray addObject:[LRWWeiBoImageToStatu image:url statu:aStatu]];
                }
            }
            [self updateStatusArrayByImagesArray];
        }
        [self.tableView reloadData];
    }
}
- (void)didfinishedRefreshNewDataWithStatuList:(StatuList *)statulist ststus:(NSArray *)status error:(NSError *)error
{
    if (_btnIndex == 0) {
        return;
    }
    [self stopTopRefreshing];
    _showTopLoading = NO;
    [_cellsFrameArray removeObjectAtIndex:0];
    [_statusesArray removeObjectAtIndex:0];
    if (error) {
        NSLog(@"加载最新%@",error);
    }
    else
    {
        NSLog(@"跟新了%ld条数据",status.count);
        if (_btnIndex == 1) {
            for (Statu *aStatu in status) {
                aStatu.user = _user;
                StatusFrame *frames = [StatusFrame new];
                frames.status = aStatu;
                [_cellsFrameArray insertObject:frames atIndex:0];
                [_statusesArray insertObject:aStatu atIndex:0];
            }
        }
        else
        {
            for (Statu *aStatu in status) {
                aStatu.user = _user;
                for (NSString *url in aStatu.pic_urls) {
                    [_allImagesArray insertObject:[LRWWeiBoImageToStatu image:url statu:aStatu] atIndex:0];
                }
            }
            [self updateStatusArrayByImagesArray];
        }
        [self.tableView reloadData];
    }
}

- (void)didfinishedRefreshNextPageDataWithStatuList:(StatuList *)statulist ststus:(NSArray *)status error:(NSError *)error
{
    if (_btnIndex == 0) {
    return;
    }
    [self stopBottomRefreshing];
    _showBottomLoading = NO;
    [_cellsFrameArray removeLastObject];
    [_statusesArray removeLastObject];
    if (error) {
        NSLog(@"下一页%@",error);
    }
    else
    {
        NSLog(@"加载下一页%ld条数据",status.count);
        if (_btnIndex == 1) {
            for (Statu *aStatu in status) {
                aStatu.user = _user;
                StatusFrame *frames = [StatusFrame new];
                frames.status = aStatu;
                [_cellsFrameArray addObject:frames];
                [_statusesArray addObject:aStatu];
            }
        }
        else
        {
            for (Statu *aStatu in status) {
                aStatu.user = _user;
                for (NSString *url in aStatu.pic_urls) {
                    [_allImagesArray addObject:[LRWWeiBoImageToStatu image:url statu:aStatu]];
                }
            }
            [self updateStatusArrayByImagesArray];
        }
        [self.tableView reloadData];
    }
}

- (void)UserRequestWithUserIddidFinishedWithUser:(User *)user error:(NSError *)error
{
    if (error) {
        NSLog(@"获取用户基本信息失败%@",error);
    }
    else
    {
        self.user = user;
    }
}


#pragma mark - 微博图片cell代理方法
-(void)weiBoCell:(LRWWeiBoCell *)cell didClickText:(LRWStringAndRangAndType *)srt
{
    switch (srt.strType) {
        case LRWSTringType_AT://@
        {
            NSMutableString *userName = [NSMutableString stringWithString:srt.string];
            [userName replaceOccurrencesOfString:@"@" withString:@"" options:0 range:NSMakeRange(0, 1)];
            LRWWeiBoUserPageTableViewControl *userPageController = [LRWWeiBoUserPageTableViewControl new];
            userPageController.userName = userName;
            [self.navigationController pushViewController:userPageController animated:YES];
        }
            break;
        case LRWSTringType_TOPIC://##
        {
            //[self.navigationController pushViewController:[LRWWeiBoSearchTableViewController new] animated:YES];
            
            LRWSearchTableViewController *searchControl = [[LRWSearchTableViewController alloc] initWithType:LRWSearchTypeTopic];
            [self.navigationController pushViewController:searchControl animated:YES];
            
        }
            break;
        case LRWSTringType_URL://URL
        {
            NSString *urlString = srt.string;
            LRWWeiBoWebController *webControl = [LRWWeiBoWebController new];
            webControl.urlString = urlString;
            [self.navigationController pushViewController:webControl animated:YES];
        }
            
            break;
        default:
            break;
    }
}
- (void)weiBoCell:(LRWWeiBoCell *)cell didClickImageAtIndex:(NSInteger)index defaultImages:(NSArray *)defaultImages bmiddleImagesURL:(NSArray *)bmiddleImagesURL goodNmuber:(NSString *)goodNumber
{
    LRWWeiBoShowImageController *showViewController = [[LRWWeiBoShowImageController alloc]initWithSelectIndex:index
                                                                                                   goodNumber:goodNumber
                                                                                                defaultImages:defaultImages
                                                                                                    imagesURL:bmiddleImagesURL];
    showViewController.view.bounds = [[UIScreen mainScreen] bounds];
    showViewController.transitioningDelegate = self;
    [self presentViewController:showViewController animated:YES completion:^{
        [showViewController hideShadow];
    }];
}
- (void)weiBoCell:(LRWWeiBoCell *)cell didClickUserName:(User *)user
{
    return;
    LRWWeiBoUserPageTableViewControl *userPageController = [LRWWeiBoUserPageTableViewControl new];
    userPageController.user = user;
    [self.navigationController pushViewController:userPageController animated:YES];
}

- (void)weiBoCell:(LRWWeiBoCell *)cell didClickToolBarItemAtIndex:(NSInteger)index
{
    //点击工具栏会调用这方法
    if (index == 0) {
        SendCommentController* send = [[SendCommentController alloc]init];
        send.controllerType = WLRetweetedControllerType;
        send.placeholderText = @"说说你的分享心得...";
        send.statu = cell.weiboContentView.status;
        [self presentViewController:send animated:YES completion:nil];
    }
    else if(index == 1)
    {
        Statu* statu = cell.weiboContentView.status;
        if (statu.comments_count >0) {
            StatuDetialViewController* statuDVC = [[StatuDetialViewController alloc]initWithStatu:statu];
            //            UITabBarController *tab = [UITabBarController new];
            //            tab.viewControllers = @[statuDVC];
            statuDVC.showNavagationBar = YES;
            statuDVC.showToolBar = YES;
            self.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:statuDVC animated:YES];
        }
        else
        {
            SendCommentController* send = [[SendCommentController alloc]init];
            send.controllerType = WLCommentControllerType;
            send.placeholderText = @"写评论...";
            send.statu = cell.weiboContentView.status;
            [self presentViewController:send animated:YES completion:nil];
            //            [self.navigationController pushViewController:send animated:YES];
        }
        
    }
}

/**整个cell被点击方法*/
- (void)weiBoCell:(LRWWeiBoCell *)cell didClickCell:(Statu *)statu
{
    //    Statu* nStatu = [[Statu alloc]initWithDict:[statu dictaryValue]];
    //    nStatu.is_retweeted_status = NO;
    StatuDetialViewController* statuDVC = [[StatuDetialViewController alloc]initWithStatu:statu];
    statu.is_retweeted_status = NO;
    //            UITabBarController *tab = [UITabBarController new];
    //            tab.viewControllers = @[statuDVC];
    statuDVC.showNavagationBar = YES;
    statuDVC.showToolBar = YES;
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:statuDVC animated:YES];
}

#pragma mark - 模态视图动画
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    
    if ([presented isKindOfClass:[LRWWeiBoShowImageController class]]) {
        return _presentAnimation;
    }
    else
    {
        return nil;
    }
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    
    if ([dismissed isKindOfClass:[LRWWeiBoShowImageController class]]) {
        return _dismissAnimation;
    }
    else
    {
        return nil;
    }
}
@end
