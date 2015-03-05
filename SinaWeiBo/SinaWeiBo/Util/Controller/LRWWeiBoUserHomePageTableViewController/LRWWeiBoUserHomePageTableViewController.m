//
//  TableViewController.m
//  微博个人主页控制器
//
//  Created by lrw on 15/1/30.
//  Copyright (c) 2015年 LRW. All rights reserved.
//
#define FirstSectionBtnTag 88
#import "LRWWeiBoUserHomePageTableViewController.h"

@interface LRWWeiBoUserHomePageTableViewController ()
{
    CGSize _size;
    /**导航栏显示背景图片*/
    UIImage *_navigationBackgroundImage_show;
    /**导航栏隐藏背景图片*/
    UIImage *_navigationBackgroundImage_hide;
    /**显示中间等待视图*/
    UIActivityIndicatorView *_centeractivityView;
    
    //------------背景图片-----------------------
    UIImageView *_table_view_background_image_view;
    UIView *_imageview_covering;
    //------------table view 头部视图
    UIView *_table_view_header_view;
    CGFloat _table_view_header_view_height;
    /**用户头像*/
    UIImageView *_user_icon;
    /**vip图标*/
    UIImageView *_vip_icon;
    /**性别图标*/
    UIImageView *_sex_icon;
    /**用户名称*/
    UILabel *_screen_name_label;
    /**粉丝标签*/
    UIButton *_show_fans_btn;
    /**粉丝标签和关注标签中间的分割线*/
    UILabel *_dividing_line_label;
    /**简介和按钮的区域视图*/
    UIView *_introduction_or_btn_view;
    /**简介标签*/
    UILabel *_introduction_label;
    /**关注按钮*/
    UIButton *_focus_on_btn;
    UIColor *_focusOnBtnColor;
    
    /**关注标签*/
    UIButton *_show_focus_on_btn;
    /**私信按钮*/
    UIButton *_direct_messages_btn;
    //------------第一个分组的头部视图--------------
    UIView *_first_section_header_view;
    CGFloat _first_section_header_view_height;
    /**"首页"按钮*/
    UIButton *_home_page_btn;
    /**"微博"按钮*/
    UIButton *_weibo_btn;
    /**“相册”按钮*/
    UIButton *_photo_album_btn;
    /**按钮指示器，表示选中那个按钮*/
    UIView *_indicator;
    /**指示器是否正在移动*/
    BOOL _indicatorAnimating;
    /**选中按钮显示的字体颜色*/
    UIColor *_btnTextSelectedColor;
    /**没有选中按钮显示的字体颜色*/
    UIColor *_btnTextUnSelectColor;
    NSInteger _showBtnIndex;

    /**“首页”视图*/
     UIView *_home_page_view;
    /**“相册”视图*/
     UIView *_photo_album_view;
    /**”微博“视图*/
     UIView *_weibo_view;
    
    /**判断顶部是否正在刷新*/
    BOOL _isTopRefreshing;
    /**判断中部是否刷新*/
    BOOL _isBotttomRefreshing;
    /**判断是否中部正在刷新*/
    BOOL _isCenterRefreshing;
}
@end

@implementation LRWWeiBoUserHomePageTableViewController

- (instancetype)initWithStyle:(UITableViewStyle)style
{
    if (self = [super initWithStyle:UITableViewStylePlain]) {
        self.view.backgroundColor = self.view.backgroundColor;
        _focusOnBtnColor = [UIColor orangeColor];
    }
    return self;
}
- (void)focusOnbtnBackgroundColor:(UIColor *)color
{
    _focus_on_btn.backgroundColor = color;
}
#pragma mark - 关注按钮
- (void)canClickFocusOnBtn:(BOOL)can
{
    if (can) {
        _focus_on_btn.backgroundColor = [UIColor orangeColor];
        [_focus_on_btn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        [_focus_on_btn setTitle:@"关注" forState:(UIControlStateNormal)];
    }
    else
    {
        _focus_on_btn.backgroundColor = [UIColor whiteColor];
        [_focus_on_btn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        [_focus_on_btn setTitle:@"取消关注" forState:(UIControlStateNormal)];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _navigationBackgroundImage_hide = [UIImage imageNamed:@"navbackgroundimage_hide.jpg"];
    _navigationBackgroundImage_show = [UIImage imageNamed:@"navbackgroundimage_show.png"];
    [self.navigationController.navigationBar setBackgroundImage:_navigationBackgroundImage_hide forBarMetrics:(UIBarMetricsDefaultPrompt)];
    _size = self.view.bounds.size;
    [self.tableView addObserver:self forKeyPath:@"contentOffset"options:(NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld) context:@"contentOffset"];
    [self.tableView addObserver:self forKeyPath:@"backgroundColor" options:(NSKeyValueObservingOptionNew) context:@"backgroundColor"];
    
    [self setupTableViewHeadView];
    [self setupHeaderViewInFirstSection];
    [self setupBackgroundImageView];
    /*
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"toolbar_leftarrow"] style:(UIBarButtonItemStylePlain) target:self action:@selector(backBarButtonItemClick:)];
    self.navigationItem.leftBarButtonItem = leftItem;
     */
    [_centeractivityView startAnimating];
    _imageview_covering.clipsToBounds = YES;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self controlTheNavigaionBarBackgroundImageAndTitle];
}
- (void)backBarButtonItemClick:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [self updateScreenNameLabelAndOtherIconFrame];
}

- (void)dealloc
{
    [self.tableView removeObserver:self forKeyPath:@"contentOffset"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    NSString *str = (__bridge NSString *)(context);
    if (object == self.tableView && [str isEqualToString:@"contentOffset"]) {
        //背景图片视差移动
        [self controlTheImageView:change];
        //导航栏的背景变化
        [self controlTheNavigaionBarBackgroundImageAndTitle];
        //顶部刷新
        [self controlTopRefresh];
        //控制底部刷新
        [self controlBottomRefresh];
    }
    else if (object == self.tableView && [str isEqualToString:@"backgroundColor"])
    {
        _imageview_covering.backgroundColor = change[@"new"];
    }
}
#pragma mark - 控制底部刷新
- (void)controlBottomRefresh
{
    if (_isBotttomRefreshing) {
        return;
    }
    CGFloat contentSizeH = self.tableView.contentSize.height;
    CGFloat contentOffsetY = self.tableView.contentOffset.y;
    //UIEdgeInsets contentInset = self.tableView.contentInset;
    //CGFloat contentInsetBottom = self.tableView.contentInset.bottom;
    CGFloat tableViewH = self.tableView.bounds.size.height;
    CGFloat resulut = contentSizeH - contentOffsetY - tableViewH + 30;
    BOOL isComeToBottom = (resulut <= 0) && contentSizeH > _size.height;
    if (isComeToBottom) {
        _isBotttomRefreshing = YES;
        if ([self.delegate respondsToSelector:@selector(weiBoUserHomePageTableViewControllerBottomRefresing:)]) {
            [self.delegate weiBoUserHomePageTableViewControllerBottomRefresing:self];
        }
    }
}

#pragma mark - 控制顶部刷新
- (void)controlTopRefresh
{
    if (_isTopRefreshing) {
        return;
    }
    if (self.tableView.contentOffset.y <= -_table_view_header_view_height) {
        _isTopRefreshing = YES;
//        NSLog(@"准备顶部刷新");
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            //在这里通知代理正在刷新
            if ([self.delegate respondsToSelector:@selector(weiBoUserHomePageTableViewControllerTopRefresing:)])
            {
                [self.delegate weiBoUserHomePageTableViewControllerTopRefresing:self];
            }
//        });
    }
}


#pragma mark - 控制table view 背景图片移动
- (void)controlTheImageView:(NSDictionary *)change
{
    CGPoint oldOffset = [change[@"old"] CGPointValue];
    CGPoint newOffset = [change[@"new"] CGPointValue];
    CGFloat delY = newOffset.y - oldOffset.y;
    CGRect imageViewFrame = _table_view_background_image_view.frame;
    imageViewFrame.origin.y += delY * 0.5;
    _table_view_background_image_view.frame = imageViewFrame;
    _table_view_background_image_view.clipsToBounds = YES;
 
}

#pragma mark - 控制导航栏显示的图片和标题
- (void)controlTheNavigaionBarBackgroundImageAndTitle
{
    CGFloat tableViewHeadViewMaxY = CGRectGetMaxY(_table_view_header_view.frame);
    if (20 + self.tableView.contentOffset.y + self.navigationController.navigationBar.bounds.size.height>= tableViewHeadViewMaxY)
    {
        [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:0];
        self.title = _screen_name_label.text;
        
    }
    else
    {
        [self.navigationController.navigationBar setBackgroundImage:_navigationBackgroundImage_hide forBarMetrics:0];
        self.title = @"";
    }
}

#pragma mark - Table view data source
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return 1;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return 30;
//}
//-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    static NSString *ID = @"contact";
//    
//    //获得cell
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
//    }
//    
//    //设置cell数据
//    
//    return cell;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return _first_section_header_view_height;
    }
    return 1.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return _first_section_header_view;
    }
    return nil;
}

#pragma mark - 创建第一个分组的头部视图
- (void)setupHeaderViewInFirstSection
{
    _first_section_header_view_height = 30;
    _first_section_header_view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _size.width, _first_section_header_view_height)];
    _first_section_header_view.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1];
//    _first_section_header_view.layer.borderColor = [UIColor grayColor].CGColor;
//    _first_section_header_view.layer.borderWidth = 0.5;
    _first_section_header_view.layer.shadowColor = [UIColor blackColor].CGColor;
    _first_section_header_view.layer.shadowOpacity = 0.2;
    _first_section_header_view.layer.shadowOffset = CGSizeMake(0, _first_section_header_view_height / 10);
    _btnTextSelectedColor = [UIColor blackColor];
    _btnTextUnSelectColor = [UIColor grayColor];
    _indicatorAnimating = NO;
    //创建子控件
    _showBtnIndex = 1;//默认显示选中第一项
    _home_page_btn = [UIButton buttonWithType:UIButtonTypeCustom];
    _home_page_btn.tag = FirstSectionBtnTag + 0;
    [_home_page_btn setTitle:@"首页" forState:UIControlStateNormal];
    [_home_page_btn setTitleColor:_btnTextUnSelectColor forState:(UIControlStateNormal)];
    [_home_page_btn addTarget:self action:@selector(firstSectionViewBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
    [_first_section_header_view addSubview:_home_page_btn];
    _weibo_btn = [UIButton buttonWithType:UIButtonTypeCustom];
    _weibo_btn.tag = FirstSectionBtnTag + 1;
    [_weibo_btn setTitle:@"微博" forState:UIControlStateNormal];
    [_weibo_btn setTitleColor:_btnTextSelectedColor forState:(UIControlStateNormal)];
    [_weibo_btn addTarget:self action:@selector(firstSectionViewBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
    [_first_section_header_view addSubview:_weibo_btn];
    _photo_album_btn = [UIButton buttonWithType:UIButtonTypeCustom];
    _photo_album_btn.tag = FirstSectionBtnTag + 2;
    [_photo_album_btn setTitle:@"相册" forState:UIControlStateNormal];
    [_photo_album_btn setTitleColor:_btnTextUnSelectColor forState:(UIControlStateNormal)];
    [_photo_album_btn addTarget:self action:@selector(firstSectionViewBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
    [_first_section_header_view addSubview:_photo_album_btn];
    _indicator = [[UIView alloc] init];
    _indicator.backgroundColor = [UIColor orangeColor];
    [_first_section_header_view addSubview:_indicator];
    //设置子控件位置
    UIFont *btnFont = [UIFont systemFontOfSize:15];
    CGFloat btnW = 50;
    CGFloat btnH = _first_section_header_view_height;
    CGFloat btnY = 0;
    CGFloat btnX;
    CGFloat btnSpacing = 20;
    CGFloat leftSpacing = (_size.width - 3 * btnW - 2 * btnSpacing) * 0.5;
    btnX = leftSpacing;
    _home_page_btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
    _home_page_btn.titleLabel.font = btnFont;
    btnX = CGRectGetMaxX(_home_page_btn.frame) + btnSpacing;
    _weibo_btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
    _weibo_btn.titleLabel.font = btnFont;
    btnX = CGRectGetMaxX(_weibo_btn.frame) + btnSpacing;
    _photo_album_btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
    _photo_album_btn.titleLabel.font = btnFont;
    CGFloat indicatorH = 2;
    _indicator.frame = CGRectMake(CGRectGetMinX(_weibo_btn.frame), btnH - indicatorH, btnW, indicatorH);
}

#pragma mark - 指示器移动位置
- (void)moveTheIndicator:(UIButton *)btn
{
    CGRect frame = _indicator.frame;
    frame.origin.x = btn.frame.origin.x;
    _indicatorAnimating = YES;
    [UIView animateWithDuration:0.3 animations:^{
        _indicator.frame = frame;
    } completion:^(BOOL finished) {
        _indicatorAnimating = NO;
    }];
}

#pragma mark - 第一个分组按钮点击方法
- (void)firstSectionViewBtnClick:(UIButton *)btn
{
    if (_indicatorAnimating) {
        return;
    }
    if (self.tableView.contentOffset.y > CGRectGetMaxY(_table_view_header_view.frame)) {
       self.tableView.contentOffset = CGPointMake(0, CGRectGetMaxY(_table_view_header_view.frame));
    }
    [_home_page_btn setTitleColor:_btnTextUnSelectColor forState:(UIControlStateNormal)];
    [_weibo_btn setTitleColor:_btnTextUnSelectColor forState:(UIControlStateNormal)];
    [_photo_album_btn setTitleColor:_btnTextUnSelectColor forState:(UIControlStateNormal)];
        [btn setTitleColor:_btnTextSelectedColor forState:(UIControlStateNormal)];
    [self moveTheIndicator:btn];
    if (_showBtnIndex == btn.tag - FirstSectionBtnTag) {
        return;
    }
    else
    {
        _showBtnIndex = btn.tag - FirstSectionBtnTag;
    }
    NSLog(@"准备中部刷新");
    [self startCenterRefreshing];
    if ([self.delegate respondsToSelector:@selector(weiBoUserHomePageTableViewController:didClickBtnInToolBar:)]) {
        [self.delegate weiBoUserHomePageTableViewController:self didClickBtnInToolBar:btn.tag - FirstSectionBtnTag];
    }
}



#pragma mark - 创建 table view 背景图片和图片遮盖视图,中心加载视图
- (void)setupBackgroundImageView
{
    _imageview_covering = [[UIView alloc] initWithFrame:CGRectMake(0, _table_view_header_view_height, _size.width, _size.height)];
    _imageview_covering.backgroundColor = self.tableView.backgroundColor;
    _centeractivityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:(UIActivityIndicatorViewStyleGray)];
    _centeractivityView.center = CGPointMake(_imageview_covering.center.x, (_size.height - _table_view_header_view_height ) * 0.5 - _first_section_header_view_height);
    [_imageview_covering addSubview:_centeractivityView];
    [self.tableView insertSubview:_imageview_covering atIndex:0];
    
    
    _table_view_background_image_view = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"image_processor_oldphotofilter.jpg"]];
    _table_view_background_image_view.frame = CGRectMake(0, -0.5 * _table_view_header_view_height, _size.width, _table_view_header_view_height * 3);
    _table_view_background_image_view.contentMode = UIViewContentModeTop;
    _table_view_background_image_view.clipsToBounds = YES;
    [self.tableView insertSubview:_table_view_background_image_view belowSubview:_imageview_covering];
}
#pragma mark - 开始加载
- (void)startCenterRefreshing
{
    _isCenterRefreshing = YES;
    [_centeractivityView startAnimating];
}
- (void)startTopRefreshing
{
    _isTopRefreshing = YES;
}
-(void)startBottomRefreshing
{
    _isBotttomRefreshing = YES;
}
#pragma mark - 停止加载
- (void)stopCenterRefreshing
{
    _isCenterRefreshing = NO;
   [_centeractivityView stopAnimating];
}
- (void)stopTopRefreshing
{
    _isTopRefreshing = NO;
}
- (void)stopBottomRefreshing
{
    _isBotttomRefreshing = NO;
}


#pragma mark - 创建 table view 头部视图
- (void)setupTableViewHeadView
{
    _table_view_header_view_height = 200;
    _table_view_header_view= [[UIView alloc] initWithFrame:CGRectMake(0, 0, _size.height, _table_view_header_view_height)];
    self.tableView.tableHeaderView = _table_view_header_view;
    
    //-------------下面是子控件的创建-------------
    CGFloat introductionorbtnviewW = _size.width;
    CGFloat introductionorbtnviewH = 60;
    CGFloat introductionorbtnviewX = 0;
    CGFloat introductionorbtnviewY = _table_view_header_view_height - introductionorbtnviewH;
    UIFont *btnFont;
    CGFloat btnW = 100;
    CGFloat btnH = 25;
    CGFloat btnY;
    CGFloat btnX;
    CGFloat btnSpacing;
    CGFloat leftSpacing;
    
    /**简介和按钮的区域视图*/
    _introduction_or_btn_view = [[UIView alloc] initWithFrame:CGRectMake(introductionorbtnviewX, introductionorbtnviewY, introductionorbtnviewW, introductionorbtnviewH)];
    _introduction_or_btn_view.backgroundColor = [UIColor whiteColor];
    [_table_view_header_view addSubview:_introduction_or_btn_view];
    CGFloat introductionlabelW = introductionorbtnviewW * 0.8;
    CGFloat introductionlabelH = 20;
    CGFloat introductionlabelX = (introductionorbtnviewW - introductionlabelW) * 0.5;
    CGFloat introductionlabelY = 0;
    /**简介标签*/
    _introduction_label = [[UILabel alloc] initWithFrame:CGRectMake(introductionlabelX, introductionlabelY, introductionlabelW, introductionlabelH)];
    _introduction_label.textAlignment = NSTextAlignmentCenter;
    _introduction_label.font = [UIFont systemFontOfSize:11];
    _introduction_label.lineBreakMode = NSLineBreakByClipping;
    _introduction_label.text = @"";
    _introduction_label.textColor = [UIColor lightGrayColor];
    [_introduction_or_btn_view addSubview:_introduction_label];
    
    btnFont = [UIFont systemFontOfSize:13];
    btnSpacing = 20;
    leftSpacing = (introductionorbtnviewW - 2 *btnW - btnSpacing) * 0.5;
    /**私信按钮*/
    btnX = leftSpacing;
    btnY = CGRectGetMaxY(_introduction_label.frame) + (introductionorbtnviewH - introductionlabelH - btnH) * 0.5;
    CGFloat btnCornerRadius = 2;
    _direct_messages_btn = [UIButton buttonWithType:UIButtonTypeCustom];
    _direct_messages_btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
    _direct_messages_btn.layer.cornerRadius = btnCornerRadius;
    _direct_messages_btn.layer.borderColor = [UIColor blackColor].CGColor;
    _direct_messages_btn.layer.borderWidth = 0.5;
    _direct_messages_btn.backgroundColor = [UIColor orangeColor];
    _direct_messages_btn.titleLabel.font = btnFont;
    [_direct_messages_btn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [_direct_messages_btn setTitle:@"私信" forState:(UIControlStateNormal)];
    [_introduction_or_btn_view addSubview:_direct_messages_btn];
    
    /**关注按钮*/
    btnX = CGRectGetMaxX(_direct_messages_btn.frame) + btnSpacing;
    _focus_on_btn = [UIButton buttonWithType:UIButtonTypeCustom];
    _focus_on_btn.backgroundColor = [UIColor orangeColor];
    _focus_on_btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
    _focus_on_btn.titleLabel.font = btnFont;
    [_focus_on_btn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [_focus_on_btn setTitle:@"关注" forState:(UIControlStateNormal)];
    _focus_on_btn.layer.cornerRadius = btnCornerRadius;
    _focus_on_btn.layer.borderColor = [UIColor blackColor].CGColor;
    [_focus_on_btn addTarget:self action:@selector(focusOn:) forControlEvents:(UIControlEventTouchUpInside)];
    _focus_on_btn.layer.borderWidth = 0.5;
    [_introduction_or_btn_view addSubview:_focus_on_btn];
    
    /**用户头像*/
    CGFloat usericonW = introductionorbtnviewW * 1 / 5;
    CGFloat usericonH = usericonW;
    CGFloat usericonX = introductionorbtnviewW * 0.5 - 0.5 * usericonW;
    CGFloat usericonY = 10;
    _user_icon = [[UIImageView alloc] initWithFrame:CGRectMake(usericonX, usericonY, usericonW, usericonH)];
    _user_icon.backgroundColor = [UIColor blackColor];
    _user_icon.clipsToBounds = YES;
    _user_icon.layer.cornerRadius = usericonW * 0.5;
    [_table_view_header_view addSubview:_user_icon];
    /**用户名称*/
    _screen_name_label = [[UILabel alloc] init];
    _screen_name_label.text = @"";
    _screen_name_label.textColor = [UIColor whiteColor];
    _screen_name_label.layer.shadowColor = [UIColor blackColor].CGColor;
    _screen_name_label.layer.shadowOffset = CGSizeMake(1, 1);
    _screen_name_label.layer.shadowOpacity = 0.7;
    _screen_name_label.font = [UIFont boldSystemFontOfSize:15];
    _screen_name_label.textAlignment = NSTextAlignmentCenter;
    _screen_name_label.adjustsFontSizeToFitWidth = YES;
    [_table_view_header_view addSubview:_screen_name_label];
    /**vip图标*/
    _vip_icon = [[UIImageView alloc] init];
    [_table_view_header_view addSubview:_vip_icon];
    /**性别图标*/
    _sex_icon = [[UIImageView alloc] init];
    [_table_view_header_view addSubview:_sex_icon];
    
    
    [self updateScreenNameLabelAndOtherIconFrame];
    
    /**关注标签*/
    btnFont = [UIFont boldSystemFontOfSize:13];
    btnSpacing = 10;
    leftSpacing = (introductionorbtnviewW - 2 *btnW - btnSpacing) * 0.5;
    CGFloat showfocusonbtnW = btnW;
    CGFloat showfocusonbtnH = btnH;
    CGFloat showfocusonbtnY = CGRectGetMaxY(_screen_name_label.frame) + 2;
    CGFloat showfocusonbtnX = leftSpacing;
    _show_focus_on_btn = [[UIButton alloc] initWithFrame: CGRectMake(showfocusonbtnX, showfocusonbtnY, showfocusonbtnW, showfocusonbtnH)];
    [_show_focus_on_btn setTitle:@"" forState:(UIControlStateNormal)];
    _show_focus_on_btn.titleLabel.font = btnFont;
    _show_focus_on_btn.titleLabel.textAlignment = NSTextAlignmentRight;
    [_show_focus_on_btn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [_table_view_header_view addSubview:_show_focus_on_btn];
    /**粉丝标签*/
    CGFloat showfansbtnW = btnW;
    CGFloat showfansbtnH = btnH;
    CGFloat showfansbtnY = showfocusonbtnY;
    CGFloat showfansbtnX = showfocusonbtnX + btnSpacing + showfocusonbtnW;
    _show_fans_btn = [[UIButton alloc] initWithFrame:CGRectMake(showfansbtnX, showfansbtnY, showfansbtnW, showfansbtnH)];
    _show_fans_btn.titleLabel.textAlignment = NSTextAlignmentLeft;
    [_show_fans_btn setTitle:@"" forState:(UIControlStateNormal)];
    _show_fans_btn.titleLabel.font = btnFont;
    [_show_fans_btn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [_table_view_header_view addSubview:_show_fans_btn];
    /**粉丝标签和关注标签中间的分割线*/
    CGFloat dividinglineW = 2;
    CGFloat dividinglineH = btnH;
    CGFloat dividinglineY = showfansbtnY;
    CGFloat dividinglineX = introductionorbtnviewW * 0.5 - dividinglineW;
    _dividing_line_label = [[UILabel alloc] initWithFrame:CGRectMake(dividinglineX, dividinglineY, dividinglineW, dividinglineH)];
    _dividing_line_label.text = @"|";
    _dividing_line_label.textAlignment = NSTextAlignmentCenter;
    _dividing_line_label.font = btnFont;
    _dividing_line_label.textColor = [UIColor whiteColor];
    [_table_view_header_view addSubview:_dividing_line_label];

}
#pragma mark - 跟新用户呢称和性别图标vip图标的位置
- (void)updateScreenNameLabelAndOtherIconFrame
{
    CGFloat margin = 2;
    CGFloat screennamelabelW = [_screen_name_label.text sizeWithAttributes:@{NSFontAttributeName : _screen_name_label.font}].width;
    CGFloat screennamelabelH = 20;
    CGFloat screennamelabelX = _user_icon.center.x - 0.5 * screennamelabelW;
    CGFloat screennamelabelY = CGRectGetMaxY(_user_icon.frame) + margin;
    _screen_name_label.frame = CGRectMake(screennamelabelX, screennamelabelY, screennamelabelW, screennamelabelH);
    
    CGFloat sexiconW = screennamelabelH;
    CGFloat sexiconH = screennamelabelH;
    CGFloat sexiconX = screennamelabelX + screennamelabelW + margin;
    CGFloat sexiconY = screennamelabelY;
    _sex_icon.frame = CGRectMake(sexiconX, sexiconY, sexiconW, sexiconH);
    CGPoint sexCenter =  _sex_icon.center;
    sexCenter.y = _screen_name_label.center.y;
    _sex_icon.center = sexCenter;
    
    CGFloat vipiconW = screennamelabelH * 0.5;
    CGFloat vipiconH = screennamelabelH * 0.5;
    CGFloat vipiconX = sexiconX + sexiconW + margin;
    CGFloat vipiconY = screennamelabelY;
    _vip_icon.frame = CGRectMake(vipiconX, vipiconY, vipiconW, vipiconH);
    CGPoint vipCenter =  _vip_icon.center;
    vipCenter.y = _screen_name_label.center.y;
    _vip_icon.center = vipCenter;

}

#pragma mark - 设置属性
- (void)setUserIcon:(UIImage *)image
{
    _user_icon.image = image;
}
- (void)setScreenName:(NSString *)name
{
    _screen_name_label.text = name;
    [self updateScreenNameLabelAndOtherIconFrame];
}
- (void)setSexIcon:(UIImage *)image
{
    _sex_icon.image = image;
}
- (void)setVipIcon:(UIImage *)image
{
    _vip_icon.image = image;
}
- (void)setShowFans:(NSString *)fans
{
    NSInteger number = fans.integerValue;
    NSString *text = nil;
    if (number > 10000) {
        text = [NSString stringWithFormat:@"粉丝 %ld万",number/10000];
    }
    else
    {
        text = [NSString stringWithFormat:@"粉丝 %ld",number];
    }
    [_show_fans_btn setTitle:text forState:(UIControlStateNormal)];
}
- (void)setShowFocusOn:(NSString *)focusOn
{
    NSInteger number = focusOn.integerValue;
    NSString *text = nil;
    if (number > 10000) {
        text = [NSString stringWithFormat:@"关注 %ld万",number/10000];
    }
    else
    {
        text = [NSString stringWithFormat:@"关注 %ld",number];
    }
    [_show_focus_on_btn setTitle:text forState:(UIControlStateNormal)];
}

- (void)setIntroduction:(NSString *)text
{
    text = [NSString stringWithFormat:@"简介:%@",text];
    _introduction_label.text = text;
}

- (void)setBackgroundImage:(UIImage *)image
{
    _table_view_background_image_view.image = image;
}

@end
