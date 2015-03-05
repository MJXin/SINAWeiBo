//
//  LRWSearchTableViewController.m
//  微博SDK测试
//
//  Created by lrw on 15/2/3.
//  Copyright (c) 2015年 LRW. All rights reserved.
//
#import "LRWSearchTableViewController.h"
#import "LRWResultViewController.h"
#import "TrendsRequest.h"
#import "FriendShipsRequest.h"
#import "AppDelegate.h"
#import "LRWSearchTableViewCell.h"
@interface LRWSearchTableViewController ()<TrendsRequestDelegate,FriendshipsRequestDelegate,LRWResultViewControllerDelegate>
{
    UISearchController *_searchController;
    NSMutableArray *_dataArray;
    TrendsRequest *_trendsRequest;
    RequestTrendsParma *_trendsParma;
    FriendShipsRequest *_friendShipsRequest;
    RequestFriendshipsParma *_friendShipsParma;
}
@end

@implementation LRWSearchTableViewController
- (instancetype)initWithType:(LRWSearchType)searchType
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    _searchtype = searchType;
    _hideResultControlWhenCellDidSelect = YES;
    return self;
}
- (instancetype)initWithStyle:(UITableViewStyle)style
{
    if(self = [super initWithStyle:UITableViewStyleGrouped])
    {
        
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self createSearchController];
    [self getData];
    [self createNavigationBar];
    self.title = _searchtype == LRWSearchTypeTopic ? @"热门话题" : @"联系人";
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLineEtched;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}
#pragma mark - 获取话题数据
- (void)getData
{
    _dataArray = [NSMutableArray array];
    /*
    if (_searchtype == LRWSearchTypeTopic)
    {
        for (NSInteger i = 0; i < 10; ++i) {
            Trend *treand = [Trend new];
            treand.name = [NSString stringWithFormat:@"%d",arc4random_uniform(100)];
            [_dataArray addObject:treand];
        }
        [(LRWResultViewController *)_searchController.searchResultsUpdater setDataArray:_dataArray];
        [self.tableView reloadData];
    }
    else
    {
        for (NSInteger i = 0; i < 10; ++i) {
            User *treand = [User new];
            treand.screen_name = [NSString stringWithFormat:@"%d",arc4random_uniform(100)];
            [_dataArray addObject:treand];
        }
        [(LRWResultViewController *)_searchController.searchResultsUpdater setDataArray:_dataArray];
        [self.tableView reloadData];
    }
     */
    AppDelegate *appDelegate =  (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (appDelegate.currentUID) {
        if (_searchtype == LRWSearchTypeTopic) {
            if (_trendsRequest == nil) {
                _trendsRequest = [TrendsRequest new];
                _trendsParma = [[RequestTrendsParma alloc] initWithAccess_token:appDelegate.currentAccessToken];
                _trendsRequest.delegate = self;
            }
            [_trendsRequest TrendsDailyRequestWithParma:_trendsParma];
        }
        else if(_searchtype == LRWSearchTypeAt)
        {
            if (_friendShipsRequest == nil) {
                _friendShipsRequest = [FriendShipsRequest new];
                _friendShipsParma = [[RequestFriendshipsParma alloc] initWithAccess_token:appDelegate.currentAccessToken];
                _friendShipsParma.uid = appDelegate.currentUID;
                _friendShipsRequest.delegate = self;
            }
            [_friendShipsRequest FriendsRequestWithParma:_friendShipsParma];
        }
    }
    else
    {
        
    }
}

#pragma mark - 话题代理方法

- (void)TrendsDailyRequestDidfinishWithTrendsList:(TrendsList *)trendsList Date:(NSString *)date Trends:(NSArray *)trends error:(NSError *)error
{
    if (!error) {
        _dataArray = [NSMutableArray arrayWithArray:trends];
        LRWResultViewController *resultC =  (LRWResultViewController *)_searchController.searchResultsUpdater;
        resultC.dataArray = _dataArray;
        [self.tableView reloadData];
    }
}
#pragma mark - 好友代理方法
- (void)FriendsRequestDidFinishedWithFriendShipsList:(FriendShipsList *)friendShipsList Friends:(NSArray *)users error:(NSError *)error
{
    if (!error)
    {
        _dataArray = [NSMutableArray arrayWithArray:users];
        LRWResultViewController *resultC =  (LRWResultViewController *)_searchController.searchResultsUpdater;
        resultC.dataArray = _dataArray;
        [self.tableView reloadData];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



#pragma mark - 创建UISearchController IOS 8之后使用
/**
 *  创建UISearchController IOS 8之后使用
 */
- (void)createSearchController
{
    //  UISearchController 中有两个属性 searchResultsController 和  searchResultsUpdater
    //  searchResultsController : 管理搜索返回的结果数据
    //  searchResultsUpdater : 显示搜索返回的结果数据
    //  一般来说，searchResultsController 和 searchResultsUpdater 指向同一个控制器(实现UISearchResultsUpdating协议),
    //  否则有坑爹现象出现
    //  searchController.searchBar 这个空间建议添加到tableView得headView上，否则有坑爹现象出现
    //              创建步骤
    //    1.创建一个实现了 UISearchResultsUpdating协议 的控制器，这个控制器必须实现 updateSearchResultsForSearchController:
    //    方法
    //    2.创建 UISearchController 调用 initWithSearchResultsController:方法，并且要用全局强指针指着
    //    3.设置 UISearchController 的属性 searchResultsUpdater(建议和 ResultsController 是同一个对象)
    //    4.searchController.searchBar 添加到需要显示的位置(建议设置为tableView的headView属性)
    
    //1.
    LRWResultViewController *oneController = [[LRWResultViewController alloc] initWithType:_searchtype];
    oneController.delegate = self;
    //2.
    UISearchController *searchController = [[UISearchController alloc] initWithSearchResultsController:oneController];
    _searchController = searchController;
    searchController.searchBar.keyboardType = UIKeyboardAppearanceAlert;
    //searchController.hidesNavigationBarDuringPresentation = NO;
    //3.
    searchController.searchResultsUpdater = oneController;
    //4. sizeToFit 设置frame为父控件的bounds
    [searchController.searchBar sizeToFit];
    self.tableView.tableHeaderView = searchController.searchBar;
}

#pragma mark - 创建导航栏
- (void)createNavigationBar
{
    if (self.navigationController.viewControllers.firstObject == self) {
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"退出" style:(UIBarButtonItemStyleDone) target:self action:@selector(cancelItemClick:)];
        self.navigationItem.leftBarButtonItem = item;
    }
}
#pragma mark - 导航栏退出按钮
- (void)cancelItemClick:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(searchTableViewController:didClickCell:searchType:)]) {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        if (_searchtype == LRWSearchTypeAt) {
            UITableViewCell *tmpCell = [[UITableViewCell alloc] init];
            tmpCell.textLabel.text = [(LRWSearchTableViewCell *)cell myLabel].text;
            cell = tmpCell;
        }
        [self.delegate searchTableViewController:self didClickCell:cell searchType:_searchtype];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return SEARCHCELLHEIGHT;
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (_searchtype == LRWSearchTypeTopic) {
        return [LRWCreateCellInSearchOrResult createTopicCellInTableView:tableView searchType:_searchtype cellData:_dataArray[indexPath.row]];
    }
    else
    {
        return [LRWCreateCellInSearchOrResult createAtCellInTableView:tableView searchType:_searchtype cellData:_dataArray[indexPath.row]];
    }
}

#pragma mark - 结果集控制器代理方法
- (void)resultViewController:(LRWResultViewController *)viewController didClickCell:(UITableViewCell *)cell searchType:(LRWSearchType)searchType
{
    if ([self.delegate respondsToSelector:@selector(searchTableViewController:didClickCell:searchType:)]) {
        if (_hideResultControlWhenCellDidSelect) {
            [viewController dismissViewControllerAnimated:NO completion:^{
                [self.delegate searchTableViewController:self didClickCell:cell searchType:_searchtype];
            }];
        }
        else
        {
           [self.delegate searchTableViewController:self didClickCell:cell searchType:_searchtype];
        }
        
    }
}
@end