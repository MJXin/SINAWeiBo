//
//  SendCommentController.m
//  sinaWeiboDemo1
//
//  Created by William-zhang on 15/1/28.
//  Copyright (c) 2015年 William-zhang. All rights reserved.
//

#import "SendCommentController.h"
#import "UICheckBox.h"
#import "CommentRequest.h"
#import "Statu.h"
#import "User.h"
#import "StatusView.h"
#import "LRWSearchTableViewController.h"
#import "AppDelegate.h"

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)



@interface SendCommentController ()<LRWSearchTableViewControllerDelegate>
{
    UICheckBox* _oriCheckBox;
    NSString* _selectedText;
    LRWWeiBoKeyBoardToolBar* _toolBar;
    NSString* _token;
    
}
@end

@implementation SendCommentController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView* view = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-80, SCREEN_WIDTH, 80)];
//    view.layer.borderColor = [UIColor lightGrayColor].CGColor;
//    view.layer.borderWidth = 1;
    _oriCheckBox = [[UICheckBox alloc]initWithFrame:CGRectMake(20, 0, 200, 30)];
    _oriCheckBox.text =  _selectedText;
//    _oriCheckBox.layer.borderWidth = 1;
//    _oriCheckBox.layer.borderColor = [UIColor redColor].CGColor;
    _toolBar = [[LRWWeiBoKeyBoardToolBar alloc]initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, 44)];
    _toolBar.delegateToWeiBoKeyBoardToolBar = self;
    [view addSubview:_toolBar];
    [view addSubview:_oriCheckBox];
    self.bottomView = view;
    
    AppDelegate* md = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    _token = md.currentAccessToken;

}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:0];
}


#pragma nark - 重写控制器类型的set方法
-(void)setControllerType:(WLControllerType)controllerType
{
    _controllerType = controllerType;
    switch (_controllerType) {
        case WLCommentControllerType:
             _selectedText = @"同时转发";
            self.send = @selector(Comment);
            self.title = @"发评论";
            break;
        case WLReplyControllerType:
              _selectedText = @"同时转发";
            self.send = @selector(Reply);
            self.title = @"回复评论";
            break;
        case WLRetweetedControllerType:
             _selectedText = @"同时评论";
            self.send = @selector(Transmit);
            self.title = @"转发微博";
            break;
        default:
            break;
    }
}

#pragma mark - toolbar的代理方法实现
-(void)weiBoKeyBoardToolBar:(LRWWeiBoKeyBoardToolBar *)toolBar didClickItem:(NSInteger)index isShowEmojiIcon:(BOOL)isShow
{
    NSLog(@"%ld",index);
    if (index == 0) {
        LRWSearchTableViewController* s = [[LRWSearchTableViewController alloc]initWithType:LRWSearchTypeAt];
        s.delegate = self;
        
        [self presentViewController:[[UINavigationController alloc]initWithRootViewController:s] animated:YES completion:nil];
    }
    else if(index == 3)
    {
        NSString* str = [NSString stringWithFormat:@"%@无法发照片",self.title];
        UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"提示" message:str delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
        [alert show];
    }
}

-(void)weiBoKeyBoardToolBar:(LRWWeiBoKeyBoardToolBar *)toolBar didClickEmoji:(NSString *)emoji
{
    self.textView.text = [NSString stringWithFormat:@"%@%@",self.textView.text,emoji];
    [self hiddenPlaceholderText];
}

-(void)weiBoKeyBoardToolBarDidClickDeleteBtn:(LRWWeiBoKeyBoardToolBar *)toolBar
{
    NSRange leftRange = [self.textView.text rangeOfString:@"[" options:NSBackwardsSearch];
    NSRange rightRange = [self.textView.text rangeOfString:@"]" options:NSBackwardsSearch];
    if (leftRange.length>0&&rightRange.length>0) {
        //        NSLog(@"删除表情");
        NSRange range = NSMakeRange(leftRange.location, rightRange.location - leftRange.location+1);
        NSMutableString* text = [NSMutableString stringWithString:self.textView.text];
        [text deleteCharactersInRange:range];
        self.textView.text = text;
        if (self.textView.text.length == 0) {
            [self displayPlaceholderText];
        }
    }
    else
    {
        //        NSLog(@"找不到表情，删除文字");
        [self.textView deleteBackward];
    }
}


#pragma mark - search的代理实现
-(void)searchTableViewController:(LRWSearchTableViewController *)viewController didClickCell:(UITableViewCell *)cell searchType:(LRWSearchType)searchType
{
    NSLog(@"%@",cell.textLabel.text);
    self.textView.text = [NSString stringWithFormat:@"%@%@",self.textView.text,cell.textLabel.text];
    [self hiddenPlaceholderText];
    [viewController dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - 评论一条微博
-(void)Comment
{
    NSLog(@"评论");
    if (self.textView.text.length >0) {
        [self CommentByText:self.textView.text];
        //如果转发被勾选，执行转发微博的方法
        if (_oriCheckBox.selected) {
            [self transmitStatuByText:self.textView.text];
        }

    }
    [super goBack];
}

#pragma mark - 回复一条评论
-(void)Reply
{
    NSLog(@"回复");
    [self ReplyByText:self.textView.text];
    //如果转发被勾选，执行转发微博的方法
    if (_oriCheckBox.selected) {
        NSString* text = [NSString stringWithFormat:@"回复@%@:%@//@%@:%@",self.comment.user.name,self.textView.text,self.comment.user.name,self.comment.text];
        self.statu = self.comment.status;
        [self transmitStatuByText:text];
    }
    [super goBack];
}

#pragma mark - 转发一条微博
-(void)Transmit
{
    NSLog(@"转发");
    [self transmitStatuByText:self.textView.text];
    //如果转发被勾选，执行评论微博的方法
    if (_oriCheckBox.selected) {
        [self CommentByText:self.textView.text];
    }
    [super goBack];
}

#pragma mark - 通过Text评论一条微博
-(void)CommentByText:(NSString*)commentText
{
    CommentRequest* request = [CommentRequest new];
    request.delegate = self;
    RequestCommentParma* parma = [[RequestCommentParma alloc]initWithAccess_token:_token];
    parma.status_Id = [NSString stringWithFormat:@"%ld",self.statu.Id];
    parma.comment = commentText;
    [request commentStatusWithParmas:parma];
}

#pragma mark - 通过Text回复一条评论
-(void)ReplyByText:(NSString*)replyText
{
    CommentRequest* request = [CommentRequest new];
    request.delegate = self;
    RequestCommentParma* parma = [[RequestCommentParma alloc]initWithAccess_token:_token];
    parma.status_Id = [NSString stringWithFormat:@"%ld",self.comment.status.Id];
    parma.comment = replyText;
    parma.cid = [NSString stringWithFormat:@"%ld",self.comment.Id];
    [request replyComment:self.comment WithParmas:parma];
   }

#pragma mark - 通过Text转发微博
-(void)transmitStatuByText:(NSString*)transmitText
{
    StatuRequest* statuRequest = [StatuRequest new];
    statuRequest.delegate = self;
    RequestStatuParma* statuParma = [[RequestStatuParma alloc]initWithAccess_token:_token];
    statuParma.Id = [NSString stringWithFormat:@"%ld",self.statu.Id];
    statuParma.status = transmitText;
    [statuRequest RepostWriteWithPramas:statuParma];
}

#pragma mark - 评论请求类的代理方法（回复一条评论结束后）实现
-(void)replyCommentDidiFinishedError:(NSError *)error
{
    [super goBack];
    if (!error) {
        NSLog(@"回复成功");
    }
    else
    {
        NSLog(@"回复失败");
    }
}

#pragma mark - 评论请求类的代理方法（评论一条微博结束后）实现
-(void)commentStatusDidFinishedError:(NSError *)error
{
    [super goBack];
    if (!error) {
        NSLog(@"评论成功");
    }
    else
    {
        NSLog(@"评论失败:%@",error);
    }
}

#pragma mark - 微博类请求代理方法（转发一条微博后）实现
-(void)didfinishedRepostWithError:(NSError *)error
{
    [super goBack];
    NSLog(@"%@",error);
    if (!error) {
        NSLog(@"转发成功");
    }
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
