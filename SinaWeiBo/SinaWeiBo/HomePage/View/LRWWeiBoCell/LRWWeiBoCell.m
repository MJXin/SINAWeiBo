//
//  LRWWeiBoCell.m
//  微博SDK测试
//
//  Created by lrw on 15/1/20.
//  Copyright (c) 2015年 LRW. All rights reserved.
//

#import "LRWWeiBoCell.h"
#import "LRWWeiBoContentView.h"
#import "Statu.h"
#import "User.h"
@interface LRWWeiBoCell()<LRWWeiBoContentViewDelegate>
@end
@implementation LRWWeiBoCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"wei_bo_cell";
    //获得cell
    LRWWeiBoCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[LRWWeiBoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        LRWWeiBoContentView *contentView = [LRWWeiBoContentView new];
        contentView.delegate = cell;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        contentView.frame = CGRectMake(0, 0, cell.contentView.bounds.size.width, cell.contentView.bounds.size.height - 10);
        cell.weiboContentView = contentView;
        cell.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0];
        [cell.contentView addSubview:contentView];
        
    }
    return cell;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}
#pragma mark - contentView 代理方法
- (void)weiBoContetnView:(LRWWeiBoContentView *)weiBoContentView didClickText:(LRWStringAndRangAndType *)srt
{
    if ([self.delegate respondsToSelector:@selector(weiBoCell:didClickText:)]) {
        [self.delegate weiBoCell:self didClickText:srt];
    }
}

- (void)weiBoContetnView:(LRWWeiBoContentView *)weiBoContentView didClickImageAtIndex:(NSInteger)index defaultImages:(NSArray *)defaultImages bmiddleImagesURL:(NSArray *)bmiddleImagesURL goodNumber:(NSString *)goodNumber
{
    if ([self.delegate respondsToSelector:@selector(weiBoCell:didClickImageAtIndex:defaultImages:bmiddleImagesURL:goodNmuber:)]) {
        [self.delegate weiBoCell:self didClickImageAtIndex:index defaultImages:defaultImages bmiddleImagesURL:bmiddleImagesURL goodNmuber:goodNumber];
    }
}

- (void)weiBoContetnView:(LRWWeiBoContentView *)weiBoContentView didClickScreenName:(Statu *)statu
{
    [self.delegate weiBoCell:self didClickUserName:_weiboContentView.status.user];
}

- (void)weiBoContetnView:(LRWWeiBoContentView *)weiBoContentView didClickToolBarItemAtIndex:(NSInteger)index
{
    if ([self.delegate respondsToSelector:@selector(weiBoCell:didClickToolBarItemAtIndex:)]) {
        [self.delegate weiBoCell:self didClickToolBarItemAtIndex:index];
    }
}

- (void)weiBoContetnView:(LRWWeiBoContentView *)weiBoContentView didClickContent:(Statu *)statu
{
    if ([self.delegate respondsToSelector:@selector(weiBoCell:didClickCell:)])
    {
        [self.delegate weiBoCell:self didClickCell:statu];
    }
}
@end
