//
//  DiscoverPlaceTableViewController.m
//  WBTest
//
//  Created by mjx on 15/2/6.
//  Copyright (c) 2015年 MJX. All rights reserved.
//

#import "DiscoverPlaceTableViewController.h"
#import "DiscoverSearchPlaceTableViewController.h"
#import "DiscoverTableViewImageCell.h"
#import "DiscoverCatalogueTableViewCell.h"
#import "DiscoverTableViewPhototype1Cell.h"
#import "DiscoverTableViewPhototype2Cell.h"
#import "DiscoverNearlyPlaceTableViewController.h"
#import "DiscoverMapTableViewController.h"
#import "DiscoverSearchUserTableViewController.h"
#import "UIImageView+AFNetworking.h"
#import "LRWWeiBoUserFriendsTableViewController.h"
#import "LRWWeiBoUserPhotosTableViewController.h"
#import "StatuDetialViewController.h"
#import "StatusFrame.h"
#import "LRWWeiBoCell.h"
#import "LRWWeiBoContentView.h"
#import "AppDelegate.h"
@interface DiscoverPlaceTableViewController ()
{
    //section内的行数
    NSArray *_section;
    UISearchController *search;
    NSArray *_sectionTitle;
    //用户位置
    Geo *_geo;
    //定位管理器
    CLLocationManager *_locationManager;
    //经度坐标
    float _longtitude;
    //纬度
    float _latitude;
    int _requestCount;
    NSMutableArray *_cellFrames;
    BOOL isgeo;
    BOOL isphoto;
    BOOL isuser;
    BOOL isstatu;
    
}
@property (nonatomic, strong)UIActivityIndicatorView *activity;
@property (nonatomic, strong)UILabel *activityLabel;
@end

@implementation DiscoverPlaceTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"周边"];
    self.tableView.allowsSelection = NO;
    DiscoverSearchUserTableViewController *searchResultTableViewController = [DiscoverSearchUserTableViewController new];
    search = [[UISearchController alloc]initWithSearchResultsController:searchResultTableViewController];
    search.delegate = searchResultTableViewController;
    search.searchBar.delegate = searchResultTableViewController;
    [search.searchBar sizeToFit];
    searchResultTableViewController.preController = self;
     self.tableView.tableHeaderView = search.searchBar;
    
//    定位
    _locationManager = [[CLLocationManager alloc]init];
    if ([CLLocationManager locationServicesEnabled]) {
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        _locationManager.distanceFilter = 50;
        _locationManager.delegate = self;
        [_locationManager startUpdatingLocation];
    }
    
////    调用接口获取位置信息
//    LocationRequest *locationRequest = [LocationRequest new];
//    RequestLoactionParma *locationParma = [[RequestLoactionParma alloc]initWithAccess_token:@"2.00JCy8pB0QTDbXe7b457a65eHnLwDB"];
//    locationRequest.delegate = self;
////    locationParma.coordinate = [NSString stringWithFormat:@"%g|%g",_longtitude,_latitude];
//    locationParma.coordinate = @"113.451363,23.100956";
//    [locationRequest AddressRequestByGeoWithParma:locationParma];
//    
//
//    
//    
//    
//    PlaceRequest *request = [PlaceRequest new];
//    request.delegate = self;
//    RequestPlaceParma *parma = [[RequestPlaceParma alloc]initWithAccess_token:@"2.00JCy8pB0QTDbXe7b457a65eHnLwDB"];
//    parma.count = @"10";
//    parma.Long = @"113.2550312019";
//    parma.lat = @"23.1323049748";
//    [request NearbyphotosRequestWithParma:parma];
//    [request NearbyUsersRequestWithParma:parma];
//    parma.count = @"20";
//    [request Nearby_timelineRequestWithParma:parma];
    
#warning 开始显示菊花
    //UIButton *btn = [UIButton buttonWithType:UIButtonTypeContactAdd];
    _activity = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [_activity startAnimating];
    CGRect bounds = [[UIScreen mainScreen] bounds];
    CGPoint center =CGPointMake(CGRectGetWidth(bounds) * 0.5, CGRectGetHeight(bounds) * 0.5);
    center.y -= 200;
    _activity.center = center;
    
    _activityLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 62, 30)];
    _activityLabel.textAlignment = NSTextAlignmentCenter;
    _activityLabel.textColor = [UIColor grayColor];
    _activityLabel.font = [UIFont systemFontOfSize:14];
    _activityLabel.text = @"加载中";
    center.y += 30;
    _activityLabel.center = center;
    [self.tableView addSubview:_activity];
    [self.tableView addSubview:_activityLabel];

    
    _sectionTitle = @[@"",@"",@"",@"周围热图",@"附近的人",@"周围微博"];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:0];
    self.navigationController.tabBarController.tabBar.hidden = YES;
    
}
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *location = [locations lastObject];
    _longtitude = location.coordinate.longitude;
    _latitude = location.coordinate.latitude;
#warning --没有真机,以后这里要写上请求地理位置接口,现在写在上面 --
    
    //    调用接口获取位置信息
    AppDelegate *appDelegate =  (AppDelegate *)[[UIApplication sharedApplication] delegate];
    LocationRequest *locationRequest = [LocationRequest new];
    //RequestLoactionParma *locationParma = [[RequestLoactionParma alloc]initWithAccess_token:@"2.00JCy8pB0QTDbXe7b457a65eHnLwDB"];
    RequestLoactionParma *locationParma = [[RequestLoactionParma alloc]initWithAccess_token:appDelegate.currentAccessToken];
    locationRequest.delegate = self;
    //    locationParma.coordinate = [NSString stringWithFormat:@"%g|%g",_longtitude,_latitude];
    locationParma.coordinate = [NSString stringWithFormat:@"%f,%f",_longtitude,_latitude];
    if(!isgeo)
    {
        [locationRequest AddressRequestByGeoWithParma:locationParma];
        isgeo = YES;
    }
    
    
    
    
    
    PlaceRequest *request = [PlaceRequest new];
    request.delegate = self;
    RequestPlaceParma *parma = [[RequestPlaceParma alloc]initWithAccess_token:appDelegate.currentAccessToken];
    parma.count = @"10";
    parma.Long = [NSString stringWithFormat:@"%f",_longtitude];
    parma.lat = [NSString stringWithFormat:@"%f",_latitude];
    if(!isphoto)
    {
    [request NearbyphotosRequestWithParma:parma];
        isphoto = YES;
    }
    if (!isuser) {
        [request NearbyUsersRequestWithParma:parma];
        isuser = YES;
    }
    if (!isstatu) {
        parma.count = @"20";
        [request Nearby_timelineRequestWithParma:parma];
        isstatu = YES;
    }
    
}

- (void)AddressRequestByGeoDidFinishedWithGeos:(NSArray *)geos error:(NSError *)error
{
    if (!error)
    {
    Geo *geo = [geos lastObject];
    _geo = geo;
        _requestCount += 1;
    }
    else
        NSLog(@"%@",error);
        [self canreload];
}
-(void)NearbyphotosRequestDidFinishedWithStatus:(NSArray *)status error:(NSError *)error
{   if(!error)
    {
        _photoStatus = status;
        _requestCount += 10;
    }
    else
        NSLog(@"%@",error);
    [self canreload];
}
- (void)NearbyUsersRequestDidFinishedWithUsers:(NSArray *)users error:(NSError *)error
{
    if(!error)
    {
        _users = users;
        _requestCount += 100;
        
    }else
        NSLog(@"%@",error);
    [self canreload];
}
-(void)Nearby_timelineRequestDidFinishedWithStatuList:(StatuList *)statulist ststus:(NSArray *)status error:(NSError *)error
{
    if (!error) {
        _status = status;
        _requestCount += 1000;

    }
    _cellFrames = [NSMutableArray array];
    for (Statu *aStatu in status) {
        StatusFrame *frame = [StatusFrame new];
        frame.status = aStatu;
        [_cellFrames addObject:frame];
    }
    
    [self canreload];
    
}

- (void)canreload
{
    if (_requestCount == 1)
    {
        _section = @[@1,@1, @1];
        CGPoint point = _activity.center;
        point.y += 220;
        _activity.center = point;
        point = _activityLabel.center;
        point.y += 220;
        _activityLabel.center = point;
        
//        [_activity stopAnimating];
//        _activityLabel.hidden = YES;
//        _activity.hidden = YES;
        [self.tableView reloadData];

    }
    else if (_requestCount == 111) {
                _section = @[@1,@1,@1,@1,@1];
                            // [NSNumber numberWithInteger:_status.count]
                [_activity stopAnimating];
                _activityLabel.hidden = YES;
                _activity.hidden = YES;
        self.tableView.allowsSelection = YES;
                 [self.tableView reloadData];
            }
    else if (_requestCount == 1111)
    {
            if (_status&&_status.count!=0) {
                _section = @[@1,@1,@1,@1,@1,[NSNumber numberWithInteger:_status.count]];
                [_activity stopAnimating];
                _activityLabel.hidden = YES;
                _activity.hidden = YES;
                self.tableView.allowsSelection = YES;
                [self.tableView reloadData];
            }
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return _section.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [_section[section] integerValue];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    DiscoverTableViewImageCell *imageCell;
    DiscoverCatalogueTableViewCell *catalogueCell;
    switch (indexPath.section) {
        case 0:
            imageCell = [tableView dequeueReusableCellWithIdentifier:@"image"];
            if (!imageCell) {
                imageCell = [[DiscoverTableViewImageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"image"];
            }
            [imageCell show];
            cell = imageCell;
            break;
        case 1:{
            cell = [tableView dequeueReusableCellWithIdentifier:@"me"];
            if (!cell) {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"me"];
            }
            if (_geo) {
                cell.textLabel.text = [NSString stringWithFormat:@"位于%@",_geo.address];
            }
            else
                cell.textLabel.text = [NSString stringWithFormat:@"未知地点"];
            cell.textLabel.font = [UIFont systemFontOfSize:13];
            cell.detailTextLabel.text = _geo.city_name;
            cell.detailTextLabel.textColor = [UIColor grayColor];
            cell.detailTextLabel.font = [UIFont systemFontOfSize:10];
            
            AppDelegate *appDelegate =  (AppDelegate *)[[UIApplication sharedApplication] delegate];

            NSURL *url = [NSURL URLWithString:appDelegate.currentUser.avatar_large];
            cell.imageView.image = [UIImage imageNamed:@"noPhoto"];
            [cell.imageView setImageWithURL:url];
            //NSLog(@"%@",cell.imageView.image);
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setImage:[UIImage imageNamed:@"activity_card_locate.png"] forState:UIControlStateNormal];
            [button setTitle:@"  到此一游" forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:12];
            [button setTitleColor:[UIColor colorWithRed:83/255.0 green:133/255.0 blue:186/255.0 alpha:1] forState:UIControlStateNormal];
            
            button.frame = CGRectMake(0, 0, 90, 50);
            
            cell.accessoryView = button;

            break;
        }
        case 2:
            catalogueCell = [tableView dequeueReusableCellWithIdentifier:@"catalogCell"];
            if (!catalogueCell) {
                catalogueCell = [[DiscoverCatalogueTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"catalogCell"];
            }
            catalogueCell.catalogImageOne.image = [UIImage imageNamed:@"4_3_1"];
            catalogueCell.catlogLabelOne.text = @"热点";
            catalogueCell.catlogLabelOne.font = [UIFont systemFontOfSize:12];
            catalogueCell.lat = [NSString stringWithFormat:@"%f",_latitude];
            catalogueCell.Long = [NSString stringWithFormat:@"%f",_longtitude];
            catalogueCell.catlogImageTwo.image = [UIImage imageNamed:@"4_3_2"];
            catalogueCell.catlogLabelTwo.text = @"吃喝玩乐";
            catalogueCell.catlogLabelTwo.font = [UIFont systemFontOfSize:12];

            
            catalogueCell.catlogImageThree.image = [UIImage imageNamed:@"4_3_3"];
            catalogueCell.catlogLabelThree.text = @"有缘人";
            catalogueCell.catlogLabelThree.font = [UIFont systemFontOfSize:12];

            catalogueCell.catlogImageFour.image = [UIImage imageNamed:@"4_3_4"];
            catalogueCell.catlogLabelFour.text = @"足迹";
            catalogueCell.catlogLabelFour.font = [UIFont systemFontOfSize:12];

            cell = catalogueCell;
            [catalogueCell.catalogBtnOne addTarget:self action:@selector(pressCatalogOne) forControlEvents:UIControlEventTouchUpInside];
            [catalogueCell.catalogBtnThree addTarget:self action:@selector(pressCatalogTwo) forControlEvents:UIControlEventTouchUpInside];
            break;
        case 3:
        {
            DiscoverTableViewPhototype1Cell *photoCell = [tableView dequeueReusableCellWithIdentifier:@"photo1"];
            if (!photoCell) {
                photoCell = [[DiscoverTableViewPhototype1Cell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"photo1" ];
            }
            if (_photoStatus.count!=0) {
                Statu *statu1 = _photoStatus[0];
                NSURL *url1 = [NSURL URLWithString:statu1.thumbnail_pic];
                Statu *statu2 = _photoStatus[1];
                NSURL *url2 = [NSURL URLWithString:statu2.thumbnail_pic];
                
                Statu *statu3 = _photoStatus[2];
                NSURL *url3 = [NSURL URLWithString:statu3.thumbnail_pic];
                Statu *statu4 = _photoStatus[3];
                NSURL *url4 = [NSURL URLWithString:statu4.thumbnail_pic];
                
                [photoCell.photo1 setImageWithURL:url1];
                [photoCell.photo2 setImageWithURL:url2];
                [photoCell.photo3 setImageWithURL:url3];
                [photoCell.photo4 setImageWithURL:url4];
            }
            
            
            cell = photoCell;
        }
            
            break;
        case 4:
        {
            DiscoverTableViewPhototype2Cell *photoCell = [tableView dequeueReusableCellWithIdentifier:@"photo2"];
            if (!photoCell) {
                photoCell = [[DiscoverTableViewPhototype2Cell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"photo2" ];
            }
            if (_photoStatus.count!=0) {
                User *user1 = _users[0];
                NSURL *url1 = [NSURL URLWithString:user1.avatar_large];
                User *user2 = _users[1];
                NSURL *url2 = [NSURL URLWithString:user2.avatar_large];
                User *user3 = _users[2];
                NSURL *url3 = [NSURL URLWithString:user3.avatar_large];
                User *user4 = _users[3];
                NSURL *url4 = [NSURL URLWithString:user4.avatar_large];
                [photoCell.photo1 setImageWithURL:url1];
                photoCell.label1.text = user1.name;
                photoCell.label1.font = [UIFont systemFontOfSize:12];
                [photoCell.photo2 setImageWithURL:url2];
                photoCell.label2.text = user2.name;
                photoCell.label2.font = [UIFont systemFontOfSize:12];
                [photoCell.photo3 setImageWithURL:url3];
                photoCell.label3.text = user3.name;
                photoCell.label3.font = [UIFont systemFontOfSize:12];
               // photoCell.imageView.contentMode = UIViewContentModeCenter;
                [photoCell.photo4 setImageWithURL:url4];
                photoCell.label4.text = user4.name;
                photoCell.label4.font = [UIFont systemFontOfSize:12];
            }
            
            cell = photoCell;
        }

            
            break;
        case 5:
        {
            LRWWeiBoCell *weibocell = [LRWWeiBoCell cellWithTableView:tableView];
            weibocell.weiboContentView.status = _status[indexPath.row];
            weibocell.weiboContentView.statusFrame = _cellFrames[indexPath.row];
            return weibocell;
        }
            
            break;
        default:
            
            break;
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //NSLog(@"%@",indexPath);
    switch (indexPath.section) {
        case 0:
            return 100;
            break;
        case 1:
            break;
        case 2:
            return 90;
            break;
        case 3:
            return 85;
            break;
        case 4:
            return 105;
            break;
        case 5:
        {
            StatusFrame *frame = _cellFrames[indexPath.row];
            CGFloat height = frame.cellHeight + 10;
            //NSLog(@"-------%f",height);
            return height;
            break;
        }
        default:
            break;
    }
    return 60;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return _sectionTitle[section];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section

{
    if(section >2)
    {
        return 12;
    }
    return  5;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if(section >1)
    {
        return 25;
    }
    return 5;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 4) {//周边的人
        LRWWeiBoUserFriendsTableViewController *s = [[LRWWeiBoUserFriendsTableViewController alloc] initWithFriendShipStyle:(LRWWeiBoFriendShipStylePlace)];
        s.showNavagationBar = YES;
        [self.navigationController pushViewController:s animated:YES];
    }
    else if (indexPath.section == 3)
    {
        LRWWeiBoUserPhotosTableViewController *p = [[LRWWeiBoUserPhotosTableViewController alloc] initWithIndex:1];
        p.showNavagationBar = YES;
        [self.navigationController pushViewController:p animated:YES];
    }
    else if (indexPath.section == 1) {
        DiscoverMapTableViewController *mapViewController = [[DiscoverMapTableViewController alloc]initWithStyle:UITableViewStyleGrouped];
        mapViewController.Long = [NSString stringWithFormat:@"%f",_longtitude];
        mapViewController.lat = [NSString stringWithFormat:@"%f",_latitude];
        mapViewController.status = self.status;
        mapViewController.photoStatus = self.photoStatus;
        mapViewController.users = self.users;
        [self.navigationController pushViewController:mapViewController animated:YES];
    }
    else if (indexPath.section == 5)
    {
        [self weiBoCell:[self.tableView cellForRowAtIndexPath:indexPath] didClickCell:self.status[indexPath.row]];
    }
}

#pragma mark -- 目录按钮 --
- (void) pressCatalogOne
{
    DiscoverNearlyPlaceTableViewController *nearlyPlaceController = [[DiscoverNearlyPlaceTableViewController alloc]initWithStyle:UITableViewStyleGrouped];
    nearlyPlaceController.lat = [NSString stringWithFormat:@"%f",_latitude];
    nearlyPlaceController.Long = [NSString stringWithFormat:@"%f",_longtitude];
    [self.navigationController pushViewController:nearlyPlaceController animated:YES];

}
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
- (void) pressCatalogTwo
{
    
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
