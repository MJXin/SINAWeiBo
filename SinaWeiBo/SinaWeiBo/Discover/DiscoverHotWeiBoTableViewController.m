//
//  LRWWeiBoUserWeiBoTableViewController.m
//  微博SDK测试
//
//  Created by lrw on 15/2/4.
//  Copyright (c) 2015年 LRW. All rights reserved.
//

#import "DiscoverHotWeiBoTableViewController.h"
#define BACKGROUNDCOLOR [UIColor colorWithRed:239/255.0 green:239/255.0 blue:244/255.0 alpha:1]
#import "LRWWeiBoImagesCell.h"
#import "LRWWeiBoImageToStatu.h"
#import "LRWWeiBoPresentAnimation.h"
#import "LRWWeiBoDismissAnimation.h"
#import "AppDelegate.h"
#import "SuggestionsRequest.h"
#import "LRWWeiBoShowImageController.h"
#import "LRWWeiBoWebController.h"
#import "LRWWeiBoCell.h"
#import "UserRequest.h"
#import "LRWWeiBoUserPageTableViewControl.h"
#import "Statu.h"
#import "StatusFrame.h"
#import "User.h"
#import "LRWWeiBoContentView.h"
#import "LRWSearchTableViewController.h"
#import "Statu.h"
#import "SendCommentController.h"
#import "StatuDetialViewController.h"
@interface DiscoverHotWeiBoTableViewController ()<LRWRefreshTableViewControllerDelegate,LRWWeiBoImagesCellDelegate,SuggestionsRequestDelegate,UIViewControllerTransitioningDelegate,LRWWeiBoCellDelegate>
{
    NSMutableArray *_statusesArray;
    NSMutableArray *_cellsFrameArray;
    LRWWeiBoPresentAnimation *_presentAnimation;
    LRWWeiBoDismissAnimation *_dismissAnimation;
    SuggestionsRequest *_statuRquest;
    RequestSuggestionParma *_parma;
}

@end

@implementation DiscoverHotWeiBoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = BACKGROUNDCOLOR;
    //初始化动画效果
    _presentAnimation = [LRWWeiBoPresentAnimation new];
    _dismissAnimation = [LRWWeiBoDismissAnimation new];
    self.delegate = self;
    _statusesArray = [NSMutableArray array];
    _cellsFrameArray = [NSMutableArray array];
    self.tableView.separatorStyle = UITableViewScrollPositionNone;
    self.title = @"热门微博";
    [self  showTopView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 微博cell代理方法
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

#pragma mark - Table 代理、数据源
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LRWWeiBoCell *weiboCell = [LRWWeiBoCell cellWithTableView:tableView];
    weiboCell.weiboContentView.status = _statusesArray[indexPath.row];
    weiboCell.weiboContentView.statusFrame = _cellsFrameArray[indexPath.row];
    weiboCell.delegate = self;
    return weiboCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    StatusFrame *frames = _cellsFrameArray[indexPath.section];
    frames = _cellsFrameArray[indexPath.row];
    
    return frames.cellHeight + 10;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _statusesArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1.0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1.0;
}

#pragma mark - 主视图代理方法
- (void)refreshTableViewControllerBottomViewDidStartLoding:(LRWRefreshTableViewController *)tableViewController
{
    //[_statuRquest RefreshNextPageDataWithPramas:_parma];
    _parma.page = [NSString stringWithFormat:@"%ld",[_parma.page integerValue] + 1];
    [_statuRquest HotFavoritesSuggestionRequestWithParma:_parma];

}
- (void)refreshTableViewControllerHeadViewDidStartLoding:(LRWRefreshTableViewController *)tableViewController
{
    [self getHomePage];
}

#pragma mark - 获取首页数据
- (void)getHomePage
{

    AppDelegate *appDelegate =  (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (appDelegate.currentUID) {
        if (_statuRquest == nil) {
            _statuRquest = [SuggestionsRequest new];
            _parma = [[RequestSuggestionParma alloc] initWithAccess_token:appDelegate.currentAccessToken];
            _statuRquest.delegate = self;
        }
        
        //判断调用哪个接口
        //[_statuRquest User_timelineDataRequestWithPramas:_parma];
        _parma.page = @"1";
        [_statuRquest HotFavoritesSuggestionRequestWithParma:_parma];
    }
    else
    {
        
    }
}

#pragma mark - 微博数据源代理方法
- (void)HotFavoritesSuggestionRequestDidFinishedWithFavorites:(NSArray *)favorites error:(NSError *)error
{
    if (error) {
        NSLog(@"加载首页%@",error);
        [self hideTopView];
        [self hideBottomView];
    }
    else
    {
        NSInteger page = [_parma.page integerValue];
            NSLog(@"%ld",page);
        if (page == 1 ) {

            [self hideTopView];
            [_statusesArray removeAllObjects];
            [_cellsFrameArray removeAllObjects];
        }
        else
        {
            [self hideBottomView];
        }
            for (Statu *aStatu in favorites) {
            StatusFrame *frames = [StatusFrame new];
            frames.status = aStatu;
            [_cellsFrameArray addObject:frames];
        }
        [_statusesArray addObjectsFromArray:favorites];
        [self.tableView reloadData];
    }
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:0];
}

@end
