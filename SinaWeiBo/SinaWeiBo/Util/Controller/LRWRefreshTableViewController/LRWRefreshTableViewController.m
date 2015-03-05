//
//  ViewController.m
//  自定义refreshController
//
//  Created by lrw on 15/1/23.
//  Copyright (c) 2015年 LRW. All rights reserved.
//
#define TABLEVIEWHEIGHT self.tableView.bounds.size.height
#define TABLEVIEWWIDTH self.tableView.bounds.size.width
typedef enum {
    LRWRefreshStatusDown,
    LRWRefreshStatusUp,
    LRWRefreshStatusRefreshing
}LRWRefreshStatus;

#import "LRWRefreshTableViewController.h"
#import <ImageIO/ImageIO.h>
@interface LRWRefreshTableViewController ()<LRWRefreshTableViewControllerDelegate>
{
    /**顶部视图*/
    UIView *_topView;
    UIView *_topViewContentView;
    /**顶部视图左边图片*/
    UIImageView *_topViewStatusImageView;
    /**顶部视图右边文字*/
    UILabel *_topViewStatusLabel;
    /**GIF图片数据*/
    NSData *_refreshingImageData;
    /**是否正在加载中*/
    BOOL _topViewIsLoading;
    /**顶部视图状态*/
    NSInteger _topRefreshStatus;
    
    /**底部视图*/
    UIView *_bottomView;
    UIView *_bottomViewContentView;
    /**顶部视图左边图片*/
    UIImageView *_bottomStatusImageView;
    /**顶部视图右边文字*/
    UILabel *_bottomStatusLabel;
    /**底部视图是否正加载中*/
    BOOL _bottomViewIsLoading;
    
    
    /**上边距,防止导航栏遮盖tableview内容*/
    CGFloat _topEdge;
    /**下边距,防止工具栏遮盖tableview内容*/
    CGFloat _bottomEdge;
    /**到达tableview顶部的提示视图*/
    UIView *_topLogoView;
    BOOL _isShowLogoView;
    /**到达tableview底部的提示视图*/
    UIView *_bottomLogoView;
    BOOL _isShowBottomView;
}
@property (nonatomic, assign) CGFloat topViewHeight;
@property (nonatomic, assign) CGFloat bottomViewHeight;
@end

@implementation LRWRefreshTableViewController
//- (instancetype)initWithStyle:(UITableViewStyle)style
//{
//    if (self = [super initWithStyle:UITableViewStyleGrouped]) {
//        
//    }
//    return self;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    //数据初始化
    if (!_shadowHeight || _shadowHeight == 0)
    {
       _shadowHeight = 5;
    }
    if (!_shadowOpacity || _shadowOpacity == 0)
    {
        _shadowOpacity = 0.5;
    }
    if (!_bottomViewFont) {
        _bottomViewFont = [UIFont systemFontOfSize:11];
    }
    if (!_topViewFont) {
        _topViewFont = [UIFont systemFontOfSize:14];
    }

    //创建到达顶部/底部时候显示的提示视图
    [self setupLogView];
    [self.tableView addObserver:self forKeyPath:@"contentOffset" options:(NSKeyValueObservingOptionNew) context:@"contentOffset"];
    self.delegate = self;
    #pragma mark - 设置顶部视图高度
    self.topViewHeight = 60;
    #pragma mark - 设置底部视图高度
    self.bottomViewHeight = 30;
    [self.tableView addObserver:self forKeyPath:@"bounces" options:(NSKeyValueObservingOptionNew) context:@"bounces"];
}

- (void)dealloc
{
    [self.tableView removeObserver:self forKeyPath:@"contentOffset"];
    [self.tableView removeObserver:self forKeyPath:@"bounces"];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = !_showToolBar;
    self.navigationController.navigationBar.hidden = !_showNavagationBar;
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [_topView removeFromSuperview];
    [_bottomView removeFromSuperview];
    [self.tableView.superview addSubview: _topView];
    [self updateTopViewFrame];
    [self.tableView.superview addSubview:_bottomView];
    [self updateBottomViewFrame];
}



- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    NSString *contextStr = (__bridge NSString *)(context);
    if (object == self.tableView && [contextStr isEqualToString:@"contentOffset"]) {
       // NSLog(@"--");
        CGFloat contentOffsetY = self.tableView.contentOffset.y;
        CGFloat contentSizeHeight = self.tableView.contentSize.height;
        CGFloat boundsSizeHeight = TABLEVIEWHEIGHT;
        //判断tableview是否能够显示全部cell
        //YES:tableView的cell个数太少，tableView没法滚动
        //NO:tableView可以滚动
        BOOL canShowAllCells = contentSizeHeight < boundsSizeHeight;
        //判断tableView 是否被拖拽过
        BOOL tableViewDidedDragging = contentOffsetY < _topEdge;
        //判断是否滚动到最后一个视图
        BOOL isShowLastCell = !canShowAllCells && (contentOffsetY + TABLEVIEWHEIGHT >
        self.tableView.contentSize.height + _bottomEdge);
        if (canShowAllCells && !self.tableView.isDragging && !tableViewDidedDragging) {
            return;
        }
        //判断tableView是否在减速
        BOOL decelerating = self.tableView.decelerating;
        if (decelerating && _topRefreshStatus == LRWRefreshStatusDown) {
            [self controlTheLogView:contentOffsetY];
            return;
        }
        _topLogoView.hidden = YES;
        _bottomLogoView.hidden = YES;
        //创建topView
        if (contentOffsetY < 0)
        {
            [self controlTheTopView];
        }
        else if(isShowLastCell)
        {
            if (_bottomViewIsLoading) {
                self.tableView.bounces = NO;
                _bottomView.hidden = NO;
                [self updateBottomViewFrame];

                return;
            }
            //如果tableView可以拖拽，并且滚动到最后一个cell的时候触发
            [self controlTheBottomView];
        }
        else
        {
            self.tableView.bounces = YES;
            _topView.hidden = YES;
            _bottomView.hidden = YES;
            if (_topRefreshStatus == LRWRefreshStatusUp) {
                _topViewStatusImageView.transform = CGAffineTransformRotate(_topViewStatusImageView.transform, M_PI);
            }
            _topRefreshStatus = _topViewIsLoading ? LRWRefreshStatusRefreshing : LRWRefreshStatusDown;
        }
    }
    else
    {
//        NSLog(@"bounces : %d",self.tableView.bounces);
    }
}

#pragma mark - getter
- (CGFloat)topViewHeight
{
    _topEdge = _showNavagationBar ? 64 : 0;
    return _topViewHeight + _topEdge;
}
- (CGFloat)bottomViewHeight
{
    _bottomEdge = _showToolBar ? 44 : 0;
    return _bottomViewHeight + _bottomEdge;
}

#pragma mark - setter
- (void)setShowNavagationBar:(BOOL)showNavagationBar
{
    _showNavagationBar = showNavagationBar;
    _topEdge = showNavagationBar ? 64 : 0;
}
- (void)setShowToolBar:(BOOL)showToolBar
{
    _showToolBar = showToolBar;
    _bottomEdge = showToolBar ? 44 : 0;
}
#pragma mark - 创建到达顶部/底部时候显示的提示视图
- (void)setupLogView
{
    _topLogoView = [[UIView alloc] init];
    _topLogoView.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:1];
    _topLogoView.layer.shadowOpacity = _shadowOpacity;
    _topLogoView.layer.shadowColor = [UIColor blackColor].CGColor;
    _topLogoView.layer.shadowOffset = CGSizeMake(0, _shadowHeight);
    _topLogoView.layer.shadowRadius = 0.5 * _shadowHeight;
    _topLogoView.hidden = YES;
    //_topLogoView.clipsToBounds = YES;
    
    _bottomLogoView = [[UIView alloc] init];
    _bottomLogoView.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:1];
    _bottomLogoView.layer.shadowOpacity = _shadowOpacity;
    _bottomLogoView.layer.shadowColor = [UIColor blackColor].CGColor;
    _bottomLogoView.layer.shadowOffset = CGSizeMake(0, -_shadowHeight);
    _bottomLogoView.layer.shadowRadius = 0.5 * _shadowHeight;
    _bottomLogoView.hidden = YES;
    //_bottomLogoView.clipsToBounds = YES;
    [self.tableView addSubview:_topLogoView];
    [self.tableView addSubview:_bottomLogoView];
}

#pragma mark - 控制提示视图的显示效果
- (void)controlTheLogView:(CGFloat)contentOffsetY
{
    self.tableView.bounces = NO;
    _topView.hidden = YES;
    if (contentOffsetY <= _topEdge + 5) {
        //顶部提示视图的显示动画
        if (_isShowLogoView) {
            return;
        }
        _topLogoView.frame = CGRectMake(0, -_shadowHeight, TABLEVIEWHEIGHT, _shadowHeight);
        _topLogoView.backgroundColor = self.tableView.backgroundColor;
        _isShowLogoView = YES;
        _topLogoView.alpha = 1;
        _topLogoView.hidden = NO;
        [UIView animateWithDuration:0.7 animations:^{
            _topLogoView.alpha = 0;
        } completion:^(BOOL finished) {
            _isShowLogoView = NO;
            self.tableView.bounces = YES;
        }];
    }
    else{
        //底部视图的显示动画
        if (_isShowBottomView) {
            return;
        }
        if (_bottomViewIsLoading) {
            return;
        }
        _isShowBottomView = YES;
        _bottomLogoView.alpha = 1;
        _bottomLogoView.backgroundColor = self.tableView.backgroundColor;
        _bottomLogoView.hidden = NO;
        _bottomLogoView.frame = CGRectMake(0, self.tableView.contentSize.height - 1, TABLEVIEWHEIGHT, _shadowHeight);
        [UIView animateWithDuration:0.7 animations:^{
            _bottomLogoView.alpha = 0;
        } completion:^(BOOL finished) {
            _isShowBottomView = NO;
        }];
    }
}

#pragma mark - 顶部视图的显示和隐藏
- (void)showTopView
{
    //创建topView
    if (!_topView) {
        [self setupTopView];
    }
    _topViewStatusImageView.transform = CGAffineTransformRotate(_topViewStatusImageView.transform, M_PI);
    _topViewIsLoading = YES;
    _topView.hidden = NO;
    _topView.frame = CGRectMake(0, _topEdge, TABLEVIEWWIDTH, _topViewHeight);
    _topRefreshStatus = LRWRefreshStatusRefreshing;
    [self updateTopViewSubViewsFrame];
    [self showRefreshing];
    CGFloat topEdg = self.topViewHeight;
    CGFloat bottomEdg = _bottomViewIsLoading ? self.bottomViewHeight : _bottomEdge;
    self.tableView.contentInset = UIEdgeInsetsMake(topEdg, 0, bottomEdg, 0);
}

- (void)hideTopView
{
    if (_topViewIsLoading == NO) {
        return;
    }
    _topViewIsLoading = NO;
    self.tableView.bounces = YES;
    _topRefreshStatus = LRWRefreshStatusDown;
    CGFloat topEdg = _topEdge;
    CGFloat bottomEdg = _bottomViewIsLoading ? self.bottomViewHeight : _bottomEdge;
    self.tableView.contentInset = UIEdgeInsetsMake(topEdg, 0, bottomEdg, 0);;
    _topView.hidden = YES;
    [_topViewStatusImageView stopAnimating];
    _topViewStatusImageView.animationImages = nil;
    _topViewStatusImageView.image = [UIImage imageNamed:@"line"];
    _topViewStatusLabel.text = @"下拉刷新";
    
    if ([self.delegate respondsToSelector:@selector(refreshTableViewControllerHeadViewDidEndLoding:)]) {
        [self.delegate refreshTableViewControllerHeadViewDidEndLoding:self];
    }
}
#pragma mark - 控制顶部视图的显示效果
- (void)controlTheTopView
{
    self.tableView.bounces = !_topViewIsLoading;
    //顶部视图处理
    if (!_topView) {
        [self setupTopView];
    }
    _topView.hidden = NO;
    _bottomView.hidden = YES;
    //跟新顶部视图控件
    [self updateTopViewFrame];
    //跟新顶部视图子控件位置
    [self updateTopViewSubViewsFrame];
    //跟新顶部视图内容
    [self updateTopViewContent];
}

#pragma mark - 顶部视图的创建
- (void)setupTopView
{
    _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0 , self.tableView.bounds.size.width, 1)];
    _topView.clipsToBounds = YES;
    [[self.tableView superview] addSubview:_topView];
    _topViewContentView = [[UIView alloc] init];
    [_topView addSubview:_topViewContentView];
    
    _topViewStatusImageView = [[UIImageView alloc] init];
    _topViewStatusImageView.image = [UIImage imageNamed:@"line"];
    _topViewStatusImageView.contentMode = UIViewContentModeScaleAspectFit;
    [_topViewContentView addSubview:_topViewStatusImageView];
    
    _topViewStatusLabel = [[UILabel alloc] init];
    _topViewStatusLabel.text = @"下拉刷新";
    _topViewStatusLabel.textColor = [UIColor grayColor];
    _topViewStatusLabel.font = _topViewFont;
    _topViewStatusLabel.textAlignment = NSTextAlignmentCenter;
    _topRefreshStatus = LRWRefreshStatusDown;
    [_topViewContentView addSubview:_topViewStatusLabel];
}

#pragma mark - 顶部视图的位置修改
- (void)updateTopViewFrame
{
    //修改topView的frame
    CGFloat y = self.tableView.contentOffset.y;
    if (self.tableView.isDragging == 0 && _topRefreshStatus == LRWRefreshStatusUp) {
        _topRefreshStatus = LRWRefreshStatusRefreshing;
    }
    if (_topRefreshStatus == LRWRefreshStatusRefreshing && -y <= self.topViewHeight)
    {
        CGFloat topEdg = self.topViewHeight;
        CGFloat bottomEdg = _bottomViewIsLoading ? self.bottomViewHeight : _bottomEdge;
        self.tableView.contentInset = UIEdgeInsetsMake(topEdg, 0, bottomEdg, 0);
    }
    if (y < 0) {
        //修改topView的位置
        _topView.frame = CGRectMake(0, 0, self.tableView.bounds.size.width, -y);
    }
    _topView.hidden = y > 0 ? YES : NO;
}

#pragma mark - 顶部视图子控件的位置修改
- (void)updateTopViewSubViewsFrame
{
    CGSize size = _topView.bounds.size;
    CGFloat contectViewW = size.width * 1 / 3.0;
    CGFloat contectViewX = size.width * 0.5 - 0.5 * contectViewW;
    CGFloat contectViewH = self.topViewHeight * 0.35;
    CGFloat contectViewY = size.height - contectViewH -2;
    _topViewContentView.frame = CGRectMake(contectViewX, contectViewY, contectViewW, contectViewH);
    
    //非刷新状态控件
    CGFloat imageViewW = contectViewW * 1 / 4.0;
    CGFloat imageViewH = contectViewH * 0.5;
    CGFloat imageViewX = 0;
    CGFloat imageViewY = contectViewH * 0.5;
    _topViewStatusImageView.frame = CGRectMake(imageViewX, imageViewY, imageViewW, imageViewH);
    
    CGFloat labelW = contectViewW - imageViewW;
    CGFloat labelH = imageViewH;
    CGFloat labelX = imageViewX + imageViewW;
    CGFloat labelY = imageViewY;
    _topViewStatusLabel.frame = CGRectMake(labelX, labelY, labelW, labelH);
}

#pragma mark - 更新顶部视图的内容,根据下拉状态来显示不同的内容
- (void)updateTopViewContent
{
    //刷新
    if(_topRefreshStatus == LRWRefreshStatusRefreshing)
    {
        if (!_topViewIsLoading) {
            [self showRefreshing];
        }
        return;
    }
    
    CGFloat height = _topView.bounds.size.height;
    //释放刷新
    if (height > 1.5 * self.topViewHeight) {
        [self showUp];
    }
}
#pragma mark 下拉状态
- (void)showDown
{
    _topRefreshStatus = LRWRefreshStatusDown;
    [UIView animateWithDuration:0.25 animations:^{
        _topViewStatusLabel.text = @"下拉刷新";
        _topViewStatusImageView.transform = CGAffineTransformRotate(_topViewStatusImageView.transform, M_PI);
    }];
    CGFloat topEdg = self.topViewHeight;
    CGFloat bottomEdg = _bottomViewIsLoading ? self.bottomViewHeight : _bottomEdge;
    self.tableView.contentInset = UIEdgeInsetsMake(topEdg, 0, bottomEdg, 0);
}

#pragma mark 上拉状态
- (void)showUp
{
    if (!(_topRefreshStatus == LRWRefreshStatusUp)) {
        _topRefreshStatus = LRWRefreshStatusUp;
        [UIView animateWithDuration:0.25 animations:^{
            _topViewStatusLabel.text = @"释放刷新";
            _topViewStatusImageView.transform = CGAffineTransformRotate(_topViewStatusImageView.transform, M_PI);
        }];
    }
}
#pragma mark 加载中状态
- (void)showRefreshing
{
    [self.tableView setContentOffset:CGPointMake(0, -self.topViewHeight) animated:YES];
    _topViewIsLoading = YES;
    self.tableView.bounces = NO;
    _topViewStatusLabel.text = @"加载中...";
    _topViewStatusImageView.transform = CGAffineTransformRotate(_topViewStatusImageView.transform, M_PI);
    _topViewStatusImageView.animationImages = nil;
    //下面是通过UIImageView自带的播放连续图片功能，模拟播放GIF图片
    [self showLoadingImageView:_topViewStatusImageView];
    NSLog(@"准备刷新");
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if ([self.delegate respondsToSelector:@selector(refreshTableViewControllerHeadViewDidStartLoding:)]) {
            [self.delegate refreshTableViewControllerHeadViewDidStartLoding:self];
        }
    });
}
#pragma mark - 底部视图的显示和隐藏
- (void)hideBottomView
{
    _bottomView.hidden = YES;
    CGFloat topEdg = _topViewIsLoading ? self.topViewHeight : _topEdge;
    CGFloat bottomEdg = _bottomEdge;
    self.tableView.contentInset = UIEdgeInsetsMake(topEdg, 0, bottomEdg, 0);
    self.tableView.bounces = YES;
    _bottomViewIsLoading = NO;
}
#pragma mark - 控制底部视图的显示效果
- (void)controlTheBottomView
{
    self.tableView.bounces = NO;
    //底部视图处理
    if (!_bottomView) {
        [self setupBottomView];
    }
    [self updateBottomViewFrame];
    CGFloat topEdg = _topViewIsLoading ? self.topViewHeight : _topEdge;
    CGFloat bottomEdg = self.bottomViewHeight;
    self.tableView.contentInset = UIEdgeInsetsMake(topEdg, 0, bottomEdg , 0);
    _topView.hidden = YES;
    _bottomView.hidden = NO;
    if (!_bottomViewIsLoading) {
        if ([self.delegate respondsToSelector:@selector(refreshTableViewControllerBottomViewDidStartLoding:)]) {
            [self.delegate refreshTableViewControllerBottomViewDidStartLoding:self];
        }
        _bottomViewIsLoading = YES;
    }
    
    CGPoint contentOffset = CGPointMake(0, self.tableView.contentSize.height - TABLEVIEWHEIGHT + self.bottomViewHeight);
    self.tableView.contentOffset = contentOffset;
}

#pragma mark - 底部视图创建
- (void)setupBottomView
{
    CGFloat h  = self.bottomViewHeight;
    CGFloat x = 0;
    CGFloat w = self.tableView.bounds.size.width;
    CGFloat y = TABLEVIEWHEIGHT + h;
    _bottomView = [[UIView alloc] initWithFrame:CGRectMake(x, y, w, h)];
    _bottomView.clipsToBounds = YES;
    [self.tableView.superview addSubview:_bottomView];
    _bottomViewContentView = [[UIView alloc] init];
    [_bottomView addSubview:_bottomViewContentView];
    
    _bottomStatusImageView = [[UIImageView alloc] init];
    _bottomStatusImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self showLoadingImageView:_bottomStatusImageView];
    [_bottomViewContentView addSubview:_bottomStatusImageView];
    
    _bottomStatusLabel = [[UILabel alloc] init];
    _bottomStatusLabel.text = @"加载中...";
    _bottomStatusLabel.font = _bottomViewFont;
    _bottomStatusLabel.textColor = [UIColor grayColor];
    _bottomStatusLabel.textAlignment = NSTextAlignmentCenter;
    [_bottomViewContentView addSubview:_bottomStatusLabel];
}
#pragma mark - 底部视图位置设置
- (void)updateBottomViewFrame
{
    CGFloat delh = self.tableView.contentOffset.y  + TABLEVIEWHEIGHT - self.tableView.contentSize.height ;
    if (delh > 0) {
        CGFloat x = 0;
        CGFloat h = _bottomViewHeight;
        CGFloat w = self.tableView.bounds.size.width;
        CGFloat y = self.tableView.contentSize.height - self.tableView.contentOffset.y;
        _bottomView.frame = CGRectMake(x, y, w, h);
    }
    [self updateBottomSubviewsFrame];
}
#pragma mark - 底部视图子控件位置设置
- (void)updateBottomSubviewsFrame
{
    CGSize size = _bottomView.bounds.size;
    CGFloat contectViewW = size.width * 1 / 6.0;
    CGFloat contectViewX = size.width * 0.5 - 0.5 * contectViewW;
    CGFloat contectViewH = size.height;
    CGFloat contectViewY = 0;
    _bottomViewContentView.frame = CGRectMake(contectViewX, contectViewY, contectViewW, contectViewH);
    
    //非刷新状态控件
    CGFloat imageViewH = contectViewH * 0.5;
    CGFloat imageViewW = imageViewH;
    CGFloat imageViewX = 0;
    CGFloat imageViewY = (contectViewH - imageViewH) * 0.5;
    _bottomStatusImageView.frame = CGRectMake(imageViewX, imageViewY, imageViewW, imageViewH);
    
    CGFloat labelW = contectViewW - imageViewW;
    CGFloat labelH = contectViewH;
    CGFloat labelX = imageViewX + imageViewW;
    CGFloat labelY = 0;
    _bottomStatusLabel.frame = CGRectMake(labelX, labelY, labelW, labelH);
 
}

#pragma mark - 显示加载图片
- (void)showLoadingImageView:(UIImageView *)imageView
{
    if (_refreshingImageData == nil) {
        _refreshingImageData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"refreshing" ofType:@"gif"]];
    }

    CGImageSourceRef imageSource = CGImageSourceCreateWithData((CFDataRef)_refreshingImageData, NULL);
    size_t imageCount = CGImageSourceGetCount(imageSource);
    NSMutableArray *imagesArray = [[NSMutableArray alloc] initWithCapacity:(NSInteger)imageCount];
    NSTimeInterval totalTime = 0;
    for (NSInteger index = 0; index < imageCount; ++index) {
        CGImageRef aImageRef = CGImageSourceCreateImageAtIndex(imageSource, index, NULL);
        UIImage *aImage = [UIImage imageWithCGImage:aImageRef];
        [imagesArray addObject:aImage];
        
        NSDictionary *properties = (__bridge NSDictionary *)CGImageSourceCopyPropertiesAtIndex(imageSource, index, NULL);
        NSDictionary *gifProperties = [properties valueForKey:(__bridge NSString *)kCGImagePropertyGIFDictionary];
        NSString *gifDelayTime = [gifProperties valueForKey:(__bridge NSString* )kCGImagePropertyGIFDelayTime];
        totalTime += [gifDelayTime floatValue];
    }
    imageView.animationImages = imagesArray;
    imageView.animationDuration = totalTime;
    imageView.animationRepeatCount = 0;
    [imageView startAnimating];
}
@end



