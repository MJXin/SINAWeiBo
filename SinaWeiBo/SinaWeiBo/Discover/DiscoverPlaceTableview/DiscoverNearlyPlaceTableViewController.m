//
//  DiscoverNearlyPlaceTableViewController.m
//  WBTest
//
//  Created by mjx on 15/2/9.
//  Copyright (c) 2015年 MJX. All rights reserved.
//

#import "DiscoverNearlyPlaceTableViewController.h"
#import "ThreeTitleTableViewCell.h"
#import "UIImageView+AFNetworking.h"
#import "AppDelegate.h"
@interface DiscoverNearlyPlaceTableViewController ()
{
    NSArray *_pois;
}
@property (nonatomic, strong)UIActivityIndicatorView *activity;
@property (nonatomic, strong)UILabel *activityLabel;

@end

@implementation DiscoverNearlyPlaceTableViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.tabBarController.tabBar.hidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"热点"];
    AppDelegate *appDelegate =  (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    PlaceRequest *placeRequest = [PlaceRequest new];
    placeRequest.delegate = self;
    //RequestPlaceParma *placeParma = [[RequestPlaceParma alloc]initWithAccess_token:@"2.00JCy8pB0QTDbXe7b457a65eHnLwDB"];
    RequestPlaceParma *placeParma = [[RequestPlaceParma alloc]initWithAccess_token:appDelegate.currentAccessToken];
    placeParma.lat = self.lat;
    placeParma.Long = self.Long;
    placeParma.count = @"20";
    [placeRequest PoisRequestByNearbyWithParma:placeParma];
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

   


}
-(void)PoisRequestByNearbyDidFinishedWithPois:(NSArray *)pois error:(NSError *)error
{
    if (!error) {
        _pois = pois;
        [_activity stopAnimating];
        _activityLabel.hidden = YES;
        _activity.hidden = YES;
        [self.tableView reloadData];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return _pois.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ThreeTitleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[ThreeTitleTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    Poi *poi = _pois[indexPath.row];
    cell.title1.text = poi.title;
    cell.title2.text = poi.address;
    cell.title3.text = [NSString stringWithFormat:@"%@人",poi.checkin_user_num];
    NSURL *url = [NSURL URLWithString:poi.poi_pic];
    [cell.theImage setImageWithURL:url];

    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 4;
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
