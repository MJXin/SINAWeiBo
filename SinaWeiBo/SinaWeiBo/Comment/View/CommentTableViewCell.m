//
//  CommentTableViewCell.m
//  sinaWeiboDemo1
//
//  Created by William-zhang on 15/1/26.
//  Copyright (c) 2015年 William-zhang. All rights reserved.
//

#import "CommentTableViewCell.h"
#import "Comment.h"
#import "User.h"
#import "UIImage+ImageCache.h"
#import "UILabel+ResetSize.h"
#import "NSString+HandleDate.h"

@interface CommentTableViewCell ()
{
    UILabel* _userName;
    LRWWeiBoLabel* _commentText;
    UILabel* _timeLabel;
    UIImageView* _userIcon;
    CGSize _userNameSize;
    CGSize _timeLabelSize;
    CGSize _commentTextSize;
}

@end

@implementation CommentTableViewCell

@synthesize height = _height;

#pragma mark - 重写comment的set方法
-(void)setComment:(Comment *)comment
{
//    NSLog(@"加载评论");
    _comment = comment;
    _userName.text = comment.user.name;
    _commentText.text = comment.text;
    _timeLabel.text = [comment.date dateHandle];
    _height = 35;
    _height += [_userName resetLabelWithSize:_userNameSize];
    _height += [_timeLabel resetLabelWithSize:_timeLabelSize];
    _height += [_commentText resetLabelWithSize:_commentTextSize];
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        UIImage* img = [UIImage imageWithURL:comment.user.profile_image_url];
        dispatch_async(dispatch_get_main_queue(), ^{
            _userIcon.image = img;
//            NSLog(@"用户头像加载完成");
        });
    });
//    NSLog(@"评论加载完成");
}

#pragma mark - 设置comment
-(void)setCommentBy:(Comment*)comment
{
    //    NSLog(@"加载评论");
    _comment = comment;
    _userName.text = comment.user.name;
    _commentText.text = comment.text;
    _timeLabel.text = comment.date;
    _height = 35;
    _height += [_userName resetLabelWithSize:_userNameSize];
    _height += [_timeLabel resetLabelWithSize:_timeLabelSize];
    _height += [_commentText resetLabelWithSize:_commentTextSize];
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        UIImage* img = [UIImage imageWithURL:comment.user.profile_image_url];
        dispatch_async(dispatch_get_main_queue(), ^{
            _userIcon.image = img;
            //            NSLog(@"用户头像加载完成");
        });
    });
    //    NSLog(@"评论加载完成");
}

#pragma mark - 重写初始化方法
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        //3个CGSize初始化
        _userNameSize = CGSizeMake(280, 20);
        _timeLabelSize = CGSizeMake(150, 20);
        _commentTextSize = CGSizeMake(280, 300);
        
        //用户头像View初始化
        _userIcon = [[UIImageView alloc]initWithFrame:CGRectMake(20, 10, 40, 40)];
        _userIcon.backgroundColor = [UIColor grayColor];
        
        //用户名字Label初始化
        _userName = [[UILabel alloc]initWithFrame:CGRectMake(85, 10, _userNameSize.width, _userNameSize.height)];
        _userName.font = [UIFont systemFontOfSize:14];
        
        //时间Label初始化
        _timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(85, 35, _timeLabelSize.width, _timeLabelSize.height)];
        _timeLabel.font = [UIFont systemFontOfSize:12];
        
        //评论内容Label初始化
        _commentText = [[LRWWeiBoLabel alloc]initWithFrame:CGRectMake(85, 55, _commentTextSize.width, _commentTextSize.height)];
        _commentText.atColor = [UIColor blueColor];
        _commentText.urlColor = [UIColor blueColor];
        _commentText.topicColor = [UIColor blueColor];
        _commentText.delegate = self;
        
        [self.contentView addSubview:_userIcon];
        [self.contentView addSubview:_userName];
        [self.contentView addSubview:_timeLabel];
        [self.contentView addSubview:_commentText];
        _height = 35;
    }
    return self;
}

#pragma mark - 点击评论中的特殊字符时要处理的方法（微博名，网站链接，话题等）
-(void)weiBoLabel:(LRWWeiBoLabel *)label didClickText:(LRWStringAndRangAndType *)srt
{
#warning 这里需要处理微博点击链接，用户名，话题等处理方法
    NSLog(@"%@",srt.string);
}

#pragma mark - 用户头像置空，这个方法已经不用了
/**用户头像置空
 */
-(void)setUserDefaultIcon
{
    _userIcon.image = nil;
}

//-(CGFloat)height
//{
//    return _height;
//}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



@end
