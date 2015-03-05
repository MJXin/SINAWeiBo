//
//  LRWWeiBoCell.h
//  微博SDK测试
//
//  Created by lrw on 15/1/20.
//  Copyright (c) 2015年 LRW. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LRWWeiBoLabel.h"
@class LRWWeiBoContentView,User,Statu;
@protocol LRWWeiBoCellDelegate;
@interface LRWWeiBoCell : UITableViewCell
@property (nonatomic , weak) id<LRWWeiBoCellDelegate> delegate;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property (nonatomic , weak) LRWWeiBoContentView *weiboContentView;
@end


@protocol LRWWeiBoCellDelegate <NSObject>
@optional
/**点击文本内容时候调用这代理方法*/
-(void)weiBoCell:(LRWWeiBoCell *)cell didClickText:(LRWStringAndRangAndType *)srt;
/**点击用户呢称时候调用这代理方法*/
- (void)weiBoCell:(LRWWeiBoCell *)cell didClickUserName:(User *)user;
/**点击图片时候调用这代理方法*/
- (void)weiBoCell:(LRWWeiBoCell *)cell didClickImageAtIndex:(NSInteger)index defaultImages:(NSArray *)defaultImages bmiddleImagesURL:(NSArray *)bmiddleImagesURL goodNmuber:(NSString *)goodNumber;
/**点击工具条时候调用这代理方法*/
- (void)weiBoCell:(LRWWeiBoCell *)cell didClickToolBarItemAtIndex:(NSInteger)index;
/**点击整个cell时候调用这代理方法*/
- (void)weiBoCell:(LRWWeiBoCell *)cell didClickCell:(Statu *)statu;
@end