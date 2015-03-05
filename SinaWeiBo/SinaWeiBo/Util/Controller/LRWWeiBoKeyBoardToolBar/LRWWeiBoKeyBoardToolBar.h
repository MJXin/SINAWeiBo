//
//  LRWWeiBoKeyBoardToolBar.h
//  微博SDK测试
//
//  Created by lrw on 15/2/4.
//  Copyright (c) 2015年 LRW. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol LRWWeiBoKeyBoardToolBarDelegate;
@interface LRWWeiBoKeyBoardToolBar : UIToolbar
@property (nonatomic , weak) id<LRWWeiBoKeyBoardToolBarDelegate> delegateToWeiBoKeyBoardToolBar;
@end


@protocol LRWWeiBoKeyBoardToolBarDelegate <NSObject>
@optional
/**
 工具栏按钮被点击时候调用这方法
 index ： 那个按钮被点击
 isShow ： 工具栏第三个按钮是否正在显示表情图标
 */
- (void)weiBoKeyBoardToolBar:(LRWWeiBoKeyBoardToolBar *)toolBar didClickItem:(NSInteger)index isShowEmojiIcon:(BOOL)isShow;
/**
 点击表情键盘中的表情时候会触发
 */
- (void)weiBoKeyBoardToolBar:(LRWWeiBoKeyBoardToolBar *)toolBar didClickEmoji:(NSString *)emoji;
/**
 点击表情键盘中的删除按钮时候会触发
 */
- (void)weiBoKeyBoardToolBarDidClickDeleteBtn:(LRWWeiBoKeyBoardToolBar *)toolBar ;

@end