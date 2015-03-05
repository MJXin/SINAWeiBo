//
//  LRWWeiBoUserPhotosTableViewController.m
//  微博SDK测试
//
//  Created by lrw on 15/2/4.
//  Copyright (c) 2015年 LRW. All rights reserved.
//
#define BACKGROUNDCOLOR [UIColor colorWithRed:239/255.0 green:239/255.0 blue:244/255.0 alpha:1]
#import "LRWWeiBoUserPhotosTableViewController.h"
#import "LRWWeiBoImagesCell.h"
#import "LRWWeiBoImageToStatu.h"
#import "LRWWeiBoPresentAnimation.h"
#import "LRWWeiBoDismissAnimation.h"
#import "AppDelegate.h"
#import "StatuRequest.h"
#import "LRWWeiBoShowImageController.h"
#import "PlaceRequest.h"
@interface LRWWeiBoUserPhotosTableViewController ()<LRWRefreshTableViewControllerDelegate,LRWWeiBoImagesCellDelegate,StatuRequestDelegate,UIViewControllerTransitioningDelegate,PlaceRequestDelegate>
{
    NSMutableArray *_statusesArray;
    NSMutableArray *_allImagesArray;
    LRWWeiBoPresentAnimation *_presentAnimation;
    LRWWeiBoDismissAnimation *_dismissAnimation;
    StatuRequest *_statuRquest;
    RequestStatuParma *_parma;
    PlaceRequest *_placeRequest;
    RequestPlaceParma *_placeParma;

    NSInteger _index;
}
@end

@implementation LRWWeiBoUserPhotosTableViewController
- (instancetype)initWithIndex:(NSInteger)index
{
    self = [self initWithStyle:0];
    _index = index;
    return self;
}
- (instancetype)initWithStyle:(UITableViewStyle)style
{
    _index = 0;
    return [super initWithStyle:(UITableViewStyleGrouped)];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化动画效果
    _presentAnimation = [LRWWeiBoPresentAnimation new];
    _dismissAnimation = [LRWWeiBoDismissAnimation new];
    _statusesArray = [NSMutableArray array];
    _allImagesArray = [NSMutableArray array];
    [self showTopView];
    if (_index == 0) {
        self.title = @"我的相册";
    }
    else
    {
        self.title = @"周边的图片";
    }
    
    self.tableView.backgroundColor = BACKGROUNDCOLOR;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _statusesArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return (self.tableView.bounds.size.width - 4) / 3.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1.0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1.0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LRWWeiBoImagesCell *cell = [tableView dequeueReusableCellWithIdentifier:@"weibo_images_cell"];
    if (cell == nil) {
        cell = [LRWWeiBoImagesCell new];
        cell.delegate = self;
    }
    cell.dataArray = _statusesArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = BACKGROUNDCOLOR;
    return cell;
}

- (void)refreshTableViewControllerBottomViewDidStartLoding:(LRWRefreshTableViewController *)tableViewController
{
    if (_index == 0) {
        _parma.page = [NSString stringWithFormat:@"%ld",[_parma.page integerValue] + 1];
        [_statuRquest RefreshNextPageDataWithPramas:_parma];
    }
    else
    {
        _placeParma.page = [NSString stringWithFormat:@"%ld",[_placeParma.page integerValue] + 1];
        [_placeRequest NearbyphotosRequestWithParma:_placeParma];
    }
}

- (void)refreshTableViewControllerHeadViewDidStartLoding:(LRWRefreshTableViewController *)tableViewController
{
    [self getNowData];
}

#pragma mark - 获取当前数据
- (void)getNowData
{
    AppDelegate *appDelegate =  (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (appDelegate.currentUID) {
            if (_index == 0) {
                if (_statuRquest == nil) {
                    _statuRquest = [StatuRequest new];
                    _parma = [[RequestStatuParma alloc] initWithAccess_token:appDelegate.currentAccessToken];
                    _statuRquest.delegate = self;
                }
                _parma.feature = @"2";
                _parma.page = @"1";
                _parma.count = @"50";
                [_statuRquest User_timelineDataRequestWithPramas:_parma];
            }
            else
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
                [_placeRequest NearbyphotosRequestWithParma:_placeParma];
            }
        }
    else
    {
        
    }
}

- (void)NearbyphotosRequestDidFinishedWithStatus:(NSArray *)status error:(NSError *)error
{
    if ([_placeParma.page isEqualToString:@"1"]) {
        [self hideTopView];
    }
    else
    {
        [self hideBottomView];
    }
    if (!error) {
        [_allImagesArray removeAllObjects];
        for (Statu *aStatu in status) {
            NSString *url = aStatu.thumbnail_pic;
            if (url && ![url isEqualToString:@""]) {
                [_allImagesArray addObject:[LRWWeiBoImageToStatu image:url statu:aStatu]];
            }
        }
        [self updateStatusArrayByImagesArray];
        [self.tableView reloadData];
    }
}

- (void)didFinishedUser_timelineDataRequestWithStatuList:(StatuList *)statulist ststus:(NSArray *)status error:(NSError *)error
{
    [self hideTopView];
    if (!error) {
        [_allImagesArray removeAllObjects];
        for (Statu *aStatu in status) {
            for (NSString *url in aStatu.pic_urls) {
                [_allImagesArray addObject:[LRWWeiBoImageToStatu image:url statu:aStatu]];
            }
        }
        [self updateStatusArrayByImagesArray];
        [self.tableView reloadData];
    }
}

- (void)didfinishedRefreshNextPageDataWithStatuList:(StatuList *)statulist ststus:(NSArray *)status error:(NSError *)error
{
    [self hideBottomView];
    [_statusesArray removeLastObject];
    if (!error) {
            for (Statu *aStatu in status) {
                for (NSString *url in aStatu.pic_urls) {
                    [_allImagesArray addObject:[LRWWeiBoImageToStatu image:url statu:aStatu]];
                }
            }
            [self updateStatusArrayByImagesArray];
        [self.tableView reloadData];
    }
}
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

#pragma mark - 微博图片cell代理方法
- (void)weiBoImagesCellDidClickImage:(UIImage *)image url:(NSString *)url statu:(Statu *)statu
{
    LRWWeiBoShowImageController *showViewController = [[LRWWeiBoShowImageController alloc] initWithStatu:statu image:image url:url];
    showViewController.view.bounds = [[UIScreen mainScreen] bounds];
    showViewController.transitioningDelegate = self;
    [self presentViewController:showViewController animated:YES completion:^{
        [showViewController hideShadow];
    }];
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
