//
//  StatusView.m
//  SinaWeiBo
//
//  Created by William-zhang on 15/2/5.
//  Copyright (c) 2015年 LMZ. All rights reserved.
//

#import "StatusView.h"
#import "UIImage+ImageCache.h"
#import "Statu.h"
#import "User.h"

@interface StatusView ()
{
    //评论对应微博的缩略
    UIView* _statusView;
    //微博的缩略图，没有带图片的微博，则用微博作者的头像
    UIImageView* _statusImage;
    //微博作者名字
    UILabel* _statusUserName;
    //微博文字缩略内容
    UILabel* _statusText;
}
@end

@implementation StatusView

#pragma mark - 重写set方法
-(void)setStatu:(Statu *)statu
{
    _statu = statu;
    [self setUp];
}

#pragma mark - 初始化操作
-(void)setUp
{
//    self.layer.borderColor = [UIColor lightGrayColor].CGColor;
//    self.layer.borderWidth = 0.3;
    CGFloat height = self.frame.size.height;
    CGFloat width = self.frame.size.width;
    _statusImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, height, height)];
    _statusImage.contentMode = UIViewContentModeScaleAspectFill;
    _statusImage.contentScaleFactor = [[UIScreen mainScreen] scale];
    //    _statusImage.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    _statusImage.clipsToBounds = YES;
    
    NSString* url = _statu.user.avatar_large;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        
        UIImage* img = [UIImage imageWithURL:url];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            _statusImage.image = img;
            //            NSLog(@"用户头像加载完成");
        });
    });
    _statusUserName = [[UILabel alloc]initWithFrame:CGRectMake(height+10, 10, width-height-15, 20)];
    _statusUserName.font = [UIFont systemFontOfSize:14];
    _statusUserName.text = [NSString stringWithFormat:@"@%@",_statu.user.name];
    _statusText = [[UILabel alloc]initWithFrame:CGRectMake(height+10, 40, width-height-15, 20)];
    _statusText.font = [UIFont systemFontOfSize:14];
    _statusText.text = _statu.text;
    [self addSubview:_statusImage];
    [self addSubview:_statusText];
    [self addSubview:_statusUserName];
}

@end
