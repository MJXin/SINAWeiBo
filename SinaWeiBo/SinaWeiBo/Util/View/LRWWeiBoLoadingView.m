//
//  LRWWeiBoLoadingView.m
//  图片控制器
//
//  Created by ibokan on 15-1-20.
//  Copyright (c) 2015年 SX. All rights reserved.
//

#import "LRWWeiBoLoadingView.h"
@interface LRWWeiBoLoadingView()
{
    NSTimer *_timer;
}
@end
@implementation LRWWeiBoLoadingView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.clipsToBounds = YES;
    }
    return self;
}

- (void)setProporition:(CGFloat)proporition
{
    proporition = MAX(proporition, 0);
    proporition = MIN(proporition, 1);
    _proporition = proporition;
    [self setNeedsDisplay];
}

- (void)beginAnimation
{
#warning 在这里把timer的优先级提高，防止timer不能按时执行
    self.hidden = NO;
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(add:) userInfo:nil repeats:YES];
}

- (void)endAnimation
{
    [_timer invalidate];
    _timer = nil;
    self.hidden = YES;
}

#pragma mark - 跟新进度条
- (void)add:(id)sender
{
    self.proporition += arc4random_uniform(3) * 0.1;
    [self setNeedsDisplay];
    if (_proporition == 1) [self endAnimation];
}

- (void)drawRect:(CGRect)rect
{
    CGSize size = self.bounds.size;
    //画背景填充圆
    CGContextRef ctr = UIGraphicsGetCurrentContext();
    UIColor *bColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.6];
    [bColor set];
    CGContextFillEllipseInRect(ctr, self.bounds);
  
    //画黑色进度空心圆
    CGFloat arcRadius = size.width * 0.25;
    CGFloat arcX = size.width * 0.5 ;
    CGFloat arcY = size.height * 0.5 ;
    UIColor *aColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.5];
    [aColor set];
    CGContextSetLineWidth(ctr, size.width * 0.15);
    CGContextAddArc(ctr, arcX, arcY, arcRadius, 0, 2 * M_PI, 0);
    CGContextStrokePath(ctr);
    //画白色进度空心圆
    [[UIColor whiteColor] set];
    CGContextAddArc(ctr, arcX, arcY, arcRadius, 0, _proporition * 2 * M_PI, 0);
    CGContextStrokePath(ctr);
}


@end
