//
//  DiscoverUserTableViewController.m
//  WBTest
//
//  Created by mjx on 15/2/5.
//  Copyright (c) 2015年 MJX. All rights reserved.
//

#import "DiscoverUserTableViewController.h"
#import "DiscoverCatalogueTableViewCell.h"
#import "DiscoverSearchUserTableViewController.h"
#import "LRWWeiBoUserPageTableViewControl.h"
#import "LRWWeiBoUserFriendsTableViewController.h"
#import "ThreeTitleTableViewCell.h"
#import "UIImageView+AFNetworking.h"
#import "AppDelegate.h"
@interface DiscoverUserTableViewController ()
@property (nonatomic, strong)UISearchController *search;
/**热门人物*/
@property (nonatomic, strong)NSArray *hotUsers;
@property (nonatomic, strong)NSArray *row;
@property (nonatomic, strong)UIActivityIndicatorView *activity;
@property (nonatomic, strong)UILabel *activityLabel;
@end

@implementation DiscoverUserTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    DiscoverSearchUserTableViewController *searchTableview =[[DiscoverSearchUserTableViewController alloc]initWithStyle:UITableViewStyleGrouped];
    self.search = [[UISearchController alloc] initWithSearchResultsController:searchTableview];
    self.search.delegate = searchTableview;

    //self.search.hidesNavigationBarDuringPresentation = YES;
    self.search.searchBar.delegate = searchTableview;
    [self.search.searchBar sizeToFit];
    self.search.searchBar.tintColor = [UIColor blackColor];
    self.tableView.tableHeaderView = self.search.searchBar;
    searchTableview.preController = self;
    AppDelegate *appDelegate =  (AppDelegate *)[[UIApplication sharedApplication] delegate];

    SuggestionsRequest *request = [SuggestionsRequest new];
    request.delegate = self;
    RequestSuggestionParma *parma = [[RequestSuggestionParma alloc]initWithAccess_token:appDelegate.currentAccessToken];
    parma.category = @"default";
    [request HotUsersSuggestionRequestWithParma:parma];
    self.title = @"找人";
    
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
    
    
    [self.tableView addSubview:_activityLabel];
    [self.tableView addSubview:_activity];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:0];
    self.navigationController.tabBarController.tabBar.hidden = YES;

}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [[(UITabBarController *)self.view.window.rootViewController tabBar] setHidden:YES];

}
-(void)HotUsersSuggestionRequestDidFinishedWithUsers:(NSArray *)users error:(NSError *)error
{
    if (!error) {
        self.hotUsers = users;
        self.row = @[@1,@1,@5];
        UIView *view = [self.tableView viewWithTag:1234567];
        [_activity stopAnimating];
        _activity.hidden = YES;
        _activityLabel.hidden = YES;
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
    return self.row.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [self.row[section] integerValue];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    
    if (indexPath.section == 0) {
        DiscoverTableViewImageCell *imageCell = [tableView dequeueReusableCellWithIdentifier:@"image"];
        if (!imageCell) {
            imageCell = [[DiscoverTableViewImageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"image"];
        }
        [imageCell show];
        cell = imageCell;
       
        
    }
    else if(indexPath.section == 1)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"catalog"];
        if (!cell) {
            DiscoverCatalogueTableViewCell *catalogCell = [[DiscoverCatalogueTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"catalog"];
            catalogCell.catalogImageOne.image = [UIImage imageNamed:@"4_2_1"];
            catalogCell.catlogLabelOne.text = @"影视";
            catalogCell.catlogLabelOne.font = [UIFont systemFontOfSize:12];
            [catalogCell.catalogBtnOne addTarget:self action:@selector(catalogbtn:) forControlEvents:UIControlEventTouchUpInside];
            catalogCell.catalogBtnOne.tag = 765011;
            catalogCell.catlogImageTwo.image = [UIImage imageNamed:@"4_2_2"];
            catalogCell.catlogLabelTwo.text = @"体育";
            catalogCell.catlogLabelTwo.font = [UIFont systemFontOfSize:12];
            [catalogCell.catalogBtnTwo addTarget:self action:@selector(catalogbtn:) forControlEvents:UIControlEventTouchUpInside];
            catalogCell.catalogBtnTwo.tag = 765012;
            catalogCell.catlogImageThree.image = [UIImage imageNamed:@"4_2_3"];
            [catalogCell.catalogBtnThree addTarget:self action:@selector(catalogbtn:) forControlEvents:UIControlEventTouchUpInside];
            catalogCell.catalogBtnThree.tag = 765013;
            catalogCell.catlogLabelThree.text = @"动漫";
            catalogCell.catlogLabelThree.font = [UIFont systemFontOfSize:12];

            
            catalogCell.catlogImageFour.image = [UIImage imageNamed:@"4_2_4"];
            [catalogCell.catalogBtnFour addTarget:self action:@selector(catalogbtn:) forControlEvents:UIControlEventTouchUpInside];
            catalogCell.catalogBtnFour.tag = 765014;
            catalogCell.catlogLabelFour.text = @"商界";
            catalogCell.catlogLabelFour.font = [UIFont systemFontOfSize:12];
            cell = catalogCell;

        }
    }
    else
    {
        ThreeTitleTableViewCell *userCell;
        userCell = [tableView dequeueReusableCellWithIdentifier:@"userCell"];
        if (!cell) {
            userCell = [[ThreeTitleTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"userCell"];
        }
        User *user = _hotUsers[indexPath.row];
        userCell.title1.text = user.name;
        if (user.verified) {
            userCell.title3.text = user.verified_reason;
        }
        else
        {
            userCell.title3.text = user.Description;
        }
        NSURL *url = [NSURL URLWithString:user.avatar_large];
        [userCell.theImage setImageWithURL:url];
        userCell.accessoryView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:nil]];
        [userCell setSeparatorInset:UIEdgeInsetsZero];
        cell = userCell;
        
    }

    
    return cell;
}
- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath
{
    if (indexPath.section == 0) {
        return 100;
    }
    else if(indexPath.section == 1)
    {
        return 90;
    }
    else
        return 60;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 2) {
        return @"特别推荐";
    }
    else
        return nil;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:13];
    [btn setBackgroundColor:[UIColor whiteColor]];

    if (section == 1) {
        [btn setTitle:@"查看更多分类" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(moreCatalogue) forControlEvents:UIControlEventTouchUpInside ];
        return btn;
    }
    else if (section == 2)
    {
        [btn setTitle:@"查看更多特别推荐" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(moreBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
        return btn;

    }

    return nil;
}
- (void)catalogbtn:(UIButton*)sender
{
  switch (sender.tag) {
        case 765011:
        {
            LRWWeiBoUserFriendsTableViewController *a = [[LRWWeiBoUserFriendsTableViewController alloc]initWithFriendShipStyle:(LRWWeiBoFriendShipStyleEnt)];
            [self.navigationController pushViewController:a animated:YES];
            a.showNavagationBar = YES;
        }
            break;
        case 765012:
        {
            LRWWeiBoUserFriendsTableViewController *a = [[LRWWeiBoUserFriendsTableViewController alloc]initWithFriendShipStyle:(LRWWeiBoFriendShipStyleFashion)];
            a.showNavagationBar = YES;
            [self.navigationController pushViewController:a animated:YES];
        }
            break;
        case 765013:
        {
         LRWWeiBoUserFriendsTableViewController *a = [[LRWWeiBoUserFriendsTableViewController alloc]initWithFriendShipStyle:(LRWWeiBoFriendShipStyleCartoon)];
            a.showNavagationBar = YES;
            [self.navigationController pushViewController:a animated:YES];
        }
           
            break;
        case 765014:
        {
            LRWWeiBoUserFriendsTableViewController *a = [[LRWWeiBoUserFriendsTableViewController alloc]initWithFriendShipStyle:(LRWWeiBoFriendShipStyleBusiness)];
            a.showNavagationBar = YES;
            [self.navigationController pushViewController:a animated:YES];
        }
            break;
            
        default:
            break;
    }
}
- (void)moreCatalogue
{

}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if(section == 0)
        return 0;
    else
        return 30;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2) {
        User *user = _hotUsers[indexPath.row];
        LRWWeiBoUserPageTableViewControl *userPage = [LRWWeiBoUserPageTableViewControl new];
        userPage.user = user;
        
        [self.navigationController pushViewController:userPage animated:YES];
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0.1;
    }
    else if (section == 1)
        return 5;
    else
    return 25;
}


#pragma mark - 加载跟多人
- (void)moreBtnClick:(id)sender
{
    LRWWeiBoUserFriendsTableViewController *friends = [[LRWWeiBoUserFriendsTableViewController alloc] initWithFriendShipStyle:LRWWeiBoFriendShipStyleSpecial];
    friends.showNavagationBar = YES;
    [self.navigationController pushViewController:friends animated:YES];
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
