//
//  UIView+LRWLazy.h
//  16-QQ好友
//
//  Created by lrw on 14-9-24.
//  Copyright (c) 2014年 LRW. All rights reserved.
//

#import <UIKit/UIKit.h>
//输入角度，获取弧度
#define Angle(x) (x * M_PI / 180)

#define RECT_MaxX(r)  CGRectGetMaxX(r)
#define RECT_MaxY(r)  CGRectGetMaxY(r)
#define RECT_MinX(r)  CGRectGetMinX(r)
#define RECT_MinY(r)  CGRectGetMinY(r)
#define RECT_Height(r)  CGRectGetHeight(r)
#define RECT_Width(r)  CGRectGetWidth(r)
/**
 *  CGRectMake
 *
 *  @param x      x
 *  @param y      y
 *  @param width  width
 *  @param height height
 *
 *  @return CGREct
 */
#define RECT(x,y,width,height) CGRectMake(x, y, width, height)
/**
 *  CGPointMake
 *
 *  @param x x
 *  @param y y
 *
 *  @return CGPoint
 */
#define POINT(x,y) CGPointMake(x,y)
/**
 *  CGSizeMake
 *
 *  @param width  width
 *  @param height height
 *
 *  @return CGSize
 */
#define SIZE(width,height) CGSizeMake(width,height)

@interface UIView (LRW)

/**
 *  获得frame的x
 */
-(CGFloat)frameX;
-(void)setFrameX:(CGFloat)aX;

/**
 *  获得frame的y
 */
-(CGFloat)frameY;
-(void)setFrameY:(CGFloat)ay;

/**
 *  获得frame的height
 */
-(CGFloat)frameHeight;
-(void)setFrameHeight:(CGFloat)aheight;

/**
 *  获得frame的width
 */
-(CGFloat)frameWidth;
-(void)setFrameWidth:(CGFloat)awidth;

/**
 *  获取文本显示区域
 *
 *  @param maxSize 显示最大区域
 *  @param text    文本
 *  @param font    文本字体
 *
 *  @return 文本的显示区域，CGsize
 */
+(CGSize)lrw_getTextSizeWithMaxSize:(CGSize)maxSize Text:(NSString *)text Font:(UIFont *)font;


-(void)lrw_addCAKeyframeAnimationWithKeyPath:(NSString *)keypath Duration:(CGFloat)duration Values:(NSArray *)valuse RepeatCount:(NSInteger)repeatCount Autoreverses:(BOOL)autoreverses AnimationKey:(NSString *)key;
@end
