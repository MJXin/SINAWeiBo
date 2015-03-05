//
//  StatuDetialViewController.m
//  SinaWeiBo
//
//  Created by William-zhang on 15/2/6.
//  Copyright (c) 2015年 LMZ. All rights reserved.
//

#import "StatuDetialViewController.h"
#import "Statu.h"
#import "User.h"
#import "CommentTableViewCell.h"
#import "SendCommentController.h"
#import "AppDelegate.h"
#import "LRWWeiBoCell.h"
#import "LRWWeiBoContentView.h"
#import "StatusFrame.h"
#import "CommentRequest.h"
#import "LRWWeiBoLabel.h"
#import "StatuRequest.h"

#define BUTTONWIDTH 80
#define BUTTONHEIGHT 45
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)


@interface StatuDetialViewController ()<CommentDelegate, LRWWeiBoLabelDelegate, UIActionSheetDelegate, StatuRequestDelegate, LRWRefreshTableViewControllerDelegate>
{
    //评论或转发列表
    CommentList* _commentList;
    //cell的高度
    CGFloat _height;
    //评论请求类
    CommentRequest* _request;
    //被点击的cell的indexPath
    NSIndexPath* _clickCellIndex;
    //查看转发情况按钮
    UIButton* _retweetedNumberBtn;
    //查看评论情况的按钮
    UIButton* _commentNumberBtn;
    //查看赞数的按钮
    UIButton* _attitudesNumberBtn;
    
    //请求凭证
    NSString* _token;
    NSString* _userId;
    
    LRWWeiBoContentView *_weiboContentView;
    CGFloat _statuViewHeight;
    
    //底部toolbar
    UITabBarController* _commentMenu;
    UIView* _menu;
    
    UITableViewCell* _statuCell;
    StatusFrame *frames;
    
    UIImageView* _arrow;
}

@end

@implementation StatuDetialViewController

-(instancetype)init
{
    if (self = [super init]) {
        AppDelegate *myDelegate =(AppDelegate*)[[UIApplication sharedApplication] delegate];
        _token = myDelegate.currentAccessToken;
//        NSLog(@"token:%@",_token);
        _userId = myDelegate.currentUID;
    }
    return self;
}

/**如果能确定statu里面的数据是完整的，请用这个初始化方法来跳到单条微博界面
 */
-(instancetype)initWithStatu:(Statu *)statu
{
    if (self = [super initWithStyle:UITableViewStylePlain]) {
        AppDelegate *myDelegate =(AppDelegate*)[[UIApplication sharedApplication] delegate];
        _token = myDelegate.currentAccessToken;
//        NSLog(@"token:%@",_token);
        _userId = myDelegate.currentUID;
        [self setUp:statu];
    }
    return self;
}

#pragma mark - 内容初始化方法,这个方法传入的statu数据一定要完整
-(void)setUp:(Statu*)statu
{
    self.title = @"微博正文";
    self.view.backgroundColor = [UIColor whiteColor];
    _statu = statu;
    _height = 100;
    _weiboContentView = [LRWWeiBoContentView new];
    _weiboContentView.showMediumPicture = YES;
    _weiboContentView.status = statu;
    _statuCell = [[UITableViewCell alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
    _statuCell.selectionStyle = UITableViewCellSelectionStyleNone;

    frames = [StatusFrame new];
    frames.status = statu;
    frames.showMediumPicture = YES;
    _weiboContentView.statusFrame = frames;
    _statuViewHeight = frames.cellHeight;
    _weiboContentView.frame = CGRectMake(0, 0, SCREEN_WIDTH, _statuViewHeight);
    UIView* hiddenView = [[UIView alloc]initWithFrame:frames.toolBarFrame];
    hiddenView.backgroundColor = [UIColor whiteColor];
    [_weiboContentView addSubview:hiddenView];
    
    UIView* view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 300)];
    [view addSubview:_weiboContentView];
    
    [_statuCell addSubview:view];
//    [_statuCell.contentView addSubview:_weiboContentView];
    
    _arrow = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"wl_statusdetail_comment_top_arrow"]];
    _retweetedNumberBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, 0, BUTTONWIDTH, BUTTONHEIGHT)];
    [_retweetedNumberBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [_retweetedNumberBtn addTarget:self action:@selector(displayRetweeted) forControlEvents:UIControlEventTouchUpInside];
    _commentNumberBtn = [[UIButton alloc]initWithFrame:CGRectMake(30+BUTTONWIDTH, 0, BUTTONWIDTH, BUTTONHEIGHT)];
    [_commentNumberBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [_commentNumberBtn addTarget:self action:@selector(displayComment) forControlEvents:UIControlEventTouchUpInside];
    _attitudesNumberBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - BUTTONWIDTH - 20, 0, BUTTONWIDTH, BUTTONHEIGHT)];
    [_attitudesNumberBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [_retweetedNumberBtn setTitle:[NSString stringWithFormat:@"转发%ld",_statu.reposts_count] forState:UIControlStateNormal];
    [_commentNumberBtn setTitle:[NSString stringWithFormat:@"评论%ld",_statu.comments_count] forState:UIControlStateNormal];
    [_attitudesNumberBtn setTitle:[NSString stringWithFormat:@"赞%ld",_statu.attitudes_count] forState:UIControlStateNormal];
    [self setButtonFontNormal:_retweetedNumberBtn];
    [self setButtonFontBold:_commentNumberBtn];
    [self setButtonFontNormal:_attitudesNumberBtn];

    [self loadCommentList];
    
    CGRect f = self.tableView.frame;
    f.size.height -= 44;
    self.tableView.frame = f;
    
    //加入菜单栏

    _menu = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 44, SCREEN_WIDTH, 44)];
    _menu.backgroundColor = [UIColor whiteColor];
    _menu.layer.shadowColor = [UIColor blackColor].CGColor;
    _menu.layer.shadowOffset = CGSizeMake(0, -0.7);
    _menu.layer.shadowOpacity = 0.2;
    _menu.layer.shadowRadius = 0.7;
    UIButton* retweetedBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/3, 44)];
    [retweetedBtn setTitle:@" 转发" forState:0];
    [retweetedBtn setTitleColor:[UIColor lightGrayColor] forState:0];
    retweetedBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [retweetedBtn setImage:[UIImage imageNamed:@"wl_timeline_icon_retweet"] forState:0];
    [retweetedBtn addTarget:self action:@selector(retweetedStatu) forControlEvents:UIControlEventTouchUpInside];
    [_menu addSubview:retweetedBtn];
    
    UIImageView* hLine1 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"wl_statusdetail_comment_line"]];
    hLine1.frame = CGRectMake(SCREEN_WIDTH/3-1, BUTTONHEIGHT*0.2, 2, BUTTONHEIGHT*0.6);
    [_menu addSubview:hLine1];

    
    UIButton* commentBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/3, 0, SCREEN_WIDTH/3, 44)];
    [commentBtn setTitle:@" 评论" forState:0];
    [commentBtn setTitleColor:[UIColor lightGrayColor] forState:0];
    commentBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [commentBtn addTarget:self action:@selector(commentStatu) forControlEvents:UIControlEventTouchUpInside];
    [_menu addSubview:commentBtn];
    [commentBtn setImage:[UIImage imageNamed:@"wl_timeline_icon_comment"] forState:0];
    
    UIImageView* hLine2 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"wl_statusdetail_comment_line"]];
    hLine2.frame = CGRectMake((SCREEN_WIDTH/3)*2-1, BUTTONHEIGHT*0.2, 2, BUTTONHEIGHT*0.6);
    [_menu addSubview:hLine2];
    
    UIButton* attitudesBtn = [[UIButton alloc]initWithFrame:CGRectMake((SCREEN_WIDTH/3)*2, 0, SCREEN_WIDTH/3, 44)];
    [attitudesBtn setTitle:@" 赞" forState:0];
    attitudesBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [attitudesBtn setImage:[UIImage imageNamed:@"wl_timeline_icon_unlike"] forState:0];
    [attitudesBtn setTitleColor:[UIColor lightGrayColor] forState:0];
    [_menu addSubview:attitudesBtn];
    [self.view addSubview:_menu];
}

#pragma mark - 更新转发、评论等按钮
-(void)refreshAllButton:(Statu*)statu
{
    [_retweetedNumberBtn setTitle:[NSString stringWithFormat:@"转发%ld",statu.reposts_count] forState:UIControlStateNormal];
    [_commentNumberBtn setTitle:[NSString stringWithFormat:@"评论%ld",statu.comments_count] forState:UIControlStateNormal];
    [_attitudesNumberBtn setTitle:[NSString stringWithFormat:@"赞%ld",statu.attitudes_count] forState:UIControlStateNormal];
    _statu.reposts_count = statu.reposts_count;
    _statu.attitudes_count = statu.attitudes_count;
    _statu.comments_count = statu.comments_count;

}

#pragma mark - 让button的字体变粗
-(void)setButtonFontBold:(UIButton*)btn
{
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont boldSystemFontOfSize:15];
}

#pragma mark - 让button的字体变细
-(void)setButtonFontNormal:(UIButton*)btn
{
    [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
}

#pragma mark - 让箭头指向button
-(void)arrowLocationToButton:(UIButton*)btn
{
    CGRect f = _arrow.frame;
    f.origin.x = btn.frame.origin.x +(btn.frame.size.width-f.size.width)-40;
    [UIView beginAnimations:@"arrow" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.35];
    _arrow.frame = f;
    [UIView commitAnimations];
}

#pragma mark - 显示转发
-(void)displayRetweeted
{
//    NSLog(@"显示转发");
//    _isRetweeted = YES;
//    if (!_retweetedList) {
//        [self loadCommentList];
//    }
//    _commentList = _retweetedList;
//    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
    [self arrowLocationToButton:_retweetedNumberBtn];
    [self setButtonFontBold:_retweetedNumberBtn];
    [self setButtonFontNormal:_commentNumberBtn];
}

#pragma mark - 显示评论
-(void)displayComment
{
//    NSLog(@"显示评论");
//    _isRetweeted = NO;
//    if (_comments) {
//        [self loadCommentList];
//    }
//    _commentList = _comments;
//    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
    [self arrowLocationToButton:_commentNumberBtn];
    [self setButtonFontBold:_commentNumberBtn];
    [self setButtonFontNormal:_retweetedNumberBtn];

}


-(void)refreshTableViewControllerHeadViewDidStartLoding:(LRWRefreshTableViewController *)tableViewController
{
    //刷新微博
    [self requestStatuById:[NSString stringWithFormat:@"%ld",_statu.Id]];

    [self refreshComment];
}

#pragma mark - 下拉刷新评论
-(void)refreshComment
{
    //更新评论
    RequestCommentParma* parma = [[RequestCommentParma alloc]initWithAccess_token:_token];
    parma.status_Id = [NSString stringWithFormat:@"%ld",_statu.Id];
    if (_commentList.comments.count>0) {
        Comment* com = (Comment*)_commentList.comments[0];
        parma.since_id = [NSString stringWithFormat:@"%ld",com.Id];
    }
    [_request commentOfStatuWithParmas:parma Status:_statu];
}

#pragma mark - 下拉刷新转发
//-(void)refreshRetweeted
//{
//    _retweetedStasu = 1;
//
//    Statu* statu = (Statu*)_statuList.statuses[0];
//    StatuRequest* request = [StatuRequest new];
//    request.delegate = self;
//    RequestStatuParma* parma = [[RequestStatuParma alloc]initWithAccess_token:_token];
//    parma.Id = [NSString stringWithFormat:@"%ld",_statu.Id];
//    parma.since_id = [NSString stringWithFormat:@"%ld",statu.Id];
//    [request Repost_timelineDataRequestWithPramas:parma];
//}

-(void)refreshTableViewControllerBottomViewDidStartLoding:(LRWRefreshTableViewController *)tableViewController
{

    [self loadMoreComment];
}

#pragma mark - 上拉载入更多评论方法
-(void)loadMoreComment
{
  //加载更多评论
    Comment* com = (Comment*)_commentList.comments[_commentList.comments.count-1];
    if (com.floorNum >1) {
        RequestCommentParma* parma = [[RequestCommentParma alloc]initWithAccess_token:_token];
        parma.status_Id = [NSString stringWithFormat:@"%ld",_statu.Id];
        
        parma.max_id = [NSString stringWithFormat:@"%ld",com.Id];
        [_request commentOfStatuWithParmas:parma Status:_statu];
    }
    else
    {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self hideBottomView];
        });
        
    }
}

#pragma mark - 加载更多转发
//-(void)loadMoreetweeted
//{
//    _retweetedStasu = 2;
//    Statu* statu = (Statu*)_statuList.statuses[_statuList.statuses.count - 1];
//    StatuRequest* request = [StatuRequest new];
//    request.delegate = self;
//    RequestStatuParma* parma = [[RequestStatuParma alloc]initWithAccess_token:_token];
//    parma.Id = [NSString stringWithFormat:@"%ld",_statu.Id];
//    parma.max_id = [NSString stringWithFormat:@"%ld",statu.Id];
//    [request Repost_timelineDataRequestWithPramas:parma];
//}



#pragma mark - 加载微博的评论/转发列表
-(void)loadCommentList
{
    //请求某条微博的评论
    _request = [CommentRequest new];
    _request.delegate = self;
    RequestCommentParma* parma = [[RequestCommentParma alloc]initWithAccess_token:_token];
    parma.status_Id = [NSString stringWithFormat:@"%ld",_statu.Id];
    [_request commentOfStatuWithParmas:parma Status:_statu];

}

#pragma mark - 根据微博id请求一条微博
-(void)requestStatuById:(NSString*)statuId
{
    StatuRequest* request = [StatuRequest new];
    request.delegate = self;
    RequestStatuParma* parma = [[RequestStatuParma alloc]initWithAccess_token:_token];
    parma.Id = statuId;
    [request ShowStatuWithPramas:parma];
}

#pragma mark - 微博请求后，代理方法实现
-(void)didFinishedShowStatuWithStatu:(Statu *)statu error:(NSError *)error
{
    if (!error) {
        NSLog(@"微博加载成功");
        [self refreshAllButton:statu];
    }
    else
    {
        NSLog(@"微博加载失败:%@",error);
    }
}

#pragma mark - 转发请求后
//-(void)didFinishedRepost_timelineDataRequestWithStatuList:(StatuList *)statulist ststus:(NSArray *)status error:(NSError *)error
//{
//    if (!error) {
//        
//        NSMutableArray* newcom;
//        switch (_retweetedStasu) {
//            case 0:
//                _statuList = statulist;
//                break;
//            case 1:
//                newcom = [[NSMutableArray alloc]initWithArray:statulist.statuses];
//                [newcom addObjectsFromArray:_statuList.statuses];
//                _statuList.statuses = newcom;
//                _statuList.total_number = [NSNumber numberWithInteger:newcom.count];
//                [self hideTopView];
//                break;
//            case 2:
//                newcom = [[NSMutableArray alloc]initWithArray:_statuList.statuses];
//                [newcom removeObjectAtIndex:newcom.count-1];
//                [newcom addObjectsFromArray:statulist.statuses];
//                _statuList.statuses = newcom;
//                _statuList.total_number = [NSNumber numberWithInteger:newcom.count];
//                [self hideBottomView];
//                break;
//            default:
//                break;
//        }
//       NSLog(@"转发数据加载成功");
//        _retweetedList = [self changeStatuToComment:_statuList];
////        NSLog(@"%@",_retweetedList);
//        _commentList = _retweetedList;
//        [self.tableView reloadData];
//    }
//    else
//    {
//        NSLog(@"转发数据加载失败:%@",error);
//    }
//}


#pragma mark - 重写status的set方法
-(void)setStatu:(Statu *)statu
{
    [self requestStatuById:[NSString stringWithFormat:@"%ld",statu.Id]];
}


#pragma mark - tableView的代理方法
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return _statuViewHeight;
    }
    else
    {
        return _height;
    }
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    }
    else
    {
        return BUTTONHEIGHT;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return 15;
    }
    return 0;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView* view = [[UIView alloc]init];
    //    view.layer.borderColor = [UIColor lightGrayColor].CGColor;
    //            view.layer.borderWidth = 1;
//    [view addSubview:_weiboContentView];
    view.backgroundColor = [UIColor whiteColor];
//    UIView* btnView = [[UIView alloc]initWithFrame:CGRectMake(0, _statuViewHeight, SCREEN_WIDTH, BUTTONHEIGHT)];
    [view addSubview:_retweetedNumberBtn];
    UIImageView* hLine = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"wl_statusdetail_comment_line"]];
    hLine.frame = CGRectMake(BUTTONWIDTH+30, BUTTONHEIGHT*0.2, 2, BUTTONHEIGHT*0.6);
    [view addSubview:hLine];
    [view addSubview:_commentNumberBtn];
    [view addSubview:_attitudesNumberBtn];
    _arrow.frame = CGRectMake(0, BUTTONHEIGHT-7, 12, 7);
    UIView* line = [[UIView alloc]initWithFrame:CGRectMake(0, BUTTONHEIGHT-0.5, SCREEN_WIDTH, 0.5)];
    line.backgroundColor = [UIColor lightGrayColor];
    [view addSubview:line];
    [self arrowLocationToButton:_commentNumberBtn];
    [view addSubview:_arrow];
    
//    [view addSubview:btnView];
    return view;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 1) {
        return _commentList.comments.count;
    }
    else
    {
        return 1;
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
//        LRWWeiBoCell *cell = [LRWWeiBoCell cellWithTableView:tableView];
//        cell.weiboContentView.status = _statu;
//        cell.weiboContentView.statusFrame = frames;
//        cell.clipsToBounds = YES;
//        cell.userInteractionEnabled = NO;
//        return _statuCell;

        return _statuCell;
    }
    else
    {
        CommentTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"comment"];
        if (!cell) {
            cell = [[CommentTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"comment"];
        }
        [cell setUserDefaultIcon];
        Comment* com = (Comment*)_commentList.comments[indexPath.row];
        cell.comment = com;
        _height = cell.height;
        return cell;
    }
}

#pragma mark - 点击单条评论时
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        Comment* comment = _commentList.comments[indexPath.row];
        _clickCellIndex = indexPath;
        UIActionSheet* action = [self actionSheetOfComment:comment];
        [action showInView:self.view];
    }
}

#pragma mark - 评论的ActionSheet
-(UIActionSheet*)actionSheetOfComment:(Comment*)comment
{
    UIActionSheet* action;
    NSInteger userId = [_userId integerValue];
//    NSLog(@"UserId:%ld",userId);
//    NSLog(@"statuUserId:%ld",comment.status.user.Id);
//    NSLog(@"comuserid:%ld",comment.user.Id);
    if (comment.status.user.Id == userId) {
        if (comment.user.Id == userId) {
            action = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"删除" otherButtonTitles:@"复制", nil];
        }
        else
        {
            action = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"删除" otherButtonTitles:@"复制",@"回复", nil];
        }
    }
    else
    {
        if (comment.user.Id == userId) {
            action = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"删除" otherButtonTitles:@"复制", nil];
        }
        else
        {
            action = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"回复",@"复制", nil];
        }
    }
    return action;
}

#pragma mark - 转发的ActionSheet
-(UIActionSheet*)actionSheetOfRetweeted:(Comment*)comment
{
    UIActionSheet* action;
    NSUInteger userId = [_userId integerValue];
    if (comment.status.user.Id == userId) {
        action = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"删除" otherButtonTitles:@"复制", @"转发", @"评论",@"查看微博", nil];
    }
    else
    {
        action = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"复制", @"转发", @"评论",@"查看微博", nil];
    }
    return action;
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
    else if([btnTitle isEqualToString:@"删除微博"])
    {
        NSLog(@"删除微博:(转发)");
        
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

#pragma mark - 删除转发微博
-(void)deleteRetweetedStatu:(Statu*)statu
{
    StatuRequest* request = [StatuRequest new];
    request.delegate = self;
    RequestStatuParma* parma = [[RequestStatuParma alloc]initWithAccess_token:_token];
    parma.Id = [NSString stringWithFormat:@"%ld",statu.Id];
    [request DestroyWriteWithPramas:parma];
}

#pragma mark - 进入回复界面
-(void)replyCommentByIndex:(NSUInteger)index
{
    SendCommentController* send = [[SendCommentController alloc]init];
    Comment* comment = (Comment*)_commentList.comments[index];
    send.statu = _statu;
    send.comment = comment;
    send.controllerType = WLReplyControllerType;
    send.placeholderText = @"回复评论...";
    [self presentViewController:send animated:YES completion:nil];
}

#pragma mark - ActionSheet的复制方法
-(void)copyWithText:(NSString*)text
{
    // 复制评论内容到剪切板
    NSLog(@"复制");
    UIPasteboard* pasteBorad = [UIPasteboard generalPasteboard];
    pasteBorad.string = text;
}

#pragma mark - 转发按钮方法
-(void)retweetedStatu
{
    [self retweetedByStatu:self.statu];
}

#pragma mark - 评论按钮方法
-(void)commentStatu
{
    [self commentByStatu:self.statu];
}

#pragma mark - 转发一条微博
-(void)retweetedByStatu:(Statu*)statu
{
    SendCommentController* send = [[SendCommentController alloc]init];
    send.controllerType = WLRetweetedControllerType;
    send.placeholderText = @"说说你的分享心得...";
    send.statu = statu;
    [self presentViewController:send animated:YES completion:nil];
    //    [self.navigationController pushViewController:send animated:YES];
}

#pragma mark - 评论一微博
-(void)commentByStatu:(Statu*)statu
{
    SendCommentController* send = [[SendCommentController alloc]init];
    send.controllerType = WLCommentControllerType;
    send.placeholderText = @"写评论...";
    send.statu = statu;
    [self presentViewController:send animated:YES completion:nil];
    //    [self.navigationController pushViewController:send animated:YES];
}


#pragma mark - 评论请求类的代理方法实现（评论列表加载完成后）
-(void)commentOfStatuRequestDidFinshed:(CommentList *)commentList State:(NSInteger)state Error:(NSError *)error
{
    [self hideBottomView];
    if (!error) {
        NSMutableArray* newcom;
        switch (state) {
            case 0:
                _commentList = commentList;
                [self hideTopView];
                break;
            case 1:
                newcom = [[NSMutableArray alloc]initWithArray:commentList.comments];
                [newcom addObjectsFromArray:_commentList.comments];
                _commentList.comments = newcom;
                _commentList.total_number = newcom.count;
                [self hideTopView];
                break;
            case 2:
                newcom = [[NSMutableArray alloc]initWithArray:_commentList.comments];
                [newcom removeObjectAtIndex:newcom.count-1];
                [newcom addObjectsFromArray:commentList.comments];
                _commentList.comments = newcom;
                _commentList.total_number = newcom.count;
                [self hideBottomView];
                break;
            default:
                break;
        }
        NSLog(@"评论加载成功");
        [self.tableView reloadData];
        
    }
    else
    {
        NSLog(@"评论加载失败:%@",error);
    }
}

#pragma mark - 评论请求类的代理方法实现（删除评论后）
-(void)deleteCommentDidiFinishedError:(NSError *)error
{
    if (!error) {
        NSLog(@"删除成功");
        NSMutableArray* comments = [[NSMutableArray alloc]initWithArray:_commentList.comments];
        [comments removeObjectAtIndex:_clickCellIndex.row];
        _commentList.comments = comments;
        [self.tableView deleteRowsAtIndexPaths:@[_clickCellIndex] withRowAnimation:UITableViewRowAnimationLeft];
        _statu.comments_count = _statu.comments_count -1;
        [_commentNumberBtn setTitle:[NSString stringWithFormat:@"评论%ld",self.statu.comments_count] forState:UIControlStateNormal];
    }
    else
    {
        NSLog(@"删除失败");
    }
}

#pragma mark - 转发微博删除后
//-(void)didfinishedDestroyWithError:(NSError *)error
//{
//    if (!error) {
//        NSLog(@"删除成功");
//        NSMutableArray* comments = [[NSMutableArray alloc]initWithArray:_retweetedList.comments];
//        [comments removeObjectAtIndex:_clickCellIndex.row];
//        _retweetedList.comments = comments;
//        _commentList = _retweetedList;
//        [self.tableView deleteRowsAtIndexPaths:@[_clickCellIndex] withRowAnimation:UITableViewRowAnimationLeft];
//    }
//    else
//    {
//        NSLog(@"删除失败");
//    }
//}

#pragma mark - 把转发微博Statu转化为comment
-(CommentList*)changeStatuToComment:(StatuList*)statuList
{
    CommentList* clist = [[CommentList alloc]init];
    clist.total_number = [statuList.total_number integerValue];
    NSMutableArray* comArr = [[NSMutableArray alloc]init];
    for (Statu* statu in statuList.statuses) {
        Comment* com = [[Comment alloc]init];
        com.source = statu.source;
        com.source_type = statu.source_type;
        com.text = statu.text;
        com.date = statu.created_at;
        com.user = statu.user;
        com.status = statu;
        [comArr addObject:com];
    }
    clist.comments = comArr;
    return clist;
}

#pragma mark - 表视图跳到评论
-(void)turnToComment
{
    //    [_tableView ]
}

#pragma mark - 每次视图要出现的时候，要刷新数据
- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [self.tableView bringSubviewToFront:_menu];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    [self.tableView reloadData];
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:0];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    CGRect f = _menu.frame;
    f.origin.y = SCREEN_HEIGHT - 44 + self.tableView.contentOffset.y;
    _menu.frame = f;
    [self.view bringSubviewToFront:_menu];
    [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = [UIColor lightGrayColor];
    [self.tableView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [self.tableView removeObserver:self forKeyPath:@"contentOffset"];
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
