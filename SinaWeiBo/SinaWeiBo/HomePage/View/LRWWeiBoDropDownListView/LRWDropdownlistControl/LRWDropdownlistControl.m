//
//  LRWDropdownlistControl.m
//  下拉列表
//
//  Created by lrw on 15/1/28.
//  Copyright (c) 2015年 LRW. All rights reserved.
//
#define TABLEVIEWWIDTH self.tableView.bounds.size.width
#import "LRWDropdownlistControl.h"
@interface LRWDropdownlistControl ()
{
    /**table view 的数据*/
    NSArray *_data;
    /**每个分组头部视图的高度*/
    CGFloat _headerViewHeight;
    /**每个分组头部视图的颜色*/
    UIColor *_headerViewContentColor;
    /**每个分组头部字体*/
    UIFont *_headerViewFont;
    /**table view 的背景颜色*/
    UIColor *_myBackgroundColor;
    /**每隔cell的高度*/
    CGFloat _cellHeight;
    /**cell被选中的背影颜色*/
    UIColor *_selectedCellBackgroundColor;
    /**cell没有被选中的背景颜色*/
    UIColor *_defaultCellBackgroundColor;
    /**cell字体被选中的颜色*/
    UIColor *_selectedCellTextColor;
    /**cell字体没有被选中的颜色*/
    UIColor *_defaultCellTextColor;
    /**哪一行cell被选中*/
    NSIndexPath *_selectedIndexPath;
}
@end

@implementation LRWDropdownlistControl

- (instancetype)initWithStyle:(UITableViewStyle)style
{
    if (self = [super initWithStyle:UITableViewStyleGrouped]) {
        //初始化数据
        _headerViewFont = [UIFont systemFontOfSize:10];
        _myBackgroundColor = [UIColor clearColor];
        _headerViewContentColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        _headerViewHeight = 10;
        _cellHeight = 30;
        _defaultCellBackgroundColor = _myBackgroundColor;
        _defaultCellTextColor = [UIColor whiteColor];
        _selectedCellTextColor = [UIColor orangeColor];
        _selectedCellBackgroundColor = [UIColor colorWithRed:0 green:0.5 blue:1 alpha:0.5];
        [self addObserver:self forKeyPath:@"alpha" options:(NSKeyValueObservingOptionNew) context:nil];
    }
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
//    NSLog(@"alpha");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.bounces = NO;
    self.tableView.layer.cornerRadius = 2;
    self.tableView.backgroundColor = _myBackgroundColor;
    self.tableView.clipsToBounds = YES;
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return _data.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSDictionary *dic = _data[section];
    return [dic[@"rows"] count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"contact";
    
    //获得cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        cell.clipsToBounds = YES;
        cell.layer.cornerRadius = 2;
    }
    
    //跟新颜色
    if (_selectedIndexPath == indexPath) {
        cell.backgroundColor = _selectedCellBackgroundColor;
        cell.textLabel.textColor = _selectedCellTextColor;
        cell.selected = YES;
    }
    else
    {
        cell.backgroundColor = _defaultCellBackgroundColor;
        cell.textLabel.textColor = _defaultCellTextColor;
    }
    
    //设置cell数据
    NSDictionary *dic = _data[indexPath.section];
    NSArray *rows = dic[@"rows"];
    cell.textLabel.text = rows[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return _cellHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    NSString *title = _data[section][@"title"];
    if ([title isEqualToString:@""]) {
        return 1;
    }
    else
    {
        return _headerViewHeight;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _selectedIndexPath = indexPath;
    UITableViewCell *selectCell = [tableView cellForRowAtIndexPath:indexPath];
    selectCell.textLabel.textColor = _selectedCellTextColor;
    selectCell.backgroundColor = _selectedCellBackgroundColor;
    #pragma mark 在这里调用代理方法
    if ([self.delegate respondsToSelector:@selector(dropdownlistControl:didSelectedRowInGroup:row:)]) {
        [self.delegate dropdownlistControl:self didSelectedRowInGroup:indexPath.section row:indexPath.row];
    }
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *selectCell = [tableView cellForRowAtIndexPath:indexPath];
    selectCell.textLabel.textColor = _defaultCellTextColor;
    selectCell.backgroundColor = _defaultCellBackgroundColor;

}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, TABLEVIEWWIDTH, _headerViewHeight)];
        headerView.backgroundColor = _myBackgroundColor;
    NSString *title = _data[section][@"title"];
    if (![title isEqualToString:@""]) {
        CGFloat leftLineWidth = TABLEVIEWWIDTH * 0.1;
        UIView *leftLine = [[UIView alloc] initWithFrame:CGRectMake(0, _headerViewHeight * 0.5 , leftLineWidth, 1)];
        leftLine.backgroundColor = _headerViewContentColor;
        leftLine.alpha = 0.5;
        [headerView addSubview:leftLine];
    
        
        UILabel *label = [[UILabel alloc] init];
        label.text = title;
        label.font = _headerViewFont;
        label.textColor = _headerViewContentColor;
        CGFloat labelWidth = [title sizeWithAttributes:@{NSFontAttributeName : _headerViewFont}].width;
        label.frame = CGRectMake(leftLineWidth, 0, labelWidth, _headerViewHeight);
        [headerView addSubview:label];
        
        CGFloat rightLineWidth = TABLEVIEWWIDTH - leftLineWidth - labelWidth;
        CGFloat rightLineX = CGRectGetMaxX(label.frame);
        UIView *rightLine = [[UIView alloc] initWithFrame:CGRectMake(rightLineX, _headerViewHeight * 0.5 , rightLineWidth, 1)];
        rightLine.backgroundColor = _headerViewContentColor;
        rightLine.alpha = 0.5;
        [headerView addSubview:rightLine];
        return headerView;
    }
    return headerView;
}

#pragma mark - 跟新数据源方法
- (void)setData:(NSArray *)listData
{
    _data = listData;
    [self.tableView reloadData];
}
#pragma mark - 设置选中那一行
- (void)selectedRowInNSIndexPath:(NSIndexPath *)indexPath
{
    _selectedIndexPath = indexPath;
    [self.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:0];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.tableView selectRowAtIndexPath:_selectedIndexPath animated:YES scrollPosition:(UITableViewScrollPositionNone)];
}


@end
