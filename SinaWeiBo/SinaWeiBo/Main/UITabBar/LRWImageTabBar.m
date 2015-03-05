//
//  LRWTabBar.m
//  28-Lottery
//
//  Created by lrw on 14/11/13.
//  Copyright (c) 2014年 LRW. All rights reserved.
//

#import "LRWImageTabBar.h"
#import "LRWTabBarButton.h"
@interface LRWImageTabBar()
@property (nonatomic , weak) LRWTabBarButton *selectedBtn;
@end

@implementation LRWImageTabBar

-(void)lrw_addTabBarButtonNormalImageName:(NSString *)name selectedImageName:(NSString *)selName
{
    NSInteger count = self.subviews.count;
    LRWTabBarButton *btn = [LRWTabBarButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:name] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:selName] forState:UIControlStateSelected];
    btn.tag = count;
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
    [self addSubview:btn];
    //默认选中第一项
    if (count == 0) [self btnClick:btn];
}

- (void)lrw_addTabBarButtonNormalBackgroundImageName:(NSString *)name selectedBackgroundImageName:(NSString *)selName
{
    NSInteger count = self.subviews.count;
    LRWTabBarButton *btn = [LRWTabBarButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundImage:[UIImage imageNamed:name] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:selName] forState:UIControlStateSelected];
    btn.tag = count;
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
    [self addSubview:btn];
    //默认选中第一项
    if (count == 0) [self btnClick:btn];
}


-(void)lrw_selectTabBatButtonAtIndex:(int)index
{
    LRWTabBarButton *btn = nil;
    if (index < self.subviews.count){
        btn = self.subviews[index];
    }
    else if (self.subviews.count)
    {
        btn = self.subviews[0];
    }
    
    [self btnClick:btn];
}

/**
 *  按钮被点击
 */
- (void)btnClick:(LRWTabBarButton *)btn
{
    if ([self.delegate respondsToSelector:@selector(lrw_tabBar:tabBarButtonIndexFrom:to:)]) {
        [self.delegate lrw_tabBar:self tabBarButtonIndexFrom:self.selectedBtn.tag to:btn.tag];
    }
    //图片修改
    self.selectedBtn.selected = NO;
    self.selectedBtn = btn;
    btn.selected = YES;
}

- (void)lrw_showRedPointAtIndexs:(NSArray *)indexs
{
    for (LRWTabBarButton *btn in self.subviews) {
        if ([btn isKindOfClass:[LRWTabBarButton class]]) {
            btn.showRedPoint = NO;
        }
    }
    //NSLog(@"%@",self.subviews);
    for (NSNumber *index in indexs) {
        NSInteger tag = [index integerValue];
        if (tag == 0)
        {
            [(LRWTabBarButton *)self.subviews.firstObject setShowRedPoint:YES];
            continue;
        }
        LRWTabBarButton *btn = (LRWTabBarButton *)[self viewWithTag:tag];
        if ([btn isKindOfClass:[LRWTabBarButton class]]) {
            btn.showRedPoint = YES;
        }
    }
}

-(void)layoutSubviews
{
    NSInteger count = self.subviews.count;
    for (int i = 0; i < count; i++) {
        LRWTabBarButton *btn = self.subviews[i];
        float btnH = self.bounds.size.height;
        float btnW = self.bounds.size.width / count;
        float btnX = i * btnW;
        float btnY = 0;
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
    }
}


@end
