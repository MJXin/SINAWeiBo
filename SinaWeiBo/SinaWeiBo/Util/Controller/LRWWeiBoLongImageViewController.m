//
//  LRWWeiBoLongImageViewController.m
//  微博SDK测试
//
//  Created by lrw on 15/1/22.
//  Copyright (c) 2015年 LRW. All rights reserved.
//
#define MYSIZE self.view.bounds.size
#import "LRWWeiBoLongImageViewController.h"
#import "LRWWeiBoLoadingView.h"
@interface LRWWeiBoLongImageViewController ()
{
    UIScrollView *_scrollView;
    LRWWeiBoLoadingView *_loadingView;
    UIImageView *_imageView;
    UIImageView *_defaultImageView;
    //图片长宽比例
    CGFloat _h_w_proprtion;
    
    //图片总数据长度
    long long _totalDataLength;
    //已经下载的图片数据占总数据的比例
    CGFloat _proporition;
    //全部已经下载的数据
    
    
    NSMutableData *_downloadData;
    NSURLConnection *_connection;
    BOOL _isLoading;
}
@end

@implementation LRWWeiBoLongImageViewController
- (instancetype)initWithLoadImageWithURL:(NSString *)url defaultImage:(UIImage *)image h_w_proprtion:(CGFloat)h_w_proprtion
{
    if (self = [super init]) {
        self.view.backgroundColor = [UIColor clearColor];
        [self loadImageWithURL:url defaultImage:image h_w_proprtion:h_w_proprtion];
    }
    return self;
}

- (void)setImageContentMode:(UIViewContentMode)imageContentMode
{
    _imageContentMode = imageContentMode;
    _imageView.contentMode = imageContentMode;
}

- (void)loadImageWithURL:(NSString *)url defaultImage:(UIImage *)image h_w_proprtion:(CGFloat)h_w_proprtion
{
    if (_proporition == 1) {
        return;
    }
    _defaultImageView.image = [UIImage imageNamed:@"empty_picture"];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:NO];
    _h_w_proprtion = h_w_proprtion;
    _connection = connection;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpSubViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
    _scrollView.scrollEnabled = NO;
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [_downloadData appendData:data];
    _proporition = (CGFloat)_downloadData.length / _totalDataLength;
    _loadingView.proporition = _proporition;
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    _scrollView.scrollEnabled = YES;
    _imageView.image = [UIImage imageWithData:_downloadData];
    _loadingView.hidden = YES;
    _isLoading = NO;
    _defaultImageView.hidden = YES;
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
    
    _scrollView.frame = self.view.bounds;
    _defaultImageView.frame = _scrollView.bounds;
   
    CGFloat width = self.view.bounds.size.width;
    _imageView.frame = CGRectMake(0, 0, width, width * _h_w_proprtion);
    _scrollView.contentSize = CGSizeMake(0, width * _h_w_proprtion);
}

#pragma mark - 初始化子控件
- (void)setUpSubViews
{
    _scrollView = [UIScrollView new];
    _scrollView.bounces = NO;
    [self.view addSubview:_scrollView];
    
    _imageView = [UIImageView new];
    _imageView.contentMode = _imageContentMode;
    [_scrollView addSubview:_imageView];
    
    _defaultImageView = [UIImageView new];
    _defaultImageView.contentMode = UIViewContentModeScaleAspectFit;
    [_scrollView addSubview:_defaultImageView];
    
    _loadingView = [LRWWeiBoLoadingView new];
    _loadingView.backgroundColor = [UIColor colorWithHue:0.0 saturation:0.0 brightness:0.0 alpha:0];
    [_scrollView addSubview:_loadingView];
}
#pragma mark - 开始下载图片
- (void)startTheDownload
{
    if (_isLoading) {
        return;
    }
    [_connection start];
    _isLoading = YES;
}

#pragma mark - 暂停下载
- (void)pauseTheDownLoad
{
    [_connection cancel];
    _isLoading = NO;
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    [self setUpFrames];
}

@end
