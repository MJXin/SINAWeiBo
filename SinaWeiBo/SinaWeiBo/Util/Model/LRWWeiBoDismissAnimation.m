//
//  LRWWeiBoDismissAnimation.m
//  微博SDK测试
//
//  Created by lrw on 15/1/22.
//  Copyright (c) 2015年 LRW. All rights reserved.
//

#import "LRWWeiBoDismissAnimation.h"

@implementation LRWWeiBoDismissAnimation
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.3;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    //获取从哪个控制器添加模态视图,从哪个控制器进入模态视图
    UIViewController *fromeVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    UIView *containerView = [transitionContext containerView];
    
    //添加目标控制器视图
    [containerView addSubview:toVC.view];
    [containerView sendSubviewToBack:toVC.view];
    toVC.view.frame = screenBounds;
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        fromeVC.view.transform = CGAffineTransformMakeScale(0.1, 0.1);
        fromeVC.view.alpha = 0;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}


@end
