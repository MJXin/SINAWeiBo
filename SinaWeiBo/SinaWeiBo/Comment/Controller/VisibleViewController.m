//
//  VisibleViewController.m
//  SinaWeiBo
//
//  Created by William-zhang on 15/2/9.
//  Copyright (c) 2015年 LMZ. All rights reserved.
//

#import "VisibleViewController.h"

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@interface VisibleViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    //可见性选择列表
    UITableView* _visibleTable;
    
    UINavigationBar* _navBar;
    UINavigationItem* _navItem;
    NSArray* _buttons;
}
@end

@implementation VisibleViewController

-(instancetype)init
{
    if (self = [super init]) {
        _navBar = [[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
        _navItem = [[UINavigationItem alloc]initWithTitle:@"选择分享范围"];
        [_navBar pushNavigationItem:_navItem animated:NO];
        [self.view addSubview:_navBar];
        _visibleTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 150) style:UITableViewStylePlain];
        _visibleTable.delegate = self;
        _visibleTable.dataSource = self;
        [self.view addSubview:_visibleTable];
        _buttons = [[NSArray alloc]initWithObjects:[self selectedButton],[self selectedButton],[self selectedButton], nil];
        UIButton* btn = (UIButton*)_buttons[0];
        btn.selected = YES;
        btn.backgroundColor = [UIColor orangeColor];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIBarButtonItem* canel = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
    _navItem.leftBarButtonItem = canel;
    UIButton* btn = (UIButton*)_buttons[0];
    btn.selected = YES;
    btn.backgroundColor = [UIColor orangeColor];
}

#pragma mark - visible的set方法
-(void)setVisible:(NSInteger)visible
{
    _visible = visible;
    NSInteger index = _visible;
    if (index == 1) {
        index = 2;
    }
    else if (index == 2)
    {
        index = 1;
    }
    [self cellClicked:index];
}


#pragma mark - 返回方法
-(void)goBack
{
    //    NSLog(@"返回");
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"item"];
    CGRect f = cell.frame;
    f.origin.x += 100;
    cell.frame = f;
    UIButton* btn = (UIButton*)_buttons[indexPath.row];
    btn.tag = 200+indexPath.row;
    UIView* view;
    switch (indexPath.row) {
        case 0:
            view = [self cellViewByTitle:@"公开" SubTitle:@"所有人可见"];
            break;
        case 1:
            view = [self cellViewByTitle:@"好友圈" SubTitle:@"相互关注好友可见"];
            break;
        case 2:
            view = [self cellViewByTitle:@"仅自己可见" SubTitle:nil];
            break;
        default:
            break;
    }
    [view addSubview:btn];
    [cell addSubview:view];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self cellClicked:indexPath.row];
}

#pragma mark - cell点击方法
-(void)cellClicked:(NSInteger)index
{
    for (NSInteger i = 0; i<3;i++) {
        UIButton* btn = (UIButton*)_buttons[i];
        if (index == i) {
            btn.selected = YES;
            btn.backgroundColor = [UIColor orangeColor];
        }
        else
        {
            btn.selected = NO;
            btn.backgroundColor = [UIColor clearColor];
        }
    }
    //参数和界面的选项不对应，需要转化一下再调用代理方法
    if (index == 1) {
        index = 2;
    }
    else if(index == 2)
    {
        index = 1;
    }
    if ([self.delegate respondsToSelector:@selector(itemDidClicked:)]) {
        [self.delegate itemDidClicked:index];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - button的点击方法
-(void)buttonClicked:(UIButton*)button
{
    [self cellClicked:button.tag-200];
}

#pragma mark - 生成一个cellView
-(UIView*)cellViewByTitle:(NSString*)title SubTitle:(NSString*)subTitle
{
    CGFloat cellHeight = 55;
    CGFloat labelHeight = 10;
    UIView* view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, cellHeight)];
    CGFloat dit = labelHeight;
    if (subTitle) {
        UILabel* subTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(40, dit*3, SCREEN_WIDTH, dit*0.8)];
        subTitleLabel.text = subTitle;
        subTitleLabel.textColor = [UIColor lightGrayColor];
        subTitleLabel.font = [UIFont systemFontOfSize:13];
        [view addSubview:subTitleLabel];
    }
    else
    {
        dit = (cellHeight - labelHeight)/4;
    }
    UILabel* titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(40, dit, SCREEN_WIDTH, dit*1.5)];
    titleLabel.text = title;
    [view addSubview:titleLabel];
    return view;
}

#pragma mark - 生成一个button
-(UIButton*)selectedButton
{
    UIButton* btn = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 20, 20)];
    btn.backgroundColor = [UIColor clearColor];
    btn.layer.cornerRadius = 10;
    btn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    btn.layer.borderWidth = 1;
    [btn setImage:[UIImage imageNamed:@"compose_photo_preview_right"] forState:UIControlStateSelected];
    [btn setTitle:@"" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    return btn;
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

@end
