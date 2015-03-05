
//
//  LRWWeiBoShowImageController.m
//  图片控制器
//
//  Created by ibokan on 15-1-20.
//  Copyright (c) 2015年 SX. All rights reserved.
//
#define SCROLLVIEWWIDTH _scrollView.bounds.size.width
#define MARGIN 10
#define BTNHEITH 20
#define BTNFONT [UIFont systemFontOfSize:15]
#define BORDERCOLOR [UIColor colorWithRed:1 green:1 blue:1 alpha:0.3].CGColor
#define BTNBACKGROUNDCOLOR [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3]
#import "LRWWeiBoImageViewController.h"
#import "LRWWeiBoShowImageController.h"
#import "LRWWeiBoLongImageViewController.h"
#import "Statu.h"
@interface LRWWeiBoShowImageController ()<UIScrollViewDelegate>
{
    
    //摆放内容的View
    UIView *_contentView;
    
    UIButton *_saveBtn;
    UILabel *_pageLabel;
    UIButton *_originalBtn;
    UIButton *_goodBtn;
    UIButton *_messageBtn;
    UIScrollView *_scrollView;
    NSMutableArray *_imageControllers;
    UIView *_shadow;
}
@end

@implementation LRWWeiBoShowImageController

- (instancetype)initWithSelectIndex:(NSInteger)selectIndex goodNumber:(NSString *)goodNmuber defaultImages:(NSArray *)defaultImages imagesURL:(NSArray *)imagesURL
{
    if (self = [super init]) {
        self.view.backgroundColor = [UIColor whiteColor];
        self.imagesURL = imagesURL;
        self.selectIndex = selectIndex;
        self.defaultImages = defaultImages;
        self.goodNumber = goodNmuber;
    }
    return self;
}
- (instancetype)initWithStatu:(Statu *)statu image:(UIImage *)image url:(NSString *)url
{
    if (self = [[LRWWeiBoShowImageController alloc] initWithSelectIndex:0 goodNumber:[NSString stringWithFormat:@"%ld",statu.attitudes_count] defaultImages:@[image] imagesURL:@[url]]) {
        _messageBtn.hidden = NO;
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _imageControllers = [NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide:)];
    [self.view addGestureRecognizer:tap];
    self.view.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0];
    self.view.clipsToBounds = YES;
    
    [self setUpSubViews];
    
    self.view.clipsToBounds = YES;
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [self updateFrams];
}

#pragma mark - 初始化子控件
- (void)setUpSubViews
{
    //1.创建内容容器
    _contentView = [UIView new];
    _contentView.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0];
    [self.view addSubview:_contentView];
    
    //2.创建滚动视图
    _scrollView = [UIScrollView new];
    _scrollView.pagingEnabled = YES;
    _scrollView.backgroundColor = [UIColor blackColor];
    _scrollView.delegate = self;
    _scrollView.scrollEnabled = NO;
    _scrollView.bounces = NO;
    [_contentView addSubview:_scrollView];
    
    //3.创建保存按钮
    _saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_saveBtn setTitle:@"保存" forState:(UIControlStateNormal)];
    [_saveBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    _saveBtn.titleLabel.font = BTNFONT;
    _saveBtn.layer.borderColor = BORDERCOLOR;
    _saveBtn.layer.borderWidth = 0.4;
    _saveBtn.backgroundColor = BTNBACKGROUNDCOLOR;
    _saveBtn.hidden = YES;
    [_contentView addSubview:_saveBtn];
    
    //4.原图按钮
    _originalBtn = [UIButton buttonWithType:UIButtonTypeCustom];    [_originalBtn setTitle:@"原图" forState:(UIControlStateNormal)];
    [_originalBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    _originalBtn.titleLabel.font = BTNFONT;
    _originalBtn.layer.borderColor = BORDERCOLOR;
    _originalBtn.backgroundColor = BTNBACKGROUNDCOLOR;
    _originalBtn.layer.borderWidth = 0.4;
    _originalBtn.hidden = YES;
    [_contentView addSubview:_originalBtn];
    
    //5.赞按钮
    _goodBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_goodBtn setTitle:@" 100万" forState:(UIControlStateNormal)];
    [_goodBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [_goodBtn setImage:[UIImage imageNamed:@"statusdetail_icon_like"] forState:(UIControlStateNormal)];
    _goodBtn.titleLabel.font = BTNFONT;
    _goodBtn.layer.borderColor = BORDERCOLOR;
    _goodBtn.layer.borderWidth = 0.4;
    _goodBtn.backgroundColor = BTNBACKGROUNDCOLOR;
    [_contentView addSubview:_goodBtn];
    
    //5.1留言按钮
    _messageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_messageBtn setImage:[UIImage imageNamed:@"statusdetail_icon_comment"] forState:(UIControlStateNormal)];
    _messageBtn.layer.borderColor = BORDERCOLOR;
    _messageBtn.layer.borderWidth = 0.4;
    _messageBtn.backgroundColor = BTNBACKGROUNDCOLOR;
    _messageBtn.hidden = YES;
    [_contentView addSubview:_messageBtn];
    
    //6.页数label
    _pageLabel = [UILabel new];
    _pageLabel.textColor = [UIColor whiteColor];
    _pageLabel.textAlignment = NSTextAlignmentCenter;
    [_contentView addSubview:_pageLabel];
    [self changePageNumber];
    
    _shadow = [UIView new];
    _shadow.backgroundColor = [UIColor blackColor];
    //_shadow.hidden = YES;
    [self.view addSubview:_shadow];
}
#pragma mark - 跟新位置
- (void)updateFrams
{
    _contentView.frame = self.view.bounds;
    _scrollView.frame = _contentView.bounds;
    
    CGFloat saveBtnX = MARGIN;
    CGFloat saveBtnH = BTNHEITH;
    CGFloat saveBtnY = self.view.bounds.size.height - MARGIN - saveBtnH;
    CGFloat saveBtnW = 50;
    _saveBtn.frame = CGRectMake(saveBtnX, saveBtnY, saveBtnW, saveBtnH);
    
    CGFloat originalBtnX = CGRectGetMaxX(_saveBtn.frame) + MARGIN;
    CGFloat originalBtnH = BTNHEITH;
    CGFloat originalBtnY = self.view.bounds.size.height - MARGIN - originalBtnH;
    CGFloat originalBtnW = 50;
    _originalBtn.frame = CGRectMake(originalBtnX, originalBtnY, originalBtnW, originalBtnH);
    
    CGFloat goodBtnW = 70;
    CGFloat goodBtnX = self.view.bounds.size.width - MARGIN - goodBtnW;
    CGFloat goodBtnH = BTNHEITH;
    CGFloat goodBtnY = self.view.bounds.size.height - MARGIN - goodBtnH;
    _goodBtn.frame = CGRectMake(goodBtnX, goodBtnY, goodBtnW, originalBtnH);
    
    CGFloat messageBtnW = 50;
    CGFloat messageBtnX = goodBtnX - MARGIN - messageBtnW;
    CGFloat messageBtnH = BTNHEITH;
    CGFloat messageBtnY = goodBtnY;
    _messageBtn.frame = CGRectMake(messageBtnX, messageBtnY, messageBtnW, messageBtnH);
    
    CGFloat labelY = MARGIN + 20;
    CGFloat labelH = BTNHEITH;
    CGFloat labelW = 50;
    CGFloat labelX = self.view.center.x - labelW * 0.5;
    _pageLabel.frame = CGRectMake(labelX, labelY, labelW, labelH);
    
    _shadow.frame = self.view.bounds;
    
    
    NSInteger count = _defaultImages.count;
    for (NSInteger index = 0 ; index < count; ++index) {
        CGFloat x = index * SCROLLVIEWWIDTH;
        CGFloat y;
        CGFloat w = SCROLLVIEWWIDTH;
        CGFloat h;
        if (count == 1) {
            y = 20;
            h = _scrollView.bounds.size.height - 20;
        }
        else
        {
            y = 80;
            h = _scrollView.bounds.size.height - 2 * y;
        }
        
        LRWWeiBoImageViewController *imageController = _imageControllers[index];
        imageController.view.frame = CGRectMake(x, y, w, h);
    }
    _scrollView.contentSize = CGSizeMake(count * SCROLLVIEWWIDTH, 0);
    _scrollView.contentOffset = CGPointMake(_selectIndex * SCROLLVIEWWIDTH, 0);
}




- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    _scrollView.scrollEnabled = YES;
    //开始加载当前页面图片
    LRWWeiBoImageViewController *imageViewController = _imageControllers[_selectIndex];
    [imageViewController startTheDownload];
}
#pragma mark - setter
- (void)setGoodNumber:(NSString *)goodNumber
{
    _goodNumber = goodNumber;
    NSString *goodNumberString;
    if ([goodNumber integerValue]> 10000) {
        goodNumberString = [NSString stringWithFormat:@" %ld万",[goodNumber integerValue] / 10000];
    }
    else
    {
        goodNumberString = [NSString stringWithFormat:@" %@",goodNumber];
    }
    [_goodBtn setTitle:goodNumberString forState:(UIControlStateNormal)];
}
- (void)setSelectIndex:(NSInteger)selectIndex
{
    _selectIndex = selectIndex;
    [_scrollView setContentOffset:CGPointMake(selectIndex * SCROLLVIEWWIDTH, 0) animated:NO];
}
- (void)setDefaultImages:(NSArray *)defaultImages
{
    _defaultImages = defaultImages;
    NSInteger count = defaultImages.count;
    [self changePageNumber];
    
    for (NSInteger index = 0 ; index < count; ++index) {
        UIImage *image = defaultImages[index];
        CGFloat x = index * SCROLLVIEWWIDTH;
        CGFloat y;
        CGFloat w = SCROLLVIEWWIDTH;
        CGFloat h;
        if (count == 1) {
            y = 20;
            h = _scrollView.bounds.size.height - 20;
        }
        else
        {
            y = 80;
            h = _scrollView.bounds.size.height - 2 * y;
        }
        
        LRWWeiBoImageViewController *imageController = [[LRWWeiBoImageViewController alloc] initWithLoadImageWithURL:_imagesURL[index] defaultImage:image];
        imageController.view.frame = CGRectMake(x, y, w, h);
        imageController.imageContentMode = UIViewContentModeScaleAspectFit;
        [_scrollView addSubview:imageController.view];
        [_imageControllers addObject:imageController];
    }
    _scrollView.contentSize = CGSizeMake(count * SCROLLVIEWWIDTH, 0);
    self.selectIndex = _selectIndex;
    
    //超长图片特殊处理
    if (count == 1) [self setUpTheLongImage:defaultImages.firstObject url:_imagesURL.firstObject];
}

#pragma mark - 如果是一张超长图片,特殊处理
- (void)setUpTheLongImage:(UIImage *)image url:(NSString *)url
{
    CGFloat imageH = image.size.height;
    CGFloat imageW = image.size.width;
    if (imageH > imageW * 2.5) {
        LRWWeiBoImageViewController *imageController = _imageControllers.firstObject;
        //NSLog(@"%@",url);
        //计算出长度是宽度的赔率
        CGFloat h_W_proportion = imageH / imageW;
        LRWWeiBoLongImageViewController *longImageController = [[LRWWeiBoLongImageViewController alloc] initWithLoadImageWithURL:url defaultImage:image h_w_proprtion:h_W_proportion];
        longImageController.imageContentMode = UIViewContentModeScaleAspectFit;
        longImageController.view.frame = imageController.view.frame;
        [_scrollView addSubview:longImageController.view];
        
        [imageController.view removeFromSuperview];
        [_imageControllers replaceObjectAtIndex:0 withObject:longImageController];
    }
}

#pragma mark - 修改显示页数
- (void)changePageNumber
{
    NSInteger count = _defaultImages.count;
    if (count == 1) {
        _pageLabel.hidden = YES;
    }
    else
    {
        _pageLabel.hidden = NO;
        [_pageLabel setText:[NSString stringWithFormat:@"%ld/%ld",_selectIndex + 1,count]];
    }
}

#pragma mark - 隐藏控制器
- (void)hide:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 显示控制器


#pragma mark - 滑动视图代理方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.scrollEnabled) {
        NSInteger page = (scrollView.contentOffset.x + 0.5 * SCROLLVIEWWIDTH) / SCROLLVIEWWIDTH;
        _selectIndex = page;
        LRWWeiBoImageViewController *imageViewController = _imageControllers[_selectIndex];
        [imageViewController startTheDownload];
        [self changePageNumber];
        //NSLog(@"scrollViewDidScroll");
    }
}


#pragma mark - 阴影处理方法
- (void)showShadow
{
    [UIView animateWithDuration:0.25 animations:^{
        _shadow.alpha = 1;
    } completion:^(BOOL finished) {
        _shadow.hidden = NO;
    }];
    
}
- (void)hideShadow
{
    [UIView animateWithDuration:0.25 animations:^{
        _shadow.alpha = 0;
    } completion:^(BOOL finished) {
        _shadow.hidden = YES;
    }];
}
@end
