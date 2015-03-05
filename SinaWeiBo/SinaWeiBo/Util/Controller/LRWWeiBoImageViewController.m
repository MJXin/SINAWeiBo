//
//  LRWWeiBoImageViewController.m
//  图片控制器
//
//  Created by ibokan on 15-1-20.
//  Copyright (c) 2015年 SX. All rights reserved.
//
#define MYSIZE self.view.bounds.size
#import "LRWWeiBoImageViewController.h"
#import "LRWWeiBoLoadingView.h"
#import "UIImageView+GIF.h"
@interface LRWWeiBoImageViewController ()<NSURLConnectionDataDelegate>
{
    LRWWeiBoLoadingView *_loadingView;
    UIImageView *_imageView;
    UIView *_shadow;
    //图片总数据长度
    long long _totalDataLength;
    //已经下载的图片数据占总数据的比例
    CGFloat _proporition;
    //全部已经下载的数据
    NSMutableData *_downloadData;
    NSURLConnection *_connection;
    BOOL _isLoading;
    BOOL _isGIF;
}
@end

@implementation LRWWeiBoImageViewController
- (instancetype)initWithLoadImageWithURL:(NSString *)url defaultImage:(UIImage *)image
{
    if (self = [super init]) {
        [self loadImageWithURL:url defaultImage:image];
    }
    return self;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)setImageContentMode:(UIViewContentMode)imageContentMode
{
    _imageContentMode = imageContentMode;
    _imageView.contentMode = imageContentMode;
}

#pragma mark - 设置自控建位置
- (void)setUpFrames
{
    //进度条位置
    CGFloat w = 30.0;
    CGFloat h = 30.0;
    CGFloat x = MYSIZE.width * 0.5 - w * 0.5;
    CGFloat y = MYSIZE.height * 0.5 - h * 0.5;
    _loadingView.frame = CGRectMake(x, y, w, h);
    //图片位置
    _imageView.frame = self.view.bounds;
    //_imageView.backgroundColor = [UIColor purpleColor];
    //阴影位置
    _shadow.frame = self.view.bounds;
}
#pragma mark - 初始化子空间
- (void)setUpSubViews
{
    _imageView = [UIImageView new];
    _imageView.contentMode = _imageContentMode;
    [self.view addSubview:_imageView];
    _loadingView = [LRWWeiBoLoadingView new];
    _loadingView.backgroundColor = [UIColor colorWithHue:0.0 saturation:0.0 brightness:0.0 alpha:0];
    [self.view addSubview:_loadingView];
    
}
#pragma mark - 开始下载图片
- (void)startTheDownload
{
    if (_isLoading) {
        return;
    }
    [_connection start];
    _isLoading = YES;
    //NSLog(@"startTheDownload");
}

#pragma mark - 暂停下载
- (void)pauseTheDownLoad
{
    [_connection cancel];
    _isLoading = NO;
}


#pragma mark - 加载图片
- (void)loadImageWithURL:(NSString *)url defaultImage:(UIImage *)image
{
    //NSLog(@"%@",url);
    //已经加载完图片
    if (_proporition == 1) {
        return;
    }
    if ([[url substringWithRange:NSMakeRange(url.length - 3, 3)] isEqualToString:@"gif"]) {
        //如果是GIF图片地址
        _isGIF = YES;
    }
    _imageView.image = image;
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:NO];
    _connection = connection;
}

#pragma mark - NSURLConnection 代理方法
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    //NSLog(@"%@  didReceiveResponse",self);
    _downloadData = nil;
    _downloadData = [NSMutableData new];
    _proporition = 0;
    _totalDataLength = response.expectedContentLength;
    _loadingView.hidden = NO;
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    //NSLog(@"didReceiveData");
    [_downloadData appendData:data];
    //NSLog(@"_downloadData.length : %ld",_downloadData.length);
    //NSLog(@"_totalDataLength : %lld",_totalDataLength);
    _proporition = (CGFloat)_downloadData.length / _totalDataLength;
    //NSLog(@"_downloadData.length : %ld",_downloadData.length);
    //NSLog(@"_totalDataLength : %lld",_totalDataLength);
    //NSLog(@"_proporition : %f",_proporition);
    _loadingView.proporition = _proporition;
    //_imageView.image = [UIImage imageWithData:_downloadData];
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    if (_isGIF) {
        [_imageView showGIFWithData:_downloadData replace:YES];
    }
    else
    {
        _imageView.image = [UIImage imageWithData:_downloadData];
    }
    
    _loadingView.hidden = YES;
    _isLoading = NO;
    //NSLog(@"connectionDidFinishLoading");
}


- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    [self setUpFrames];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setUpSubViews];
}

@end
