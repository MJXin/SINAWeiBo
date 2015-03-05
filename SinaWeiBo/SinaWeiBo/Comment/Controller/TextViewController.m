//
//  TextViewController.m
//  SinaWeiBo
//
//  Created by William-zhang on 15/2/5.
//  Copyright (c) 2015年 LMZ. All rights reserved.
//

#import "TextViewController.h"
#import "CommentRequest.h"
#import "Statu.h"
#import "User.h"

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@interface TextViewController ()
{
    UILabel* _placeholderLabel;
    UIView* _bottomView;
    UINavigationBar* _navBar;
    UINavigationItem* _navItem;
}
@end

@implementation TextViewController
-(instancetype)init
{
    if (self = [super init]) {
        self.textView = [[UITextView alloc]initWithFrame:CGRectMake(0, 64, 400, 200)];
        _placeholderLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 62, 150, 40)];
        _navBar = [[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
        _navItem = [[UINavigationItem alloc]initWithTitle:@""];
        [_navBar pushNavigationItem:_navItem animated:NO];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.textView.backgroundColor = [UIColor clearColor];
    self.textView.delegate = self;
    self.textView.keyboardType = UIKeyboardTypeDefault;
    self.textView.font = [UIFont systemFontOfSize:16];
    
    [self.view addSubview:self.textView];
    
    _placeholderLabel.textColor = [UIColor lightGrayColor];
    _placeholderLabel.userInteractionEnabled = NO;
    _placeholderLabel.font = self.textView.font;
    [self.view addSubview:_placeholderLabel];
    
    [self.view addSubview:_navBar];

    
    
    //取消按钮
    UIBarButtonItem* leftItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
    
    
    _navItem.leftBarButtonItem = leftItem;
    
    //发送
    UIBarButtonItem* rightItem = [[UIBarButtonItem alloc]initWithTitle:@"发送" style:UIBarButtonItemStylePlain target:self action:self.send];
    _navItem.rightBarButtonItem = rightItem;

}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:0];
}

#pragma mark - 重写setTitle的方法
-(void)setTitle:(NSString *)title
{
    [super setTitle:title];
    [_navItem setTitle:title];
}

#pragma mark - 重写工具栏的set方法
-(void)setBottomView:(UIView *)bottomView
{
    [_bottomView removeFromSuperview];
    _bottomView = bottomView;
    [self.view addSubview:bottomView];
}

#pragma  mark - 重写placeholderText的set方法
-(void)setPlaceholderText:(NSString *)placeholderText
{
    _placeholderText = placeholderText;
    _placeholderLabel.text = _placeholderText;
}

-(void)textViewDidChange:(UITextView *)textView
{
    //隐藏或显示textView的Label
    if (textView.text.length > 0) {
        _placeholderLabel.hidden = YES;
    }
    else
    {
        _placeholderLabel.hidden = NO;
    }
}

#pragma mark - 隐藏placeholderText
-(void)hiddenPlaceholderText
{
    _placeholderLabel.hidden = YES;
}

#pragma mark - 显示placeholderText
-(void)displayPlaceholderText
{
    _placeholderLabel.hidden = NO;
}

#pragma mark - 返回方法
-(void)goBack
{
//    NSLog(@"返回");
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 键盘即将出现时调用的方法
-(void)keyBoradShow:(NSNotification*)aNotification
{
    [UIView beginAnimations:@"keyBoardShow" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.35];
    CGFloat y = [UIScreen mainScreen].bounds.size.height;
//    NSLog(@"%.2f",y);
    CGSize kbs = [[[aNotification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    y -= kbs.height;
//    NSLog(@"%.2f",kbs.height);
    CGRect f = _bottomView.frame;
    f.origin.y = y - f.size.height;
    _bottomView.frame = f;
    [UIView commitAnimations];
}

#pragma mark - 键盘即将消失时调用的方法
-(void)keyBoardHidden:(NSNotification*)aNotificaiton
{
    [UIView beginAnimations:@"keyBoardShow" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.35];
    CGFloat y = [UIScreen mainScreen].bounds.size.height;
    CGRect f = _bottomView.frame;
    f.origin.y = y - f.size.height;
    _bottomView.frame = f;
    [UIView commitAnimations];
}

-(void)viewWillAppear:(BOOL)animated
{
    //页面即将出现时，键盘要已经弹出，可以马上输入文字
    [self.textView becomeFirstResponder];
    //监听键盘出现
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoradShow:) name:UIKeyboardWillShowNotification object:nil];
    //监听键盘消失
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardHidden:) name:UIKeyboardWillHideNotification object:nil];
    [super viewWillAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [self.textView resignFirstResponder];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super viewWillDisappear:animated];
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
