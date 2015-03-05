//
//  LRWWeiBoWebViewController.m
//  微博SDK测试
//
//  Created by lrw on 15/2/3.
//  Copyright (c) 2015年 LRW. All rights reserved.
//

#import "LRWWeiBoShortURLWebViewController.h"
#import "ShortURLRequest.h"
#import "AppDelegate.h"
@interface LRWWeiBoShortURLWebViewController ()<ShortURLRequestDelegate>
{
    RequestShortURLParma *_parma;
    ShortURLRequest *_request;
}
@end

@implementation LRWWeiBoShortURLWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (void)setUrlString:(NSString *)urlString
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

- (void)ExpandURLRequestDidFinishedWithUrls:(NSArray *)urls error:(NSError *)error
{
    if (error) {
        NSLog(@"短连接转化失败%@",error);
    }
    else
    {
        NSLog(@"%@",urls.firstObject);
    }
}

@end
