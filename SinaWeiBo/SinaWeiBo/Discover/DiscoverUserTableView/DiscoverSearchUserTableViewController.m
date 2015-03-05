//
//  DiscoverSearchTableViewController.m
//  WBTest
//
//  Created by mjx on 15/2/6.
//  Copyright (c) 2015年 MJX. All rights reserved.
//

#import "DiscoverSearchUserTableViewController.h"
#import "LRWWeiBoUserPageTableViewControl.h"
#import "AppDelegate.h"
@interface DiscoverSearchUserTableViewController ()
{
    NSString *_q;
    NSArray *_searchData;
    
}
@end

@implementation DiscoverSearchUserTableViewController
- (BOOL)prefersStatusBarHidden
{
    return YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"查找";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    //self.view.window.rootViewController.tabBarController.tabBar.hidden = YES;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //[self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:0];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.tabBarController.tabBar.hidden = YES;
    UITabBarController *tabe =(UITabBarController *)[[[UIApplication sharedApplication] windows][1] rootViewController];
    tabe.tabBar.hidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated
{
    UITabBarController *tabe =(UITabBarController *)[[[UIApplication sharedApplication] windows][1] rootViewController];
    tabe.tabBar.hidden = NO;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}

- (void)didPresentSearchController:(UISearchController *)searchController
{
    
}
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    AppDelegate *appDelegate =  (AppDelegate *)[[UIApplication sharedApplication] delegate];
    SearchSuggestionsRequest *request = [SearchSuggestionsRequest new];
   // RequestSearchSuggestionsParma *parma = [[RequestSearchSuggestionsParma alloc]initWithAccess_token:@"2.00JCy8pB0QTDbXe7b457a65eHnLwDB"];
    RequestSearchSuggestionsParma *parma = [[RequestSearchSuggestionsParma alloc]initWithAccess_token:appDelegate.currentAccessToken];
    request.delegate = self;
    parma.q = searchBar.text;
    parma.count = @"20";
    [request UserSearchSuggestionRequestWithParma:parma];
}
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    
}
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{

}
- (void)UserSearchSuggestionRequestDidFinishedWithUserSearchSuggestions:(NSArray *)userSearchSuggestions error:(NSError *)error
{
    _searchData = userSearchSuggestions;
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return _searchData.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"user"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"user"];
    }
    UserSearchSuggestion *user = _searchData[indexPath.row];
    cell.textLabel.text = user.screen_name;
    cell.imageView.image = [UIImage imageNamed:@"noPhoto"];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"粉丝数:%@",[user.followers_count stringValue]];
    cell.detailTextLabel.textColor = [UIColor grayColor];
    
    
    // Configure the cell...
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UserSearchSuggestion *user = _searchData[indexPath.row];
    LRWWeiBoUserPageTableViewControl *userPage = [LRWWeiBoUserPageTableViewControl new];
    userPage.userName = user.screen_name;
    
   // [self dismissViewControllerAnimated:YES completion:nil];
    [self.preController.navigationController pushViewController:userPage animated:YES];
    [self dismissViewControllerAnimated:NO completion:nil];
    




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
