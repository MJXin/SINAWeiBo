//
//  LRWWeiBoPresentAnimation.m
//  微博SDK测试
//
//  Created by lrw on 15/1/22.
//  Copyright (c) 2015年 LRW. All rights reserved.
//

#import "LRWWeiBoPresentAnimation.h"

@implementation LRWWeiBoPresentAnimation
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.25;
}
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    
    //设置初始位置
    toVC.view.frame = CGRectZero;
    toVC.view.center = containerView.center;
    toVC.view.alpha = 0;
    [containerView addSubview:toVC.view];
    
    //开始动画
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        toVC.view.frame = screenBounds;
        toVC.view.alpha = 1;
    } completion:^(BOOL finished) {
        
        //通知上下文动画结束
        [transitionContext completeTransition:YES];
    }];
    
}

@end
