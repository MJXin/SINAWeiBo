//
//  MessageViewController.m
//  SinaWeiBo
//
//  Created by William-zhang on 15/2/5.
//  Copyright (c) 2015年 LMZ. All rights reserved.
//

#import "MessageViewController.h"
#import "MyCommentViewController.h"
#import "RequestCommentParma.h"
#import "AppDelegate.h"

#define DITX 15
#define DITY 5
#define CELLHEIGHT 60
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define MYGARY [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1];

@interface MessageViewController ()
{
    NSArray* _items;
    NSArray* _itemsImage;
    NSMutableArray* _itemsView;
    NSString* _token;
}

@end

@implementation MessageViewController

-(instancetype)init
{
    if (self = [super initWithStyle:UITableViewStyleGrouped]) {
        self.title = @"消息";
        self.showNavagationBar = YES;
        self.showToolBar = NO;
        [self setUpData];
    }
    return self;
}

#pragma mark - 初始化数据
-(void)setUpData
{
    _items = @[@"@我的微博",@"@我的评论",@"所有评论",@"我收到的评论",@"我发出的评论"];
    _itemsImage = @[@"wl_mention",@"wl_comments_mention",@"wl_comments",@"wl_comments_othersend",@"wl_comments_mysend"];
    _itemsView = [NSMutableArray new];
    for (int i = 0; i<_items.count; i++) {
        UIImage* image = [UIImage imageNamed:_itemsImage[i]];
        [_itemsView addObject:[self viewByName:_items[i] Image:image]];
    }
    self.delegate = self;
}

#pragma mark - 根据一个字符串和一张图片生成一个cell
-(UIView*)viewByName:(NSString*)string Image:(UIImage*)image
{
    UIView* view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, CELLHEIGHT)];
    //加入图片
    view.backgroundColor = [UIColor whiteColor];
    UIImageView* imgView = [[UIImageView alloc]initWithImage:image];
    CGFloat imgWidth = CELLHEIGHT - DITY*2;
    imgView.frame = CGRectMake(DITX, DITY, imgWidth, imgWidth);
    [view addSubview:imgView];
    //加入Label
    UILabel* label = [[UILabel alloc]initWithFrame:CGRectMake(DITX*2+imgWidth, 0, 200, CELLHEIGHT)];
    label.text = string;
    [view addSubview:label];
    
    UIImageView* turn = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 25, 23, CELLHEIGHT-45, CELLHEIGHT-45)];
    turn.image = [UIImage imageNamed:@"wl_timeline_rightarrow"];
    [view addSubview:turn];
    view.layer.shadowColor = [UIColor grayColor].CGColor;
    view.layer.shadowOffset = CGSizeMake(0, 0.5);
    view.layer.shadowOpacity = 0.2;
    view.layer.shadowRadius = 0.5;
    return view;
}

- (void)viewDidLoad {
    [super viewDidLoad];
     self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLineEtched;
    self.view.backgroundColor = MYGARY;
    AppDelegate* ad = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    _token = ad.currentAccessToken;
//    NSLog(@"_token:%@",_token);
    // Do any additional setup after loading the view.
}

#pragma mark - tableView的代理方法实现
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _items.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return CELLHEIGHT+10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"item"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"item"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    UIView* cellView = (UIView*)_itemsView[indexPath.row];
    [cellView removeFromSuperview];
    cell.backgroundColor = MYGARY;
    [cell.contentView addSubview:cellView];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        //@我的微博
        case 0:
            [self TurnToMentionStatu];
            break;
            
        //@我的评论
        case 1:
            [self TurnToMentionComment];
            break;
            
        //所有评论
        case 2:
            [self TurnToAllComment];
            break;
            
        //我收到的评论
        case 3:
            [self TurnToSendToMeComment];
            break;
            
        //我发出的评论
        case 4:
            [self TurnToSendByMeComment];
            break;
  
        default:
            break;
    }
}

#pragma mark - 跳转到 @我的微博
-(void)TurnToMentionStatu
{
    
}

#pragma mark - 跳转到 @我的评论 
-(void)TurnToMentionComment
{
    MyCommentViewController* cvc = [MyCommentViewController new];
    cvc.requestParma  = [[RequestCommentParma alloc]initWithAccess_token:_token];
    cvc.commentType = WLMentionMeComentType;
    [self.navigationController pushViewController:cvc animated:YES];
}

#pragma mark - 跳转到 所有评论
-(void)TurnToAllComment
{
    MyCommentViewController* cvc = [MyCommentViewController new];
    cvc.requestParma  = [[RequestCommentParma alloc]initWithAccess_token:_token];
    cvc.commentType = WLAllComentType;
    [self.navigationController pushViewController:cvc animated:YES];
}

#pragma mark - 跳转到 我收到的评论
-(void)TurnToSendToMeComment
{
    MyCommentViewController* cvc = [MyCommentViewController new];
    cvc.requestParma  = [[RequestCommentParma alloc]initWithAccess_token:_token];
    cvc.commentType = WLSendToMeCommentType;
    [self.navigationController pushViewController:cvc animated:YES];
}

#pragma mark - 跳转到 我发出的评论
-(void)TurnToSendByMeComment
{
    MyCommentViewController* cvc = [MyCommentViewController new];
    cvc.requestParma  = [[RequestCommentParma alloc]initWithAccess_token:_token];
    cvc.commentType = WLSendByMeCommentType;
    [self.navigationController pushViewController:cvc animated:YES];
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.tabBarController.tabBar.hidden = NO;
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
