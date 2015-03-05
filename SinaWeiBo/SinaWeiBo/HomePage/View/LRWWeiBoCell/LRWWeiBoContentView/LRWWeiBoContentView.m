//
//  LRWWeiBoContentView.m
//  微博SDK测试
//
//  Created by lrw on 15/1/19.
//  Copyright (c) 2015年 LRW. All rights reserved.
//

//按钮宽度
#define BUTTONWIDTH 100
#define NIBNAME @"LRWWeiBoContentView"
#define TEXTFONT [UIFont systemFontOfSize:14]

#import "FKDownImageOperation.h"
#import "StatusFrame.h"
#import "Status.h"
#import "UIImageView+AFNetworking.h"
#import "LRWWeiBoContentView.h"
#import "Statu.h"
#import "User.h"
#import "NSString+Date.h"
@interface LRWWeiBoContentView()<LRWWeiBoLabelDelegate,LRWWeiBoImagesAreaDelegate,LRWWeiBoContentViewDelegate,LRWWeiBoToolBarAreaDelegate>
{
    BOOL _touchBegin;
}
/**控制区域*/
@property (weak, nonatomic) IBOutlet UIView *toolBarArea;
@property (nonatomic , weak) LRWWeiBoToolBarArea *weibotoolbararea;

/**图片区域*/
@property (weak, nonatomic) IBOutlet UIView *imagesArea;
@property (nonatomic , weak) LRWWeiBoImagesArea *weiboimagesarea;

/**微博信息内容*/
@property (weak, nonatomic) IBOutlet UIView *textArea;
@property (nonatomic , weak) LRWWeiBoLabel *weiboLabel;

/**微博转发内容*/
@property (weak, nonatomic) IBOutlet UIControl *transpondArea;
@property (nonatomic , weak) LRWWeiBoContentView *transpondContentView;

/**微博来源*/
@property (weak, nonatomic) IBOutlet UILabel *source;
/**微博创建时间*/
@property (weak, nonatomic) IBOutlet UILabel *created_time;
/**vip图标*/
@property (weak, nonatomic) IBOutlet UIImageView *vipIcon;
/**用户头像地址（中图），50×50像素*/
@property (weak, nonatomic) IBOutlet UIImageView *profile_image;
/**用户昵称*/
@property (weak, nonatomic) IBOutlet UIButton *screen_name;
@end


@implementation LRWWeiBoContentView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [[[NSBundle mainBundle] loadNibNamed:NIBNAME owner:nil options:nil] firstObject];
    //初始化工具栏区域
    LRWWeiBoToolBarArea *toolBar = [LRWWeiBoToolBarArea new];
    toolBar.frame = _toolBarArea.bounds;
    _weibotoolbararea = toolBar;
    _weibotoolbararea.delegate = self;
    [_toolBarArea addSubview:toolBar];
    
    //初始化文本区域
    LRWWeiBoLabel *label = [LRWWeiBoLabel new];
    label.frame = _textArea.bounds;
    label.font = TEXTFONT;
    UIColor *labelTextColor = [UIColor colorWithRed:80/255.0 green:125/255.0 blue:175/255.0 alpha:1];
    label.urlColor = labelTextColor;
    label.atColor = labelTextColor;
    label.topicColor = labelTextColor;
    label.delegate = self;
    _weiboLabel = label;
    [_textArea addSubview:label];
    
    //初始化图片区域
    LRWWeiBoImagesArea *imagesArea = [LRWWeiBoImagesArea new];
    imagesArea.frame = _imagesArea.bounds;
    imagesArea.delegate = self;
    _weiboimagesarea = imagesArea;
    [_imagesArea addSubview:imagesArea];
    
    
    //添加点击方法
    [_screen_name addTarget:self action:@selector(screenNameClick:) forControlEvents:(UIControlEventTouchUpInside)];
    _transpondArea.userInteractionEnabled = YES;
    return self;
}
#pragma mark - 重写触摸方 - 实现整个内容被点击方法
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    _touchBegin = YES;
    [super touchesBegan:touches withEvent:event];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (_touchBegin) {
        if (self.status.is_retweeted_status) {
//            NSLog(@"转发：整个View被点击");
            if ([self.delegate respondsToSelector:@selector(weiBoContetnView:didClickContent:)])
            {
                [self.delegate weiBoContetnView:self didClickContent:_status];
            }
        }
        else
        {
//            NSLog(@"整个View被点击");
            if ([self.delegate respondsToSelector:@selector(weiBoContetnView:didClickContent:)])
            {
                [self.delegate weiBoContetnView:self didClickContent:_status];
            }
        }
    }
    _touchBegin = NO;
    [super touchesEnded:touches withEvent:event];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self updateFrames];
}

- (void)setStatusFrame:(StatusFrame *)statusFrame
{
    _statusFrame = statusFrame;
}

#pragma mark - 呢称被点击
- (void)screenNameClick:(id)sender
{
    [self.delegate weiBoContetnView:self didClickScreenName:_status];
}

#pragma mark - 跟新子view位置
- (void)updateFrames
{
    //跟新转发区域位置
    _transpondArea.frame = _statusFrame.transpondAreaFrame;
    if (_transpondContentView) {
        _transpondContentView.frame = _transpondArea.bounds;
        _transpondContentView.statusFrame = _statusFrame.transpondArea_viewsFrame;
    }
    
    //跟新工具栏位置
    if (_status.is_retweeted_status) {//如果是转发内容
        _transpondArea.hidden = YES;
        _profile_image.hidden = YES;
        _screen_name.hidden = YES;
        _vipIcon.hidden = YES;
        _created_time.hidden = YES;
        _source.hidden = YES;
        _toolBarArea.hidden = YES;
    }
    else
    {
        _transpondArea.hidden = NO;
        _profile_image.hidden = NO;
        _screen_name.hidden = NO;
        //_vipIcon.hidden = NO;
        _created_time.hidden = NO;
        _source.hidden = NO;
        _toolBarArea.hidden = NO;
    }
    _profile_image.frame = _statusFrame.profile_imageFrame;
    _screen_name.frame = _statusFrame.screen_nameFrame;
    _vipIcon.frame = _statusFrame.vipIconFrame;
    _created_time.frame = _statusFrame.created_atFrame;
    _source.frame = _statusFrame.sourceFrame;
    _textArea.frame = _statusFrame.textFrame;
    _weiboLabel.frame = _textArea.bounds;
    _imagesArea.frame = _statusFrame.imagesViewFrame;
    _weiboimagesarea.frame = _imagesArea.bounds;
    _weiboimagesarea.imagesFrame = _statusFrame.imagesFrame;
    _toolBarArea.frame = _statusFrame.toolBarFrame;
}
#pragma mark - 设置数据
- (void)setStatus:(Statu *)status
{
    _status = status;
    //1.现实用户数据
    //用户头像
    _profile_image.image = nil;
    [_profile_image setImageWithURL:[NSURL URLWithString:status.user.profile_image_url]];
    
    //vip图标
    NSInteger isVIP = [status.user.mbrank integerValue];
    if (isVIP) {
        NSString *vipIconName = [NSString stringWithFormat:@"common_icon_membership_level%ld",isVIP];
        _vipIcon.image = [UIImage imageNamed:vipIconName];
        _vipIcon.hidden = NO;
    }
    else
    {
        _vipIcon.hidden = YES;
    }
    
    //用户呢称
    [_screen_name setTitle:status.user.screen_name forState:(UIControlStateNormal)];
    UIColor *screen_name_color = isVIP ? [UIColor redColor] : [UIColor blackColor];
    [_screen_name setTitleColor:screen_name_color forState:(UIControlStateNormal)];
    
    //2.显示基本数据
    //创建时间
    _created_time.text = status.created_at;
    
    //来源地
    _source.text = status.source;
    
    //3.显示微博内容
    //显示文字
    _weiboLabel.text = status.text;
    
    //显示图片
    _weiboimagesarea.showMediumPicture = _showMediumPicture;
    _weiboimagesarea.imagesURL = [self changeOnleOneImageURLStringWithShowMediumPicuture:_showMediumPicture];
    
    //初始化转发区域
    if (status.retweeted_status) {
        if (_transpondContentView == nil) {
            LRWWeiBoContentView *transpondContentView = [LRWWeiBoContentView new];
            transpondContentView.frame = _transpondArea.bounds;
            transpondContentView.delegate = self;
            transpondContentView.userInteractionEnabled = YES;
            _transpondContentView = transpondContentView;
            _transpondContentView.backgroundColor = _transpondArea.backgroundColor;
            [_transpondArea addSubview:transpondContentView];
        }
        //显示转发内容
        _transpondContentView.status = status.retweeted_status;
        _transpondArea.hidden = NO;
    }
    else
    {
        _transpondArea.hidden = YES;
    }
    
    //4.显示工具栏数据
    LRWWeiBoToolBarParam *toolBarParam = [LRWWeiBoToolBarParam new];
    toolBarParam.reposts_count = status.reposts_count;
    toolBarParam.comments_count = status.comments_count;
    toolBarParam.attitudes_count = status.attitudes_count;
    _weibotoolbararea.data = toolBarParam;
}
#pragma mark - 是否显示中等图片
- (void)setShowMediumPicture:(BOOL)showMediumPicture
{
    _showMediumPicture = showMediumPicture;
    _weiboimagesarea.imagesURL = [self changeOnleOneImageURLStringWithShowMediumPicuture:showMediumPicture];
}
/**根据是否显示中等图片，修改单一图片的图片地址*/
- (NSArray *)changeOnleOneImageURLStringWithShowMediumPicuture:(BOOL)showMediumPicture
{
    if (_status.pic_urls.count == 1 && showMediumPicture) {
        NSMutableString *urlString = [NSMutableString stringWithString:_status.pic_urls.firstObject];
        [urlString replaceOccurrencesOfString:@"thumbnail" withString:@"bmiddle" options:NSCaseInsensitiveSearch range:NSMakeRange(0, urlString.length)];
        return @[urlString];
    }
    else
    {
        return _status.pic_urls;
    }
}


#pragma mark - 微博图片区域代理 图片被点击方法
- (void)weiBoImagesView:(LRWWeiBoImagesArea *)weiboImagesArea imageViewIndex:(NSInteger)index images:(NSArray *)images
{
    if ([self.delegate respondsToSelector:@selector(weiBoContetnView:didClickImageAtIndex:defaultImages:bmiddleImagesURL:goodNumber:)]) {
        
        //把所有缩略图的url转换为中等图的url
        NSMutableArray *bmiddle_pic_urls = [NSMutableArray arrayWithCapacity:_status.pic_urls.count];
        for (NSString *object in _status.pic_urls) {
            NSMutableString *urlStr = [NSMutableString stringWithString:object];
            [urlStr replaceOccurrencesOfString:@"thumbnail" withString:@"bmiddle" options:NSCaseInsensitiveSearch range:NSMakeRange(0, urlStr.length)];
            [bmiddle_pic_urls addObject:urlStr];
        }
        [self.delegate weiBoContetnView:self didClickImageAtIndex:index defaultImages:images bmiddleImagesURL:bmiddle_pic_urls goodNumber:[NSString stringWithFormat:@"%ld",_status.attitudes_count]];
    }
}

#pragma mark - 转发内容代理方法
- (void)weiBoContetnView:(LRWWeiBoContentView *)weiBoContentView didClickContent:(Statu *)statu
{
    if ([self.delegate respondsToSelector:@selector(weiBoContetnView:didClickContent:)])
    {
        [self.delegate weiBoContetnView:self didClickContent:statu];
    }
}
- (void)weiBoContetnView:(LRWWeiBoContentView *)weiBoContentView didClickImageAtIndex:(NSInteger)index defaultImages:(NSArray *)defaultImages bmiddleImagesURL:(NSArray *)bmiddleImagesURL goodNumber:(NSString *)goodNumber
{
    if ([self.delegate respondsToSelector:@selector(weiBoContetnView:didClickImageAtIndex:defaultImages:bmiddleImagesURL:goodNumber:)]) {
        [self.delegate weiBoContetnView:self didClickImageAtIndex:index defaultImages:defaultImages bmiddleImagesURL:bmiddleImagesURL goodNumber:[NSString stringWithFormat:@"%ld",_status.attitudes_count]];
    }
}
- (void)weiBoContetnView:(LRWWeiBoContentView *)weiBoContentView didClickText:(LRWStringAndRangAndType *)srt
{
    if ([self.delegate respondsToSelector:@selector(weiBoContetnView:didClickText:)]) {
        [self.delegate weiBoContetnView:self didClickText:srt];
    }
}
#pragma mark - 工具栏区域代理方法
- (void)weiBoToolBarAreaGoodBtnClick:(LRWWeiBoToolBarArea *)weiBoToolBarArea
{
//    NSLog(@"赞按钮点击");
    if ([self.delegate respondsToSelector:@selector(weiBoContetnView:didClickToolBarItemAtIndex:)])
    {
        [self.delegate weiBoContetnView:self didClickToolBarItemAtIndex:2];
    }

}

-(void)weiBoToolBarAreaMessageBtnClick:(LRWWeiBoToolBarArea *)weiBoToolBarArea
{
//    NSLog(@"评论按钮点击");
    if ([self.delegate respondsToSelector:@selector(weiBoContetnView:didClickToolBarItemAtIndex:)])
    {
        [self.delegate weiBoContetnView:self didClickToolBarItemAtIndex:1];
    }

}

-(void)weiBoToolBarAreaShareBtnClick:(LRWWeiBoToolBarArea *)weiBoToolBarArea
{
//    NSLog(@"分享钮点击");
    if ([self.delegate respondsToSelector:@selector(weiBoContetnView:didClickToolBarItemAtIndex:)])
    {
        [self.delegate weiBoContetnView:self didClickToolBarItemAtIndex:0];
    }
}

#pragma mark - 微博Label代理 文字被点击的方法
- (void)weiBoLabel:(LRWWeiBoLabel *)label didClickText:(LRWStringAndRangAndType *)srt
{
    if ([self.delegate respondsToSelector:@selector(weiBoContetnView:didClickText:)]) {
        [self.delegate weiBoContetnView:self didClickText:srt];
    }
}
@end








#pragma mark - ******图片区域******
@interface LRWWeiBoImagesArea()<NSURLConnectionDataDelegate>
{
    CGFloat _image0_width;
    NSURLConnection *_image0URLConnection;
    NSMutableData *_image0Data;
    CGRect _image0Frame;
}
@property (weak, nonatomic) IBOutlet UIImageView *imageView_9;
@property (weak, nonatomic) IBOutlet UIImageView *imageView_8;
@property (weak, nonatomic) IBOutlet UIImageView *imageView_7;
@property (weak, nonatomic) IBOutlet UIImageView *imageView_6;
@property (weak, nonatomic) IBOutlet UIImageView *imageView_5;
@property (weak, nonatomic) IBOutlet UIImageView *imageView_4;
@property (weak, nonatomic) IBOutlet UIImageView *imageView_3;
@property (weak, nonatomic) IBOutlet UIImageView *imageView_2;
@property (weak, nonatomic) IBOutlet UIImageView *imageView_1;
@property (weak, nonatomic) IBOutlet UIImageView *imageView_0;

@end
@implementation LRWWeiBoImagesArea
- (instancetype)init
{
    self = [[NSBundle mainBundle] loadNibNamed:NIBNAME owner:nil options:nil][1];
    for (UIView *view in self.subviews) {
        //给每个子控件添加边界
        view.layer.borderWidth = 1;
        view.layer.borderColor = [UIColor whiteColor].CGColor;
        //所有imageView可以与用户交流
        view.userInteractionEnabled = YES;
            }
    _imageView_0.layer.borderWidth = 0;
    return self;
}
#pragma mark - 创建GIF标签
- (void)createGIFLabelInView:(UIView *)view byURlString:(NSString *)urlString
{
    if ([[urlString substringWithRange:NSMakeRange(urlString.length - 3, 3)] isEqualToString:@"gif"]) {
        //如果是GIF图片
        UIImageView *gifImageView = [[UIImageView alloc] init];
        UIImage *image = [UIImage imageNamed:@"timeline_image_gif"];
        gifImageView.image = image;
        [view addSubview:gifImageView];
    }
    else
    {
        //普通图片,如果存在GIF标签，移除
        for (UIView *aView in view.subviews) {
            [aView removeFromSuperview];
        }
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self updateFrames];
}

#pragma mark - 跟新数据
- (void)setImagesURL:(NSArray *)imagesURL
{
    _imagesURL = imagesURL;
    //清除原来图片数据
    for (UIImageView *imageView in self.subviews) {
        [imageView setImage:nil];
    }
    
    NSString *anImageURLString;
    //只有一张图片的时候特殊处理
    if (imagesURL.count == 1) {
        anImageURLString = imagesURL.firstObject;
        [self createGIFLabelInView:_imageView_0 byURlString:anImageURLString];
        [self downladImage:[NSURL URLWithString:imagesURL.firstObject] imageView:_imageView_0];
    }
    else
    {
        for (int i = 0; i < imagesURL.count; ++i) {
            anImageURLString = imagesURL[i];
            UIImageView *imageView = (UIImageView *)[self viewWithTag:(i + 1)];
            [self createGIFLabelInView:imageView byURlString:anImageURLString];
            [imageView setImageWithURL:[NSURL URLWithString:anImageURLString]];
            //[self downladImage:imagesURL[i] imageView:imageView];
        }
    }
    
}

- (void)setImagesFrame:(NSArray *)imagesFrame
{
    _imagesFrame = imagesFrame;
    [self updateFrames];
}

#pragma mark - 图片异步加载方法
- (void)downladImage:(NSURL *)url imageView:(UIImageView *)imageView
{
    [_image0URLConnection cancel];
    _image0URLConnection = [NSURLConnection connectionWithRequest:[NSURLRequest requestWithURL:url]  delegate:self];
    [_image0URLConnection start];
}
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    _image0Data = [NSMutableData new];
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [_image0Data appendData:data];
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    UIImage *image = [UIImage imageWithData:_image0Data];
    CGRect frame =  [_imagesFrame.firstObject CGRectValue];
    CGFloat scale = frame.size.height / image.size.height;
    if (!_showMediumPicture) {
        frame.size.width = scale * image.size.width;
    }
    _imageView_0.image = image;
    _image0Frame = frame;
    
    [self updateFrames];
}


#pragma mark - 为图片添加点击方法
- (void)setUpRecognizerInImageView:(UIImageView *)imageView
{
    if (imageView.gestureRecognizers.count == 0) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageClick:)];
        [imageView addGestureRecognizer:tap];
    }
}
#pragma mark - 图片被点击方法
- (void)imageClick:(UITapGestureRecognizer *)tap
{
    NSInteger index = 0;
    if ([self.delegate respondsToSelector:@selector(weiBoImagesView:imageViewIndex:images:)]) {
        NSMutableArray *images = [NSMutableArray arrayWithCapacity:_imagesURL.count];
        if (_imagesURL.count == 1) {//只有一张图片的时候
            [images addObject:_imageView_0.image];
        }
        else
        {
            index = tap.view.tag - 1;
            for (int i = 0; i < _imagesURL.count; ++i) {//多张图片
                UIImage *image = [(UIImageView *)[self viewWithTag:i + 1] image];
                if (!image) {
                    image = [UIImage imageNamed:@"empty_picture"];
                }
                [images addObject:image];
            }    
        }
        if (index < _imagesURL.count) {
            [self.delegate weiBoImagesView:self imageViewIndex:index images:images];
        }
    }
}
#pragma mark - 跟新位置
- (void)updateFrames
{
    for (UIView *view in self.subviews) {
        view.hidden = YES;
    }
    if (_imagesFrame.count == 1) {//只有一张图片
        _imageView_0.hidden = NO;
        [self setUpRecognizerInImageView:_imageView_0];
        _imageView_0.frame = _image0Frame;
        //如果存在GIF标签,跟新其位置
        [self updateGIFLabelFrameInView:_imageView_0];
//        for (UIView *aView in _imageView_0.subviews) {
//            aView.frame = CGRectMake(_imageView_0.bounds.size.width  * 0.5,_imageView_0.bounds.size.height - 10,14,10);
//        }
    }
    else //多张图片
    {
        for (int i = 0; i < _imagesFrame.count; ++i) {
            UIImageView *imageView = (UIImageView *)[self viewWithTag:(i + 1)];
            imageView.userInteractionEnabled = YES;
            [self setUpRecognizerInImageView:imageView];
            imageView.hidden = NO;
            imageView.frame = [_imagesFrame[i] CGRectValue];
            //如果存在GIF标签,跟新其位置
            [self updateGIFLabelFrameInView:imageView];
        }
    }
}
#pragma mark - 跟新是否显示全部内容
- (void)setShowMediumPicture:(BOOL)showMediumPicture
{
    _showMediumPicture = showMediumPicture;
    [self updateFrames];
}

#pragma mark - 跟GIF标签位置
- (void)updateGIFLabelFrameInView:(UIView *)view
{
    for (UIView *aView in view.subviews) {
        aView.frame = CGRectMake(view.bounds.size.width - 14,view.bounds.size.height - 10,14,10);
    }
}
@end


#pragma mark - ******工具栏区域******
@interface LRWWeiBoToolBarArea()
- (IBAction)goodBtnClick:(id)sender;
- (IBAction)messageBtnClick:(id)sender;
- (IBAction)shareBtnClick:(id)sender;
/**右边分割线*/
@property (weak, nonatomic) IBOutlet UIView *rightLine;
/**左边分隔线*/
@property (weak, nonatomic) IBOutlet UIView *leftLine;
/**赞按钮*/
@property (weak, nonatomic) IBOutlet UIButton *goodBtn;
/**留言按钮*/
@property (weak, nonatomic) IBOutlet UIButton *messageBtn;
/**分享按钮*/
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;
/**顶部分隔线*/
@property (weak, nonatomic) IBOutlet UIView *topLine;
@end
@implementation LRWWeiBoToolBarArea
- (instancetype)init
{
    self = [[NSBundle mainBundle] loadNibNamed:NIBNAME owner:nil options:nil][2];
    
    return self;
}

- (void)setData:(LRWWeiBoToolBarParam *)data
{
    _data = data;
    NSString *attitudes = data.attitudes_count ? [NSString stringWithFormat:@" %ld",data.attitudes_count] : @" 赞";
    NSString *comments = data.comments_count ? [NSString stringWithFormat:@" %ld",data.comments_count] : @" 评论";
    NSString *reposts = data.reposts_count ? [NSString stringWithFormat:@" %ld",data.reposts_count] : @" 转发";
    [_goodBtn setTitle:attitudes forState:(UIControlStateNormal)];
    [_shareBtn setTitle:reposts forState:(UIControlStateNormal)];
    [_messageBtn setTitle:comments forState:(UIControlStateNormal)];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    //NSLog(@"%@",self);
    CGSize size = self.bounds.size;
    //三分一的宽度
    CGFloat width_3_1 = (size.width / 3.0);
    //分隔线的高度
    CGFloat height_line = (size.height * 0.6);
    
    //-------------------------按钮设置
    _shareBtn.frame = CGRectMake(0, 0, BUTTONWIDTH, size.height);
    _messageBtn.frame = CGRectMake(0, 0, BUTTONWIDTH, size.height);
    _messageBtn.center = CGPointMake(size.width * 0.5, size.height * 0.5);
    _goodBtn.frame = CGRectMake(size.width - BUTTONWIDTH, 0, BUTTONWIDTH, size.height);
    
    //------------------------顶部分隔线
    _topLine.frame = CGRectMake(0, 0, size.width, 1);
    _leftLine.frame = CGRectMake(width_3_1, 0, 1, height_line );
    _leftLine.center = CGPointMake(_leftLine.center.x, size.height * 0.5);
    _rightLine.frame = CGRectMake(size.width - width_3_1, 0, 1, height_line);
    _rightLine.center = CGPointMake(_rightLine.center.x, size.height * 0.5);
}
- (IBAction)goodBtnClick:(id)sender {
    if ([self.delegate respondsToSelector:@selector(weiBoToolBarAreaGoodBtnClick:)]) {
        [self.delegate weiBoToolBarAreaGoodBtnClick:self];
    }
}

- (IBAction)messageBtnClick:(id)sender {
    if ([self.delegate respondsToSelector:@selector(weiBoToolBarAreaMessageBtnClick:)]) {
        [self.delegate weiBoToolBarAreaMessageBtnClick:self];
    }
}

- (IBAction)shareBtnClick:(id)sender {
    if ([self.delegate respondsToSelector:@selector(weiBoToolBarAreaShareBtnClick:)]) {
        [self.delegate weiBoToolBarAreaShareBtnClick:self];
    }
}
@end

@implementation LRWWeiBoToolBarParam
@end