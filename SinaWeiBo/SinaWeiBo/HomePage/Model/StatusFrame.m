//
//  StatusFrame.m
//  微博SDK测试
//
//  Created by lrw on 15/1/4.
//  Copyright (c) 2015年 LRW. All rights reserved.
//

//间距
#define MARGIN (5.0)
#define TEXTFONT [UIFont systemFontOfSize:14]
//设置只有一张图片的宽高
//缩略图
#define ONLEONEIMAGEMINWIDTH (200)
#define ONLEONEIMAGEMINHEIGHT (100)
//中等图片
#define ONLEONEIMAGEMAXWIDTH [[UIScreen mainScreen] bounds].size.width - (2 * MARGIN)
#define ONLEONEIMAGEMAXHEIGHT [[UIScreen mainScreen] bounds].size.width - (2 * MARGIN)


#import "StatusFrame.h"
#import "UIView+LRW.h"
#import "Status.h"
#import "Statu.h"
#import "User.h"
#import "NSString+Date.h"
@implementation StatusFrame
- (void)setStatus:(Statu *)status
{
    _status = status;
    
    //用户头像
    [self setUp_profile_imageFrame];
    
    //用户名称
    [self setUp_screen_nameFrame];
    
    //vip图标位置
    [self setUp_vipIconFrame];
    
    //发布时间位置
    [self setUp_created_atFrame];
    
    //来源地
    [self setUp_sourceFrame];
    
    //设置文本内容位置
    [self setUp_textFrame];
    
    //设置所有图标位置
    [self setUp_imagesFrame];
    
    //设置图片区域位置
    [self setUp_imagesViewFrame];
    
    //设置转发区域位置
    [self setUp_transpondAreaFrames];
    
    //设置工具栏位置
    [self setUp_toolBarFrame];
}

- (void)setShowMediumPicture:(BOOL)showMediumPicture
{
    _showMediumPicture = showMediumPicture;
    [self setStatus:_status];
    NSLog(@"%@ %@",NSStringFromCGRect(_imagesViewFrame),NSStringFromCGRect([_imagesFrame.firstObject CGRectValue]));
}

/**设置转发区域位置*/
- (void)setUp_transpondAreaFrames
{
    Statu *retweeted_status = _status.retweeted_status;
    if (retweeted_status != nil) {
        //设置转发区域子控件位置
        StatusFrame *transpondAreaFrames = [StatusFrame new];
        transpondAreaFrames.status = retweeted_status;
        _transpondArea_viewsFrame = transpondAreaFrames;
    }
    //设置转发区域位置
    CGFloat x = 0;
    CGFloat y = CGRectGetMaxY(_imagesViewFrame) + MARGIN;
    CGFloat h = _transpondArea_viewsFrame.cellHeight;
    CGFloat w = [[UIScreen mainScreen] bounds].size.width;
    _transpondAreaFrame = CGRectMake(x, y, w, h);
}


/**设置用户头像位置*/
- (void)setUp_profile_imageFrame
{
    CGFloat x = MARGIN;
    CGFloat y = MARGIN;
    CGFloat w = 35.0;
    CGFloat h = 35.0;
    _profile_imageFrame =  CGRectMake(x, y, w, h);
}

/**设置用户呢称位置*/
- (void)setUp_screen_nameFrame
{
    //NSDictionary *user = _status.user;
    CGFloat x = CGRectGetMaxX(_profile_imageFrame) + MARGIN;
    CGFloat y = CGRectGetMinY(_profile_imageFrame);
    CGFloat h = 15.0;
    
    //获取文本显示内容大少
    UIFont *font = [UIFont systemFontOfSize:13.0];//文本格式
    CGSize textFrame = [UIView lrw_getTextSizeWithMaxSize:CGSizeMake(MAXFLOAT, h) Text:_status.user.screen_name Font:font];
    CGFloat w = textFrame.width;
    _screen_nameFrame =  CGRectMake(x, y, w, h);
}

/**设置vip图标位置*/
- (void)setUp_vipIconFrame
{
    CGFloat h = CGRectGetHeight(_screen_nameFrame) * 0.6;
    CGFloat w = h;
    CGFloat screen_name_centerY = CGRectGetMinY(_screen_nameFrame) + 0.5 * CGRectGetHeight(_screen_nameFrame);
    CGFloat y = screen_name_centerY - 0.5 * h;
    CGFloat x = CGRectGetMaxX(_screen_nameFrame) + MARGIN;
    _vipIconFrame =  CGRectMake(x, y, w, h);
}

/**设置发布时间文本位置*/
- (void)setUp_created_atFrame
{
    CGFloat x = CGRectGetMaxX(_profile_imageFrame) + MARGIN;
    CGFloat y = CGRectGetMaxY(_screen_nameFrame) + MARGIN;
    CGFloat h = 10.0;
    
    //获取文本显示内容大少
    UIFont *font = [UIFont systemFontOfSize:10.0];//文本格式

    CGSize textFrame = [UIView lrw_getTextSizeWithMaxSize:CGSizeMake(MAXFLOAT, h)
                                                     Text:_status.created_at
                                                     Font:font];
    
    
    CGFloat w = textFrame.width;
    _created_atFrame =  CGRectMake(x, y, w, h);
}

/**设置来源文本位置*/
- (void)setUp_sourceFrame
{
    CGFloat x = CGRectGetMaxX(_created_atFrame) + MARGIN;
    CGFloat y = CGRectGetMinY(_created_atFrame);
    CGFloat h = CGRectGetHeight(_created_atFrame);
    
    //获取文本显示内容大少
    UIFont *font = [UIFont systemFontOfSize:10.0];//文本格式
    CGSize textFrame = [UIView lrw_getTextSizeWithMaxSize:CGSizeMake(MAXFLOAT, h)
                                                     Text:_status.source
                                                     Font:font];
    CGFloat w = textFrame.width;
    _sourceFrame =  CGRectMake(x, y, w, h);
    //NSLog(@"_sourceFrame : %@",NSStringFromCGRect(_sourceFrame));
}


/**内容文本位置*/
- (void)setUp_textFrame
{
    CGFloat x = MARGIN;
    CGFloat y = CGRectGetMaxY(_profile_imageFrame) + MARGIN;
    
    CGFloat w = [[UIScreen mainScreen] bounds].size.width - 2 * MARGIN;
    //    NSLog(@"%f",w);
    //获取文本显示内容大少
    UIFont *font = TEXTFONT;//文本格式
    CGSize textFrame = [UIView lrw_getTextSizeWithMaxSize:CGSizeMake(w, MAXFLOAT)
                                                     Text:_status.text
                                                     Font:font];
    CGFloat h = textFrame.height;
    _textFrame =  CGRectMake(x, y, w, h);
    //NSLog(@"_textFrame : %@",NSStringFromCGRect(_textFrame));
    
    //如果是转发内容
    if (_status.is_retweeted_status)
    {
        //隐藏用户呢称，用户头像，微博创建时间，来源地，vip头像，按钮
        _profile_imageFrame = CGRectZero;
        _screen_nameFrame = CGRectZero;
        _vipIconFrame = CGRectZero;
        _created_atFrame = CGRectZero;
        _sourceFrame = CGRectZero;
        _textFrame = CGRectMake(MARGIN, MARGIN, w, h);
    }
}

/**设置所有图标位置*/
- (void)setUp_imagesFrame
{
    NSMutableArray *frames = [NSMutableArray array];
    NSArray *urlArray = self.status.pic_urls;
    CGFloat margin_x = 5;//横向间距
    CGFloat margin_y = 5;//纵向间距
    CGFloat width;//图片宽度
    CGFloat height;//图片高度
    CGFloat x;//图片x坐标值
    CGFloat y;//图片y坐标值
    //设置宽高
    if (urlArray.count == 1) {
        if (_showMediumPicture)//显示中等图片
        {
            width = ONLEONEIMAGEMAXWIDTH;
            height = ONLEONEIMAGEMAXHEIGHT;
        }
        else
        {
            width = ONLEONEIMAGEMINWIDTH;
            height = ONLEONEIMAGEMINHEIGHT;
        }
    }
    else
    {
        width = 80;
        height = 80;
    }
    //计算位置
    CGFloat row;//第几行
    CGFloat column;//第几列
    NSInteger columnCount = 3;//最多能够显示列数
    for (NSInteger i = 0; i < urlArray.count; ++i) {
        row = i / columnCount;
        column = i % columnCount;
        x = margin_x + column * (width + margin_x);
        y = margin_y + row * (height + margin_y);
        if (_showMediumPicture && urlArray.count == 1) {
            //当显示微博正文而且只有一张图片的时候
            x = 0;
            y = 0;
        }
        [frames addObject:[NSValue valueWithCGRect:CGRectMake(x, y, width, height)]];
    }
    _imagesFrame = frames;
}

/**设置图片区域位置*/
- (void)setUp_imagesViewFrame
{
    //设置高度
    //获取最后一图图片的最大y值
    CGFloat imagesFrame_maxY = CGRectGetMaxY([_imagesFrame.lastObject CGRectValue]);
    CGFloat h = imagesFrame_maxY + MARGIN;
    CGFloat w = [[UIScreen mainScreen] bounds].size.width - 2 * MARGIN;
    if (_imagesFrame.count == 0)
    {
        h = 0;
    }
    
    CGFloat x = MARGIN;
    CGFloat y = CGRectGetMaxY(_textFrame) + MARGIN;
    
    _imagesViewFrame =  CGRectMake(x, y, w, h);
}

/**设置工具栏位置*/
- (void)setUp_toolBarFrame
{
    CGFloat x = 0;
    CGFloat y = CGRectGetMaxY(_transpondAreaFrame);
    CGFloat h = 33;
    CGFloat w = [[UIScreen mainScreen] bounds].size.width;
    _toolBarFrame =  CGRectMake(x, y, w, h);
    if (_status.is_retweeted_status) {
        _toolBarFrame = CGRectMake(x, y, w, 0);
    }
}

- (CGFloat)cellHeight
{
    CGFloat height = CGRectGetMaxY(_toolBarFrame);
    return height;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
