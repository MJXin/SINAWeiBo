//
//  LRWWeiBoWebController.m
//  微博SDK测试
//
//  Created by lrw on 15/2/3.
//  Copyright (c) 2015年 LRW. All rights reserved.
//

#import "LRWWeiBoWebController.h"
#import "ShortURLRequest.h"
#import "AppDelegate.h"
@interface LRWWeiBoWebController ()<ShortURLRequestDelegate,UIWebViewDelegate>
{
    __weak IBOutlet UIButton *_refreshBtn;
    __weak IBOutlet UIButton *_rightarrowBtn;
    __weak IBOutlet UIButton *_leftarrowBtn;
    __weak IBOutlet UIWebView *_webView;
        RequestShortURLParma *_parma;
        ShortURLRequest *_request;
}
- (IBAction)left:(id)sender;
- (IBAction)right:(id)sender;
- (IBAction)refreshOrCancel:(id)sender;
@end

@implementation LRWWeiBoWebController
- (instancetype)init
{
    if (self = [super init]) {
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _webView.delegate = self;
    _webView.scalesPageToFit = YES;
    //加载网站
    [self loadByURLString];
    self.title = @"网络链接";
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
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

- (IBAction)left:(id)sender {
    [_webView stopLoading];
    [_webView goBack];
}

- (IBAction)right:(id)sender {
    [_webView stopLoading];
    [_webView goForward];
}

- (IBAction)refreshOrCancel:(id)sender {
    if (_webView.isLoading) {
        [_webView stopLoading];
    }
    else
    {
        [_webView reload];
    }
}

#pragma mark - setter
-(void)setUrlString:(NSString *)urlString
{
    AppDelegate *appDelegate =  (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (appDelegate.currentUID) {
        if (_request == nil) {
            _request = [ShortURLRequest new];
            _parma = [[RequestShortURLParma alloc] initWithAccess_token:appDelegate.currentAccessToken];
            _request.delegate = self;
        }
        _parma.url_short = urlString;
        [_request ExpandURLRequestWithParma:_parma];
    }
    else
    {
        
    }
}

#pragma mark - 加载网站
- (void)loadByURLString
{
    if (_urlString) {
        NSURL *url = [NSURL URLWithString:_urlString];
        NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
        [_webView loadRequest:urlRequest];
    }
}

#pragma mark - request 代理方法
- (void)ExpandURLRequestDidFinishedWithUrls:(NSArray *)urls error:(NSError *)error
{
    if (error) {
        NSLog(@"短连接转化失败%@",error);
    }
    else
    {
        Url *url = urls.firstObject;
        _urlString = url.url_long;
        [self loadByURLString];
    }
}

#pragma mark - webView代理
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    //NSLog(@"开始请求");
    _leftarrowBtn.enabled = webView.canGoBack;
    _rightarrowBtn.enabled = webView.canGoForward;
    [self changeImageWithLoading:YES];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    //NSLog(@"结束请求");
    _leftarrowBtn.enabled = webView.canGoBack;
    _rightarrowBtn.enabled = webView.canGoForward;
    [self changeImageWithLoading:NO];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    //_leftarrowBtn.enabled = webView.canGoBack;
    //_rightarrowBtn.enabled = webView.canGoForward;
    //[self changeImageWithLoading];
    [self changeImageWithLoading:NO];
}

#pragma mark - 改变刷新停止按钮图片
- (void)changeImageWithLoading:(BOOL)loading
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:loading];
    NSString *defaultImageName = loading ? @"toolbar_stop" : @"toolbar_refresh";
    NSString *heightlightImageName = loading ? @"toolbar_stop_highlighted" : @"toolbar_refresh_highlighted";
    [_refreshBtn setImage:[UIImage imageNamed:defaultImageName] forState:(UIControlStateNormal)];
    [_refreshBtn setImage:[UIImage imageNamed:heightlightImageName] forState:(UIControlStateHighlighted)];
}
@end
