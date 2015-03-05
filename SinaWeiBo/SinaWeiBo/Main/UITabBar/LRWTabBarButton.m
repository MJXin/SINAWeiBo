//
//  LRWTabBarButton.m
//  28-Lottery
//
//  Created by lrw on 14/11/13.
//  Copyright (c) 2014年 LRW. All rights reserved.
//

#import "LRWTabBarButton.h"

@implementation LRWTabBarButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setTitleColor:[UIColor orangeColor] forState:(UIControlStateNormal)];
    }
    return self;
}

/**
 *  重写这个方法不做任何事情，点击按钮就不会闪一下(进入highlight状态,这方法会处理很多事情)
 */
-(void)setHighlighted:(BOOL)highlighted
{
}

/**是否显示红点*/
- (void)setShowRedPoint:(BOOL)showRedPoint
{
    _showRedPoint = showRedPoint;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    if (_showRedPoint) {
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        [[UIColor redColor] set];
        CGFloat margin = 15;
        CGFloat w = 7;
        CGFloat x = CGRectGetMaxX(rect) - margin * 1.8;
        CGFloat y = 0 + margin;
        CGContextFillEllipseInRect(ctx, CGRectMake(x , y, w , w));
    }
}
@end
