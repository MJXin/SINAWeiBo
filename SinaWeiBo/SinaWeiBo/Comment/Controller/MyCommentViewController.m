//
//  MyCommentViewController.m
//  SinaWeiBo
//
//  Created by William-zhang on 15/2/7.
//  Copyright (c) 2015年 LMZ. All rights reserved.
//

#import "MyCommentViewController.h"
#import "Comment.h"
#import "CommentList.h"
#import "Statu.h"
#import "StatuRequest.h"
#import "User.h"
#import "MyCommentCell.h"
#import "SendCommentController.h"
#import "LRWWeiBoLabel.h"
#import "StatuDetialViewController.h"
#import "AppDelegate.h"

@interface MyCommentViewController ()
{
    NSString* _url;

    CommentList* _commentList;
    BOOL _finished;
    CGFloat _height;
    CommentRequest* _request;
    NSIndexPath* _clickCellIndex;
    NSUInteger _userId;
    NSString* _token;
    
}

@end

@implementation MyCommentViewController

-(instancetype)init
{
    if(self = [super init])
    {
        self.showNavagationBar = YES;
        AppDelegate* ad = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        _userId = [ad.currentUID integerValue];
        _token = ad.currentAccessToken;
        _request = [CommentRequest new];
        _request.delegate = self;
        self.delegate = self;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return self;
}

#pragma mark - 评论类型的set方法
-(void)setCommentType:(WLComentType)commentType
{
    _commentType = commentType;
    switch (_commentType) {
        case WLAllComentType:
            self.title = @"所有评论";
            _url = @"https://api.weibo.com/2/comments/timeline.json";
            break;
        case WLMentionMeComentType:
            self.title = @"@我的评论";
            _url = @"https://api.weibo.com/2/comments/mentions.json";
            break;
        case WLSendByMeCommentType:
            self.title = @"我发出的评论";
            _url = @"https://api.weibo.com/2/comments/by_me.json";
            break;
        case WLSendToMeCommentType:
            self.title = @"我收到的评论";
            _url = @"https://api.weibo.com/2/comments/to_me.json";
            break;
        default:
            break;
    }
    [self requestComment];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return _height+10;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _commentList.comments.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyCommentCell* cell = [tableView dequeueReusableCellWithIdentifier:@"comment"];
    if (!cell) {
        cell = [[MyCommentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"comment"];
    }
    [cell setContentViewNULL];
    cell.width = tableView.frame.size.width;
    cell.comment = _commentList.comments[indexPath.row];
    cell.delegate = self;
    [self replyHidden:cell index:indexPath.row+1000];
    _finished = YES;
    _height = cell.height;
    return cell;
}

#pragma mark - 隐藏/显示回复按钮
-(void)replyHidden:(MyCommentCell*)cell index:(NSUInteger)index
{
    cell.replyButton.tag = index;
    if (cell.comment.user.Id != _userId) {
        cell.replyButton.hidden = NO;
    }
    else
    {
        cell.replyButton.hidden = YES;
    }
}

#pragma mark - cell的代理方法实现（回复按钮的方法）
-(void)replyComment:(UIButton*)sender
{
    NSLog(@"回复");
    Comment* comment = (Comment*)_commentList.comments[sender.tag-1000];
    SendCommentController* send = [[SendCommentController alloc]init];
    send.statu = comment.status;
    send.comment = comment;
    send.controllerType = WLReplyControllerType;
    send.placeholderText = @"回复评论...";
    [self presentViewController:send animated:YES completion:nil];
//    [self.navigationController pushViewController:send animated:YES];
    
}

#pragma mark - cell的代理方法实现（点击微博View）
-(void)statusViewClicked:(Statu *)statu
{
    [self TurnToStatusView:statu];
}

//#pragma mark - 根据微博id请求一条微博
//-(void)requestStatuById:(NSString*)statuId
//{
//    StatuRequest* request = [StatuRequest new];
//    request.delegate = self;
//    RequestStatuParma* parma = [[RequestStatuParma alloc]initWithAccess_token:_token];
//    parma.Id = statuId;
//    [request ShowStatuWithPramas:parma];
//}

#pragma mark - 跳转到单挑微博页面
-(void)TurnToStatusView:(Statu*)statu
{
    StatuDetialViewController* statuDVC = [[StatuDetialViewController alloc]initWithStatu:statu];
    statuDVC.showNavagationBar = YES;
    statuDVC.showToolBar = YES;
    self.hidesBottomBarWhenPushed = YES;
    statuDVC.statu = statu;
    [self.navigationController pushViewController:statuDVC animated:YES];
}

#pragma mark - 点击单条评论时
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Comment* comment = _commentList.comments[indexPath.row];
    _clickCellIndex = indexPath;
    UIActionSheet* action;
    if (comment.status.user.Id == _userId) {
        if (comment.user.Id == _userId) {
            action = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"删除" otherButtonTitles:@"复制", @"查看微博", nil];
        }
        else
        {
            action = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"删除" otherButtonTitles:@"复制", @"查看微博",@"回复", nil];
        }
    }
    else
    {
        if (comment.user.Id == _userId) {
             action = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"删除" otherButtonTitles:@"复制", @"查看微博", nil];
        }
        else
        {
             action = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"回复",@"复制", @"查看微博", nil];
        }
       
    }
    [action showInView:self.view];
}

#pragma mark - ActionSheet代理方法实现
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString* btnTitle = [actionSheet buttonTitleAtIndex:buttonIndex];
    if ([btnTitle isEqualToString:@"回复"]) {
        NSLog(@"回复");
        [self replyCommentByIndex:_clickCellIndex.row];
    }
    else if([btnTitle isEqualToString:@"复制"])
    {
        NSLog(@"复制");
        Comment* comment = (Comment*)_commentList.comments[_clickCellIndex.row];
        NSString* text = [[NSString alloc]initWithFormat:@"@%@：%@",comment.user.name,comment.text];
        [self copyWithText:text];
    }
    else if([btnTitle isEqualToString:@"删除"])
    {
        NSLog(@"删除");
        UIActionSheet* sheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"删除评论", nil];
        [sheet showInView:self.view];
    }
    else if([btnTitle isEqualToString:@"删除评论"])
    {
        NSLog(@"删除评论");
        [self deleteCommentByIndex:_clickCellIndex.row];
    }
    else if([btnTitle isEqualToString:@"查看微博"])
    {
        NSLog(@"查看微博");
        Comment* comment = (Comment*)_commentList.comments[_clickCellIndex.row];
        [self TurnToStatusView:comment.status];
    }
}

#pragma mark - 删除评论
-(void)deleteCommentByIndex:(NSUInteger)index
{
    Comment* comment = (Comment*)_commentList.comments[index];
    RequestCommentParma* parma = [[RequestCommentParma alloc]initWithAccess_token:_token];
    parma.cid = [NSString stringWithFormat:@"%ld",comment.Id];
    [_request deleteCommentWithParmas:parma];
}

#pragma mark - 进入回复界面
-(void)replyCommentByIndex:(NSUInteger)index
{
    SendCommentController* send = [[SendCommentController alloc]init];
    Comment* comment = (Comment*)_commentList.comments[index];
    send.statu = comment.status;
    send.comment = comment;
    send.controllerType = WLReplyControllerType;
    [self presentViewController:send animated:YES completion:nil];
//    [self.navigationController pushViewController:send animated:YES];
}

#pragma mark - ActionSheet的复制方法
-(void)copyWithText:(NSString*)text
{
    //复制评论内容到剪切板
    NSLog(@"复制");
    UIPasteboard* pasteBorad = [UIPasteboard generalPasteboard];
    pasteBorad.string = text;
}

#pragma mark - 下拉刷新
-(void)refreshTableViewControllerHeadViewDidStartLoding:(LRWRefreshTableViewController *)tableViewController
{
    Comment* comment = (Comment*)_commentList.comments[0];
    _requestParma.max_id = 0;
    _requestParma.since_id = [NSString stringWithFormat:@"%ld",comment.Id];
    [_request commentByURL:_url Parmas:_requestParma];
}

#pragma mark - 上拉加载更多数据
-(void)refreshTableViewControllerBottomViewDidStartLoding:(LRWRefreshTableViewController *)tableViewController
{
    Comment* comment = (Comment*)_commentList.comments[_commentList.comments.count -1];
    if (comment.floorNum > 1) {
        _requestParma.since_id = 0;
        _requestParma.max_id = [NSString stringWithFormat:@"%ld",comment.Id];
        [_request commentByURL:_url Parmas:_requestParma];
    }
}

#pragma mark - 请求评论数据
-(void)requestComment
{
    [_request commentByURL:_url Parmas:self.requestParma];
}

#pragma mark - 评论请求结束后的代理方法
-(void)commentOfURLRequestDidFinshed:(CommentList *)commentList State:(NSInteger)state Error:(NSError *)error
{
    if (!error) {
        if (state == 0) {
            _commentList = commentList;
            [self.tableView reloadData];
            NSLog(@"评论数据加载成功");
        }
        else if (state == 1)
        {
            if (commentList.comments.count > 0) {
                NSMutableArray* new = [[NSMutableArray alloc]initWithArray:commentList.comments];
                [new addObjectsFromArray:_commentList.comments];
                _commentList.total_number = new.count;
                _commentList.comments = new;
            }
            [self hideTopView];

        }
        else
        {
            if (commentList.comments.count > 0) {
                NSMutableArray* new = [[NSMutableArray alloc]initWithArray:_commentList.comments];
                [new addObjectsFromArray:commentList.comments];
                _commentList.total_number = new.count;
                _commentList.comments = new;
            }
            [self hideBottomView];
        }
    }
    else
    {
        NSLog(@"评论数据加载出错:%@",error);
    }
    [self.tableView reloadData];
}

#pragma mark - 删除评论结束后的代理方法
-(void)deleteCommentDidiFinishedError:(NSError *)error
{
    if (!error) {
        NSLog(@"删除成功");
        NSMutableArray* comments = [[NSMutableArray alloc]initWithArray:_commentList.comments];
        [comments removeObjectAtIndex:_clickCellIndex.row];
        _commentList.comments = comments;
        [self.tableView deleteRowsAtIndexPaths:@[_clickCellIndex] withRowAnimation:UITableViewRowAnimationLeft];
    }
    else
    {
        NSLog(@"删除失败");
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
