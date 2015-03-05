//
//  LRWTabBar.h
//  28-Lottery
//
//  Created by lrw on 14/11/13.
//  Copyright (c) 2014年 LRW. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LRWImageTabBar;

@protocol LRWImageTabBarDelegate<NSObject>
@optional
/**
 *  按钮被点击
 *
 *  @param tabBar LRWTabBar
 *  @param from   原来被选中的按钮索引
 *  @param to     当前备选中得按钮索引
 */
- (void)lrw_tabBar:(LRWImageTabBar *)tabBar tabBarButtonIndexFrom:(NSInteger)from to:(NSInteger)to;
@end

@interface LRWImageTabBar : UIView
@property (nonatomic , weak) id<LRWImageTabBarDelegate> delegate;
/**
 *  添加一个按钮
 *
 *  @param name    普通状态下图片名称(如:icon.png)
 *  @param selName 选择后的图片名称
 */
- (void)lrw_addTabBarButtonNormalImageName:(NSString *)name selectedImageName:(NSString *)selName;
- (void)lrw_addTabBarButtonNormalBackgroundImageName:(NSString *)name selectedBackgroundImageName:(NSString *)selName;
/**
 *  选中下标为index的按钮 defalut index = 0
 */
- (void)lrw_selectTabBatButtonAtIndex:(int)index;

/**
 *  显示红点 indexs:按钮下标数组(NSValue对象)，0开始，没有在数组里面的按钮下标将不显示红点
 */
- (void)lrw_showRedPointAtIndexs:(NSArray *)indexs;
@end
