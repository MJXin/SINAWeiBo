//
//  DiscoverTableViewController.m
//  WBTest
//
//  Created by mjx on 15/2/4.
//  Copyright (c) 2015年 MJX. All rights reserved.
//

#import "DiscoverTableViewController.h"
#import "DiscoverHotWeiBoTableViewController.h"
#import "DiscoverSearchUserTableViewController.h"
#import "AppDelegate.h"
@interface DiscoverTableViewController ()
{
    NSArray *_cellData;
    NSArray *_trends;
    NSArray *_section;
    

}
@property(nonatomic,strong)UISearchController *search;
@property (nonatomic, strong)UIActivityIndicatorView *activity;
@property (nonatomic, strong)UILabel *activityLabel;

@end

@implementation DiscoverTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    DiscoverSearchUserTableViewController *searchTableview =[[DiscoverSearchUserTableViewController alloc]initWithStyle:UITableViewStyleGrouped];
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.search = [[UISearchController alloc] initWithSearchResultsController:searchTableview];
    self.search.delegate = searchTableview;
    self.search.hidesNavigationBarDuringPresentation = YES;
    self.search.searchBar.tintColor = [UIColor blackColor];
    self.search.searchBar.delegate = searchTableview;
    searchTableview.preController = self;
    [self.search.searchBar sizeToFit];
    
    self.tableView.tableHeaderView = self.search.searchBar;

    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)])
    {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)])
    {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
   // _cellData = @[@[@"热门微博",@"找人",@"周边"],@[@"游戏中心",@"新春红包",@"鲜城-广州"],@[@"电影",@"听歌",@"购物",@"更多频道"]];
    AppDelegate *appDelegate =  (AppDelegate *)[[UIApplication sharedApplication] delegate];
    TrendsRequest *request = [TrendsRequest new];
    request.delegate = self;
   // RequestTrendsParma *parma = [[RequestTrendsParma alloc]initWithAccess_token:@"2.00JCy8pB0QTDbXe7b457a65eHnLwDB"];
    RequestTrendsParma *parma = [[RequestTrendsParma alloc]initWithAccess_token:appDelegate.currentAccessToken];
    [request TrendsHourlyRequestWithParma:parma];
    self.title = @"发现";
    self.hidesBottomBarWhenPushed = YES;
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


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:0];
    self.tabBarController.tabBar.hidden = NO;
    self.hidesBottomBarWhenPushed = NO;
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.hidesBottomBarWhenPushed = YES;
}
- (void)TrendsHourlyRequestDidfinishWithTrendsList:(TrendsList *)trendsList Date:(NSString *)date Trends:(NSArray *)trends error:(NSError *)error
{
    if(!error)
    {
    _trends = trends;
    }
    _section = @[@1,@1,@3,@3,@4];
     _cellData = @[@[@"热门微博",@"找人",@"周边"],@[@"游戏中心",@"新春红包",@"鲜城-广州"],@[@"电影",@"听歌",@"购物",@"更多频道"]];
    [_activity stopAnimating];
    _activityLabel.hidden = YES;
    _activity.hidden = YES;
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)])
    {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)])
    {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_section[section] integerValue];
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell;
    DiscoverTableViewImageCell *imagecell;
    DiscoverTableViewTrendCell *trendcell;
    Trend *trend0 = _trends[0];
    Trend *trend1 = _trends[1];
    Trend *trend2 = _trends[2];
    Trend *trend3 = _trends[3];
    UIImage *img;
    switch (indexPath.section) {
        case 0:
            imagecell = [tableView dequeueReusableCellWithIdentifier:@"image"];
            if (!cell) {
                imagecell = [[DiscoverTableViewImageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"image"];
            }
            [imagecell show];
        
            cell = imagecell;
            
            
            break;
        case 1:
            trendcell = [tableView dequeueReusableCellWithIdentifier:@"Trend"];
            if (!trendcell) {
                trendcell = [[DiscoverTableViewTrendCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Trend"];
            }
            if (_trends) {
                [trendcell.trendbtn1 setTitle:[NSString stringWithFormat:@"#%@#",trend0.name] forState:UIControlStateNormal];
                [trendcell.trendbtn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                [trendcell.trendBtn2 setTitle:[NSString stringWithFormat:@"#%@#",trend1.name] forState:UIControlStateNormal];
                [trendcell.trendBtn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                [trendcell.trendBtn3 setTitle:[NSString stringWithFormat:@"#%@#",trend2.name] forState:UIControlStateNormal];
                [trendcell.trendBtn3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                [trendcell.trendBtn4 setTitle:[NSString stringWithFormat:@"#%@#",trend3.name] forState:UIControlStateNormal];
                [trendcell.trendBtn4 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            }
            
            cell = trendcell;
            
            break;
        case 2:
        {
            switch (indexPath.row) {
                case 0:
                {
                    img = [UIImage imageNamed:@"4_1"];
                }
                    break;
                case 1:
                {
                    img = [UIImage imageNamed:@"4_2"];
                    break;
                }
                default:
                {
                    img = [UIImage imageNamed:@"4_3"];
                }
                    break;
            }
            cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
            if (!cell) {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
            }
            NSArray *celldata = _cellData[indexPath.section-2];
            cell.textLabel.text = celldata[indexPath.row];
            cell.imageView.image = img;
            if(indexPath.section == 2)
            {
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }

            break;
        }
        case 3:
        {
            switch (indexPath.row) {
                case 0:
                {
                    img = [UIImage imageNamed:@"4_4"];
                }
                    break;
                case 1:
                {
                    img = [UIImage imageNamed:@"4_5"];
                    break;
                }
                default:
                {
                    img = [UIImage imageNamed:@"4_6"];
                }
                    break;
            }
            cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
            if (!cell) {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
            }
            NSArray *celldata = _cellData[indexPath.section-2];
            cell.textLabel.text = celldata[indexPath.row];
            cell.imageView.image = img;
            if(indexPath.section == 2)
            {
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }

            break;
        }
        case 4:
        {
            switch (indexPath.row) {
                case 0:
                {
                    img = [UIImage imageNamed:@"4_7"];
                }
                    break;
                case 1:
                {
                    img = [UIImage imageNamed:@"4_8"];
                    break;
                }
                case 2:
                {
                    img = [UIImage imageNamed:@"4_9"];
                    break;
                }

                default:
                {
                    img = [UIImage imageNamed:@"4_10"];
                }
                    break;
            }
            cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
            if (!cell) {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
            }
            NSArray *celldata = _cellData[indexPath.section-2];
            cell.textLabel.text = celldata[indexPath.row];
            cell.imageView.image = img;
            if(indexPath.section == 2)
            {
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }

            break;
        }
        default:
            cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
            if (!cell) {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
            }
            NSArray *celldata = _cellData[indexPath.section-2];
            cell.textLabel.text = celldata[indexPath.row];
            cell.imageView.image = img;
            if(indexPath.section == 2)
            {
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
            break;
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.section == 2) {
        DiscoverUserTableViewController *userTableViewController = [DiscoverUserTableViewController new];
        DiscoverPlaceTableViewController *placeTableViewController = [[DiscoverPlaceTableViewController alloc]initWithStyle:UITableViewStyleGrouped];
        switch (indexPath.row) {
            case 0:{
                DiscoverHotWeiBoTableViewController *tableViewController = [[DiscoverHotWeiBoTableViewController alloc]initWithStyle:UITableViewStyleGrouped];
                tableViewController.showNavagationBar = YES;
                [self.navigationController pushViewController:tableViewController animated:YES];
            }
                break;
            case 1:
                [self.navigationController pushViewController:userTableViewController animated:YES];
                break;

            case 2:
                [self.navigationController pushViewController:placeTableViewController animated:YES];
                
                break;
        }
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 100;
    }
    else if (indexPath.section == 1)
        return 80;
    else return 50;
}
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
//{
//}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0.1;
    }
    else
        return 5;
    
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
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
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
