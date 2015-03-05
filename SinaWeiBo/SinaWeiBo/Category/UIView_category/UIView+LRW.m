//
//  UIView+LRWLazy.m
//  16-QQ好友
//
//  Created by lrw on 14-9-24.
//  Copyright (c) 2014年 LRW. All rights reserved.
//

#import "UIView+LRW.h"
#import <QuartzCore/QuartzCore.h>
#import <Availability.h>
#import <Availability.h>

@implementation UIView (LRW)
#pragma mark UIView - frame(x,y,width,height,size)
-(CGFloat)frameX
{

    return self.frame.origin.x;
}
-(void)setFrameX:(CGFloat)aX
{
    CGRect frame = self.frame;
    frame.origin.x = aX;
    self.frame = frame;
}

-(CGFloat)frameY
{
    return self.frame.origin.y;
}
-(void)setFrameY:(CGFloat)aY
{
    CGRect frame = self.frame;
    frame.origin.y = aY;
    self.frame = frame;
}

-(CGFloat)frameWidth
{
    return self.frame.size.width;
}
-(void)setFrameWidth:(CGFloat)awidth
{
    CGRect frame = self.frame;
    frame.size.width = awidth;
    self.frame = frame;
}

-(CGFloat)frameHeight
{
    return self.frame.size.height;
}
-(void)setFrameHeight:(CGFloat)aheight
{
    CGRect frame = self.frame;
    frame.size.height = aheight;
    self.frame = frame;
}

+(CGSize)lrw_getTextSizeWithMaxSize:(CGSize)maxSize Text:(NSString *)text Font:(UIFont *)font
{
    BOOL iOS7 =  ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 7.0 );
    if (iOS7) {//iso7 以上使用这段代码
        NSDictionary *dic = @{NSFontAttributeName:font};
        return [text boundingRectWithSize:maxSize
                                  options:NSStringDrawingUsesLineFragmentOrigin
                               attributes:dic context:nil].size;
    }
    else//ios7以下使用这段代码(不包括ios7)
    {
        return [text sizeWithFont:font];
    }
    
}

#pragma mark -layer-animation


-(void)lrw_addCAKeyframeAnimationWithKeyPath:(NSString *)keypath Duration:(CGFloat)duration Values:(NSArray *)valuse RepeatCount:(NSInteger)repeatCount Autoreverses:(BOOL)autoreverses AnimationKey:(NSString *)key
{
        //帧动画
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:keypath];
    animation.duration = duration;
    animation.values = valuse;
    animation.repeatCount = repeatCount;
    animation.autoreverses = autoreverses;
    [self.layer addAnimation:animation forKey:key];
    
}
@end
