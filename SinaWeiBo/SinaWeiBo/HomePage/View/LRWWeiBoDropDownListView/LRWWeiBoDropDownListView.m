//
//  LRWWeiBoDropDownListView.m
//  下拉列表
//
//  Created by lrw on 15/1/28.
//  Copyright (c) 2015年 LRW. All rights reserved.
//
#define MARGIN 20
#import "LRWWeiBoDropDownListView.h"
#import "LRWDropdownlistControl.h"
@interface LRWWeiBoDropDownListView()<LRWDropdownlistControlDelegate>
{
    LRWDropdownlistControl *_control;
    UIButton *_toolBar;
}
@end
@implementation LRWWeiBoDropDownListView
- (instancetype)init
{
    if (self = [super init]) {
        self.userInteractionEnabled = YES;
        self.layer.shadowColor = [UIColor blackColor].CGColor;
        self.layer.shadowOpacity = 0.5;
        self.layer.shadowOffset = CGSizeMake(0.5, 0.5);
        self.layer.shadowRadius = 1;
        
        UIImage *img = [UIImage imageNamed:@"wbddlv_background"];
        CGFloat W = img.size.width * 0.5;
        CGFloat H = img.size.height * 0.5;
        UIEdgeInsets edge = UIEdgeInsetsMake(H, W, H, W);
        self.image = [img resizableImageWithCapInsets:edge];
        _control = [LRWDropdownlistControl new];
        _control.delegate = self;
        [self addSubview:_control.view];
        
        _toolBar = [UIButton new];
        _toolBar.layer.borderWidth = 1;
        _toolBar.layer.borderColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.2].CGColor;
        _toolBar.layer.cornerRadius = 2;
        _toolBar.titleLabel.textAlignment = NSTextAlignmentCenter;
        _toolBar.titleLabel.font = [UIFont systemFontOfSize:10];
        [_toolBar setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        [_toolBar addTarget:self action:@selector(toolBarBtnClick:)
           forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:_toolBar];
        
    }
    return self;
}

- (void)updateFrames
{
    CGSize size = self.bounds.size;
    CGFloat x = MARGIN * 0.5;
    CGFloat y = MARGIN;
    CGFloat w = size.width - MARGIN;
    CGFloat h = size.height - MARGIN * 1.7 - (_showToolBar ? _toolBarHeight : 0);
    _control.view.frame = CGRectMake(x, y, w, h);
    
    CGFloat toolX = x;
    CGFloat toolY = CGRectGetMaxY(_control.view.frame);
    CGFloat toolW = size.width - MARGIN;
    CGFloat toolH = _toolBarHeight;
    _toolBar.frame = CGRectMake(toolX, toolY, toolW, toolH);
    _toolBar.hidden = !_showToolBar;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    [self updateFrames];
}

- (void)setListData:(NSArray *)listData
{
    _listData = listData;
    [_control setData:listData];
}

#pragma mark - 下拉列表控制器代理方法
- (void)dropdownlistControl:(LRWDropdownlistControl *)listControl didSelectedRowInGroup:(NSInteger)group row:(NSInteger)row
{
    #pragma mark 在这里调用代理方法
    if ([self.delegate respondsToSelector:@selector(weiboDropDownListView:didSelectedRowInGroup:row:text:)]) {
        NSDictionary *aGroup = _listData[group];
        NSArray *rows = aGroup[@"rows"];
        NSString *text = rows[row];
        [self.delegate weiboDropDownListView:self didSelectedRowInGroup:group row:row text:text];
    }
}

#pragma mark - 工具按钮被点击
- (void)toolBarBtnClick:(id)sender
{
    #pragma mark 在这里调用代理方法
    if ([self.delegate respondsToSelector:@selector(weiboDropDownListViewDidClickToolBar:)]) {
        [self.delegate weiboDropDownListViewDidClickToolBar:self];
    }
}

#pragma mark - 工具栏外观改变
- (void)setToolBarTitle:(NSString *)toolBarTitle
{
    _toolBarTitle = toolBarTitle;
    [_toolBar setTitle:toolBarTitle forState:(UIControlStateNormal)];
}

- (void)setToolBarFont:(UIFont *)toolBarFont
{
    _toolBarFont = toolBarFont;
    _toolBar.titleLabel.font = toolBarFont;
}

- (void)setToolBarHeight:(CGFloat)toolBarHeight
{
    _toolBarHeight = toolBarHeight;
    [self updateFrames];
}

- (void)setToolBarTextColor:(UIColor *)toolBarTextColor
{
    _toolBarTextColor = toolBarTextColor;
    [_toolBar setTitleColor:toolBarTextColor forState:(UIControlStateNormal)];
}

- (void)selectGroup:(NSInteger)group row:(NSInteger)row
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:group];
    [_control selectedRowInNSIndexPath:indexPath];
}

@end
