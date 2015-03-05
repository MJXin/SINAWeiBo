//
//  LRWResultViewController.m
//  微博SDK测试
//
//  Created by lrw on 15/2/3.
//  Copyright (c) 2015年 LRW. All rights reserved.
//

#import "LRWResultViewController.h"

@interface LRWResultViewController ()
{
    NSMutableArray *_dataSource;
}
@end

@implementation LRWResultViewController
- (instancetype)initWithType:(LRWSearchType)searchType
{
    if (self = [super initWithStyle:UITableViewStyleGrouped])
    {
        _searchtype = searchType;
    }
    return self;
}
- (instancetype)initWithStyle:(UITableViewStyle)style
{
    if (self = [super initWithStyle:UITableViewStyleGrouped]) {
        
    }
    return self;
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    NSString *searchString = searchController.searchBar.text;
    [self searchResultByString:searchString];
}

#pragma mark - 搜索
- (void)searchResultByString:(NSString *)string
{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    [_dataSource removeAllObjects];
    
    if (_searchtype == LRWSearchTypeTopic) {
        for (Trend *aTrend in _dataArray) {
            NSString *name = [NSString stringWithFormat:@"#%@#",aTrend.name];
            if ([name containsString:string]) {
                NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:name];
                [attributedString addAttributes:@{NSForegroundColorAttributeName : [UIColor redColor]} range:[name rangeOfString:string]];
                [_dataSource addObject:attributedString];
            }
        }
    }
    
    else if(_searchtype == LRWSearchTypeAt)
    {
        for (User *aUser in _dataArray) {
            NSString *name = [NSString stringWithFormat:@"@%@",aUser.screen_name];
            if ([name containsString:string]) {
                NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:name];
                [attributedString addAttributes:@{NSForegroundColorAttributeName : [UIColor redColor]} range:[name rangeOfString:string]];
                [_dataSource addObject:attributedString];
            }
        }
    }
    
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
     self.edgesForExtendedLayout = UIRectEdgeNone;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.edgesForExtendedLayout = UIRectEdgeNone;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    if (_searchtype == LRWSearchTypeTopic) {
        cell = [LRWCreateCellInSearchOrResult createTopicCellInTableView:tableView searchType:_searchtype cellData:_dataArray[indexPath.row]];
    }
    else
    {
        cell = [LRWCreateCellInSearchOrResult createAtCellInTableView:tableView searchType:_searchtype cellData:_dataArray[indexPath.row]];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1.0; 
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.delegate resultViewController:self didClickCell:[tableView cellForRowAtIndexPath:indexPath] searchType:_searchtype];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return SEARCHCELLHEIGHT;
}

#pragma mark - 修改系统cell的图片
@end
