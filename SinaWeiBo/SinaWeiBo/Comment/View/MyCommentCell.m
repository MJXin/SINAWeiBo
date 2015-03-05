//
//  MyCommentCell.m
//  sinaWeiboDemo1
//
//  Created by William-zhang on 15/1/30.
//  Copyright (c) 2015年 William-zhang. All rights reserved.
//

#import "MyCommentCell.h"
#import "Statu.h"
#import "User.h"
#import "Comment.h"
#import "UIImage+ImageCache.h"
#import "NSString+HandleDate.h"
#import "UILabel+ResetSize.h"
#import "StatusView.h"

#define CELLWIDTH 300
#define DITX 15
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define MYGARY [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1];

@interface MyCommentCell ()
{
    //放所有内容的View，方便定位
    UIView* _allView;
    //用户头像
    UIImageView* _userIcon;
    //用户名称
    UILabel* _userName;
    //评论日期
    UILabel* _commentDateAndSource;
    //评论内容
    LRWWeiBoLabel* _commentText;
    //评论的View
    //评论回复的评论内容
    LRWWeiBoLabel* _replyText;
    //回复评论的缩略View
    UIView* _replyView;
    //评论对应微博的缩略
    StatusView* _statusView;
    //微博的缩略图，没有带图片的微博，则用微博作者的头像
    UIImageView* _statusImage;
    //微博作者名字
    UILabel* _statusUserName;
    //微博文字缩略内容
    UILabel* _statusText;
    //控件的边距宽度
    CGFloat _ditWidth;
    
    UIView* _line;
}
@end

@implementation MyCommentCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = MYGARY;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        //各个控件初始化
        _height = 200;
        _allView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _userIcon = [[UIImageView alloc]initWithFrame:CGRectMake(DITX, DITX, 40, 40)];
        _userName = [[UILabel alloc]initWithFrame:CGRectMake(DITX+40+10, DITX, 200, 30)];
        _commentDateAndSource = [[UILabel alloc]initWithFrame:CGRectMake(DITX+40+10, DITX+25, 250, 15)];
        _commentDateAndSource.font = [UIFont systemFontOfSize:11];
       ;
        _commentText = [[LRWWeiBoLabel alloc]init];
        _commentText.atColor = [UIColor blueColor];
        _commentText.urlColor = [UIColor blueColor];
        _commentText.topicColor = [UIColor blueColor];
        _commentText.delegate = self;
        
//        _statusView = [[UIView alloc]init];
//
        [self addSubview:_allView];
        _allView.backgroundColor = [UIColor whiteColor];
        _allView.layer.shadowColor = [UIColor grayColor].CGColor;
        _allView.layer.shadowOffset = CGSizeMake(0, 0.6);
        _allView.layer.shadowOpacity = 0.2;
        _allView.layer.shadowRadius = 0.6;
        [self addSubview:_userIcon];
        [self addSubview:_userName];
        [self addSubview:_commentDateAndSource];
        [self addSubview:_commentText];
        
        //回复按钮
        _replyButton = [[UIButton alloc]initWithFrame:CGRectMake(_width-DITX-50, DITX, 50, 30)];
        [_replyButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [_replyButton setTitle:@"回复" forState:UIControlStateNormal];
        _replyButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _replyButton.layer.borderWidth = 1;
        _replyButton.layer.cornerRadius = 2;
        [_replyButton addTarget:self.delegate action:@selector(replyComment:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_replyButton];
        
//        self.separatorInset = UIEdgeInsetsMake(0, 0, 10, 0);
//        _line = [[UIView alloc]initWithFrame:CGRectMake(0, _height, SCREEN_WIDTH, 10)];
//        _line.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1];
//        [_allView addSubview:_line];
    }
    return self;
}

#pragma mark - 重写width的set方法
-(void)setWidth:(CGFloat)width
{
    _width = width;
    _ditWidth = _width - DITX*2;
}

#pragma mark - 重写comment的设置方法
-(void)setComment:(Comment *)comment
{
    _height = 0;
    _comment = comment;
    _replyButton.frame = CGRectMake(_width-DITX-50, DITX, 50, 30);
    _userIcon.image = [UIImage imageWithURL:comment.user.profile_image_url];
    _userName.text = comment.user.name;
    _commentDateAndSource.text = [[comment.date dateHandle] stringByAppendingFormat:@"  %@",[_comment.source sourceHandle]];;
    _commentText.text = comment.text;
    CGFloat commentLabelHeight = [_commentText resetLabelWithSize:CGSizeMake(SCREEN_WIDTH - DITX*2, 300)];
    _commentText.frame = CGRectMake(DITX, DITX+50, SCREEN_WIDTH - DITX*2, commentLabelHeight);
    
    //加入回复评论的文字和View
    if (_comment.reply) {
        _replyText = [[LRWWeiBoLabel alloc]initWithFrame:CGRectMake(DITX, DITX, 0, 0)];
        _replyText.atColor = [UIColor blueColor];
        _replyText.urlColor = [UIColor blueColor];
        _replyText.topicColor = [UIColor blueColor];
        _replyText.delegate = self;
        _replyText.text = [NSString stringWithFormat:@"@%@:%@",_comment.reply.user.name,_comment.reply.text];
        CGFloat replyLabelHeight = [_replyText resetLabelWithSize:CGSizeMake(_ditWidth, 300)];
        _height +=replyLabelHeight;
        _replyView = [[UIView alloc]initWithFrame:CGRectMake(0, DITX*2+40+commentLabelHeight, _width, DITX*2+replyLabelHeight+70+5)];
        _replyView.backgroundColor = MYGARY;
        [_replyView addSubview:_replyText];
        [self addSubview:_replyView];
        _height += DITX;
    }
    
    _statusView = [[StatusView alloc]initWithFrame:CGRectMake(DITX, DITX+50+commentLabelHeight+10+_height, _ditWidth, 70)];
    _statusView.statu = comment.status;
    //添加点击方法，点击跳转到单条微博页面
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(statusViewTap:)];
    [_statusView addGestureRecognizer:tap];
    [self addSubview:_statusView];
    
    _height += DITX*2+50+commentLabelHeight+10+70;
    _statusView.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1];
    
    _allView.frame = CGRectMake(0, 0, SCREEN_WIDTH, _height);
    
//    _line.frame = CGRectMake(0, _height, SCREEN_WIDTH, 10);
   
}

#pragma mark - 置空cell的contentView
-(void)setContentViewNULL
{
    //重用cell时候，会重复加入_statusView
    [_statusView removeFromSuperview];
    [_replyView removeFromSuperview];
}



#pragma mark - 点击跳转到单条微博页面方法
-(void)statusViewTap:(id)sender
{
    NSLog(@"微博View被点击");
    [self.delegate statusViewClicked: self.comment.status];
}

#pragma mark - 点击评论中的特殊字符时要处理的方法（微博名，网站链接，话题等）
-(void)weiBoLabel:(LRWWeiBoLabel *)label didClickText:(LRWStringAndRangAndType *)srt
{
#warning 这里需要处理微博点击链接，用户名，话题等处理方法
    NSLog(@"%@",srt.string);
}

#pragma mark - 来源字符处理
-(NSString*)sourceHandle:(NSString*)string
{
    NSRange range1 = [string rangeOfString:@">"];
//     NSLog(@"%ld",range1.location);
    NSRange other = range1;
    other.length = string.length - range1.location;
    NSRange range2 = [string rangeOfString:@"<" options:NSCaseInsensitiveSearch range:other];
//    NSLog(@"%ld",range2.location);
    
    NSRange sourceRange = range1;
    sourceRange.location += 1;
    sourceRange.length = range2.location - range1.location-1;
//    NSLog(@"%@",[string substringWithRange:sourceRange]);
    NSString* source = [NSString stringWithFormat:@"来自%@",[string substringWithRange:sourceRange]];
//    NSLog(@"%@",source);
    return source;
}


@end







































