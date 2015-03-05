//
//  LRWWeiBoLoadingView.h
//  图片控制器
//
//  Created by ibokan on 15-1-20.
//  Copyright (c) 2015年 SX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LRWWeiBoLoadingView : UIView
/** 显示比例 0~1*/
@property(nonatomic ,assign) CGFloat proporition;
- (void)beginAnimation;
- (void)endAnimation;
@end
