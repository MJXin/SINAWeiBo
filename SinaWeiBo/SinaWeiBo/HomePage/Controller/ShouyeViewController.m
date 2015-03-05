//
//  ShouyeViewController.m
//  微博SDK测试
//
//  Created by lrw on 14/12/26.
//  Copyright (c) 2014年 LRW. All rights reserved.
//
//AppRedirectURL:应用回调页,在进行 Oauth2.0 登录认证时所用。对于Mobile客户端应用来说,是不存在Server的,
//故此处的应用回调页地址只要与
//新浪微博开放平台-> 我的应用->应用信息->高级应用->授权设置->应用回调页中的url地址
//保持一致就可以了
#define kRedirectURI @"https://api.weibo.com/oauth2/default.html"
/**第三方应用申请的appkey，用来身份鉴证、显示来源等*/
#define kAppKey @"424296315"
#define StatutseCellID @"Statutse_Cell"
#define BACKGROUNDCOLOR [UIColor colorWithRed:239/255.0 green:239/255.0 blue:244/255.0 alpha:1]
#import "ShouyeViewController.h"
#import "LRWWeiBoImageViewController.h"
#import "LRWWeiBoShowImageController.h"
#import "WeiboSDK.h"
#import "AppDelegate.h"
#import "Status.h"
#import "StatusFrame.h"
#import "LRWWeiBoContentView.h"
#import "LRWWeiBoCell.h"
#import "LRWWeiBoPresentAnimation.h"
#import "LRWWeiBoDismissAnimation.h"
#import "StatuRequest.h"
#import "RequestStatuParma.h"
#import "LRWWeiBoDropDownListView.h"
#import "LRWWeiBoUserPageTableViewControl.h"
#import "LRWWeiBoWebController.h"
#import "LRWSearchTableViewController.h"
#import "SendCommentController.h"
#import "StatuDetialViewController.h"
#import "RootViewController.h"
#import "LoginView.h"
@interface ShouyeViewController ()<LRWWeiBoCellDelegate,UIViewControllerTransitioningDelegate,StatuRequestDelegate,LRWRefreshTableViewControllerDelegate,LRWWeiBoDropDownListViewDelegate,LoginViewDelegate>
{
    LRWWeiBoPresentAnimation *_presentAnimation;
    LRWWeiBoDismissAnimation *_dismissAnimation;
    StatuRequest *_statuRquest;
    RequestStatuParma *_parma;
    /**下拉列表*/
    LRWWeiBoDropDownListView *_dropDownListView;
    /**下拉列表数据*/
    NSArray *_dataList;
    NSString *_dropDownListSelectedText;
    /**导航栏标题按钮*/
    UIButton *_titleBtn;
    /**登录视图*/
    LoginView *_loginView;
}
@property (nonatomic, strong) NSMutableArray *statusesArray;
@property (nonatomic, strong) NSMutableArray *cellsFrameArray;
@end

@implementation ShouyeViewController
- (instancetype)initWithStyle:(UITableViewStyle)style
{
    if (self = [super initWithStyle:UITableViewStyleGrouped]) {
        
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //获取首页数据
    [self showTopView];
    self.showToolBar = YES;
    self.showNavagationBar = YES;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.backgroundColor = BACKGROUNDCOLOR;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //初始化动画效果
    _presentAnimation = [LRWWeiBoPresentAnimation new];
    _dismissAnimation = [LRWWeiBoDismissAnimation new];
    _dataList = @[
                  @{@"title" : @"",
                    @"rows" : @[@"首页",
                                @"好友圈",
                                @"微博群",
                                @"我的微博"]},
                  @{@"title" : @"我的分组",
                    @"rows" : @[@"特别关注",
                                @"名人明星",
                                @"同事",
                                @"教学",
                                @"媒体",
                                @"教学",
                                @"媒体"]},
                  @{@"title" : @"其他",
                    @"rows" : @[@"周边微博"]}
                  ];
    [self setUpDropDownListView];
    _dropDownListView.hidden = YES;
    #pragma mark 为导航栏标题添加点击方法,titleView必须是按钮
    [self createTitleBtn];
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    self.title = @"首页";
    
    //添加登录按钮
    [self createLoginView];
}

#pragma mark - 登录视图控制
- (void)createLoginView
{
    _loginView = [LoginView new];
    CGRect boundes = [[UIScreen mainScreen] bounds];
    _loginView.frame = CGRectMake(0, 0, boundes.size.width * 0.9, boundes.size.height * 0.4);
    _loginView.center = CGPointMake(boundes.size.width * 0.5, boundes.size.height * 0.4);
    _loginView.hidden = YES;
    _loginView.delegate = self;
    [self.tableView addSubview:_loginView];
}

#pragma mark - 登录视图代理方法
- (void)loginViewLoginBtnClick:(LoginView *)sender
{
    [self login];
}

#pragma mark - 隐藏/显示登录视图
- (void)hideLoginView
{
    _loginView.hidden = YES;
    self.tableView.bounces = YES;
    [self showTopView];
    [self getHomePage];
}
- (void)showLoginView
{
    self.statusesArray = nil;
    [self hideTopView];
    [self.tableView reloadData];
    _loginView.hidden = NO;
    self.tableView.bounces = NO;
}

#pragma mark - 创建导航栏标题按钮部视图
- (void)createTitleBtn
{
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 200, self.navigationController.navigationBar.bounds.size.height)];
    _titleBtn = btn;
    [btn setTitle:@"首页" forState:(UIControlStateNormal)];
    [btn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [btn addTarget:self action:@selector(titleBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.navigationItem.titleView addSubview:btn];
    self.navigationItem.titleView = btn;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:0];
    self.hidesBottomBarWhenPushed = NO;
    [[(UITabBarController *)self.view.window.rootViewController tabBar] setHidden:NO];
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.hidesBottomBarWhenPushed = YES;
}

- (void)refreshControlValueChange:(id)sender
{
    BOOL isRefreshing = self.refreshControl.isRefreshing;
    if (isRefreshing) {
        [self getHomePage];
    }
}

- (NSMutableArray *)statusesArray
{
    if (!_statusesArray) {
        _statusesArray  = [NSMutableArray arrayWithCapacity:100];
    }
    return _statusesArray;
}
- (NSMutableArray *)cellsFrameArray
{
    if (!_cellsFrameArray) {
        _cellsFrameArray = [NSMutableArray arrayWithCapacity:100];
    }
    return _cellsFrameArray;
    
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [self updateDropDownListFrame];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - 表视图 数据源
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
    return self.statusesArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.statusesArray.count;
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LRWWeiBoCell *weiboCell = [LRWWeiBoCell cellWithTableView:tableView];
    weiboCell.weiboContentView.status = self.statusesArray[indexPath.row];
    weiboCell.weiboContentView.statusFrame = self.cellsFrameArray[indexPath.row];
    weiboCell.delegate = self;
    return weiboCell;
}

#pragma makr - 表视图 代理

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    StatusFrame *frames = self.cellsFrameArray[indexPath.section];
    frames = self.cellsFrameArray[indexPath.row];
    return frames.cellHeight + 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1.0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1.0;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selected = NO;
}

#pragma mark - 导航栏标题按钮被点击方法
- (void)titleBtnClick:(UIButton *)btn
{
    _dropDownListView.hidden = !_dropDownListView.hidden;
}

#pragma mark - 创建下拉列表
- (void)setUpDropDownListView
{
    _dropDownListView = [LRWWeiBoDropDownListView new];
    _dropDownListView.listData = _dataList;
    _dropDownListView.delegate = self;
    _dropDownListView.showToolBar = YES;
    _dropDownListView.toolBarHeight = 20;
    _dropDownListView.toolBarTitle = @"编辑我的分组";
    _dropDownListView.toolBarFont = [UIFont systemFontOfSize:13];
    [self.view addSubview:_dropDownListView];
 [_dropDownListView selectGroup:0 row:0];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    if (!self.tableView.isDecelerating) {
         _dropDownListView.hidden = YES;
    }
}

#pragma mark - 跟新下拉列表的位置
- (void)updateDropDownListFrame
{
    CGRect navigationBarFrame = self.navigationController.navigationBar.frame;
    CGFloat w = 200;
    CGFloat h = 300;
    CGFloat x = CGRectGetWidth(navigationBarFrame) * 0.5 - 0.5 * w;
    CGFloat y = self.tableView.contentOffset.y + CGRectGetHeight(navigationBarFrame) + 15;
    _dropDownListView.frame = CGRectMake(x, y, w, h);
}

#pragma mark - 下拉列表代理方法
- (void)weiboDropDownListViewDidClickToolBar:(LRWWeiBoDropDownListView *)listView
{
    NSLog(@"下拉列表:工具栏点击");
    listView.hidden = YES;
}

- (void)weiboDropDownListView:(LRWWeiBoDropDownListView *)listView didSelectedRowInGroup:(NSInteger)group row:(NSInteger)row text:(NSString *)text
{
    [_titleBtn setTitle:text forState:(UIControlStateNormal)];
    _dropDownListSelectedText = text;
    listView.hidden = YES;
    [self.statusesArray removeAllObjects];
    [self.cellsFrameArray removeAllObjects];
    [self.tableView reloadData];
    [self showTopView];
}


#pragma mark - 微博方法
- (void)login
{
    NSLog(@"我的登录");
    WBAuthorizeRequest *request = [WBAuthorizeRequest request];
    request.redirectURI = kRedirectURI;
    request.scope = @"all";
//    request.userInfo = @{@"SSO_From": @"SendMessageToWeiboViewController",
//                         @"Other_Info_1": [NSNumber numberWithInt:123],
//                         @"Other_Info_2": @[@"obj1", @"obj2"],
//                         @"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
    [WeiboSDK sendRequest:request];
}

#pragma mark - 获取首页数据
- (void)getHomePage
{
    if (!_dropDownListSelectedText)
    {
        _dropDownListSelectedText = @"首页";
    }
    AppDelegate *appDelegate =  (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (appDelegate.currentUID) {
        if (_statuRquest == nil) {
            _statuRquest = [StatuRequest new];
            _parma = [[RequestStatuParma alloc] initWithAccess_token:appDelegate.currentAccessToken];
            _statuRquest.delegate = self;
        }
        
        //判断调用哪个接口
        if ([_dropDownListSelectedText isEqualToString:@"首页"]) {
           [_statuRquest Friends_timelineDataRequestWithPramas:_parma];
        }
        else if ([_dropDownListSelectedText isEqualToString:@"好友圈"])
        {
            [_statuRquest Bilateral_timelineDataRequestWithPramas:_parma];
        }
        else if ([_dropDownListSelectedText isEqualToString:@"我的微博"])
        {
            [_statuRquest User_timelineDataRequestWithPramas:_parma];
        }
        else
        {
           [_statuRquest Friends_timelineDataRequestWithPramas:_parma];
        }
    }
    else
    {
        //显示登录界面
        [self hideTopView];
        [_loginView setHidden:NO];
        [self.refreshControl endRefreshing];
        [self.tableView setBounces:NO];
    }
}


#pragma mark - 微博数据源代理方法
- (void)didFinishedFriends_timelineDataRequestWithStatuList:(StatuList *)statulist ststus:(NSArray *)status error:(NSError *)error
{
    if (_loginView.hidden == NO) {
        return;
    }
    if (error) {
        NSLog(@"加载首页%@",error);
        [self hideTopView];
    }
    else
    {
        [self hideTopView];
        [self.statusesArray removeAllObjects];
        [self.cellsFrameArray removeAllObjects];
        for (Statu *aStatu in status) {
            StatusFrame *frames = [StatusFrame new];
            frames.status = aStatu;
            [self.cellsFrameArray addObject:frames];
        }
        [self.statusesArray addObjectsFromArray:status];
        [self.tableView reloadData];
        [self showPoint];
    }
}

- (void)showPoint
{
    RootViewController *rootViewController = (RootViewController *)[self.view.window rootViewController];
    [rootViewController startExamineRequest:_statuRquest parma:_parma];
}

- (void)didfinishedRefreshNewDataWithStatuList:(StatuList *)statulist ststus:(NSArray *)status error:(NSError *)error
{
    [self hideTopView];
    if (error) {
        NSLog(@"加载最新%@",error);
    }
    else
    {
        NSLog(@"跟新了%ld条数据",status.count);
        RootViewController *rootViewController = (RootViewController *)self.view.window.rootViewController;
        [rootViewController showHomePagePoint:NO];
        for (Statu *aStatu in status) {
            StatusFrame *frames = [StatusFrame new];
            frames.status = aStatu;
            [self.cellsFrameArray insertObject:frames atIndex:0];
            [self.statusesArray insertObject:aStatu atIndex:0];
        }
        [self.tableView reloadData];
        [self showPoint];
    }
}

- (void)didfinishedRefreshNextPageDataWithStatuList:(StatuList *)statulist ststus:(NSArray *)status error:(NSError *)error
{
    [self hideBottomView];
    if (error) {
        NSLog(@"下一页%@",error);
    }
    else
    {
        NSLog(@"加载下一页%ld条数据",status.count);
        for (Statu *aStatu in status) {
            StatusFrame *frames = [StatusFrame new];
            frames.status = aStatu;
            [self.cellsFrameArray addObject:frames];
            [self.statusesArray addObject:aStatu];
        }
        [self.tableView reloadData];

    }
}

- (void)didFinishedUser_timelineDataRequestWithStatuList:(StatuList *)statulist ststus:(NSArray *)status error:(NSError *)error
{
    if (error) {
        NSLog(@"加载首页%@",error);
        [self hideTopView];
    }
    else
    {
        [self hideTopView];
        [self.statusesArray removeAllObjects];
        [self.cellsFrameArray removeAllObjects];
        for (Statu *aStatu in status) {
            StatusFrame *frames = [StatusFrame new];
            frames.status = aStatu;
            [self.cellsFrameArray addObject:frames];
        }
        [self.statusesArray addObjectsFromArray:status];
        [self.tableView reloadData];
    }
}

-(void)didFinishedBilateral_timelineDataRequestWithStatuList:(StatuList *)statulist ststus:(NSArray *)status error:(NSError *)error
{
    if (error) {
        NSLog(@"加载首页%@",error);
        [self hideTopView];
    }
    else
    {
        [self hideTopView];
        [self.statusesArray removeAllObjects];
        [self.cellsFrameArray removeAllObjects];
        for (Statu *aStatu in status) {
            StatusFrame *frames = [StatusFrame new];
            frames.status = aStatu;
            [self.cellsFrameArray addObject:frames];
        }
        [self.statusesArray addObjectsFromArray:status];
        [self.tableView reloadData];
    }

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

#pragma mark - 刷新表示图代理
- (void)refreshTableViewControllerBottomViewDidStartLoding:(LRWRefreshTableViewController *)tableViewController
{
    [_statuRquest RefreshNextPageDataWithPramas:_parma];
}
- (void)refreshTableViewControllerHeadViewDidStartLoding:(LRWRefreshTableViewController *)tableViewController
{
    NSLog(@"%ld",_statusesArray.count);
    if (_statusesArray.count != 0) {
        [_statuRquest RefreshNewDataWithPramas:_parma];
    }
    else
    {
        [self getHomePage];
    }
}

#pragma mark - 微博cell代理方法
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




@end
