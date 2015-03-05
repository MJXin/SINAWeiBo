//
//  LRWEmojiKeyboardController.m
//  SinaWeiBo
//
//  Created by lrw on 15/2/10.
//  Copyright (c) 2015年 LMZ. All rights reserved.
//
#define rowCount  7
#define listCount  4
#import "LRWEmojiKeyboardController.h"

@interface LRWEmojiKeyboardController ()<UIScrollViewDelegate>
{
    __weak IBOutlet UIButton *_closeBtn;
    __weak IBOutlet UIPageControl *_pageControl;
    __weak IBOutlet UIScrollView *_scrollView;
    NSDictionary *_allEmojis;
    NSMutableArray *_allView;
    UIColor *_closeBtnColor;
    UIImage *_closeImage;
}
@end

@implementation LRWEmojiKeyboardController
- (instancetype)init
{
    if (self = [super init]) {
        _closeBtnColor = [UIColor colorWithRed:1 green:0.5 blue:0.1 alpha:0];
        _closeImage = [UIImage imageNamed:@"camera_remove"];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self getData];
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    _scrollView.bounces = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - 获取表情数据
- (void )getData
{
    if (!_allEmojis) {
        _allEmojis = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"expressionImage_custom" ofType:@"plist"]];
    }
    _allView = [NSMutableArray array];
    NSInteger i;
    NSArray *allKeys = _allEmojis.allKeys;
    __block NSDictionary *tmpDic = [NSDictionary dictionaryWithDictionary:_allEmojis];
    allKeys = [allKeys sortedArrayWithOptions:NSSortConcurrent usingComparator:^NSComparisonResult(id obj1, id obj2) {
        NSString *value1 = tmpDic[obj1];
        NSString *value2 = tmpDic[obj2];
        return  [value1 compare:value2];
    }];
    for (i = 0 ; i < allKeys.count; ++ i) {
        if (i != 0 && i % (rowCount * listCount - 1) == 0) {
            UIButton *closeBtn = [self createCloseBtn];
            [_scrollView addSubview:closeBtn];
            [_allView addObject:closeBtn];
        }
        UIButton *btn = [[UIButton alloc] init];
        NSString *key = allKeys[i];
        UIImage *image = [UIImage imageNamed:_allEmojis[key]];
        [btn setBackgroundImage:image forState:(UIControlStateNormal)];
        [btn setTitle:key forState:(UIControlStateNormal)];
        [btn setTitleColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0] forState:(UIControlStateNormal)];
        [_scrollView addSubview:btn];
        [_allView addObject:btn];
        [btn addTarget:self action:@selector(emojiBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    if (i != 0 && i % (rowCount * listCount -1) != 0) {
        UIButton *closeBtn = [self createCloseBtn];
        [_scrollView addSubview:closeBtn];
        [_allView addObject:closeBtn];
    }
}

- (void)emojiBtnClick:(UIButton *)sender
{
    [self.delegate emojiKeyboardController:self eomjiClick:sender.titleLabel.text];
}
- (void)closeBtnClick:(UIButton *)sender
{
    [self.delegate emojiKeyboardControllerDidClose:self];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat w = scrollView.bounds.size.width;
    CGFloat x = scrollView.contentOffset.x;
    NSInteger page = (x + 0.5 * w) / w;
    _pageControl.currentPage = page;
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [self updateFrames];
}
- (void)updateFrames
{
    CGSize size = _scrollView.bounds.size;
    CGFloat margin = 10;
    NSInteger page = 0;
    CGFloat w = (size.width - (rowCount + 1) * margin) / rowCount;
    CGFloat h = w;
    CGFloat x;
    CGFloat y;
    NSInteger row = 0;
    NSInteger list = 0;
    for (int i = 0; i < _allView.count; i++) {
        page = i / (rowCount * listCount );
        UIView *view = _allView[i];
        row = i % rowCount;
        list = i / rowCount;
        list -= page * listCount;
        x = row * (w + margin) + margin;
        x += page * size.width;
        y = list * (h + margin) + margin;
        view.frame = CGRectMake(x, y, w, h);
        if ([(UIButton *)view backgroundImageForState:(UIControlStateNormal)] == _closeImage) {
            CGFloat closeBtnX = (rowCount - 1) * (w + margin) + margin;
            closeBtnX += page * size.width;
            CGFloat closeBtnY = (listCount -1) * (h + margin) + margin;
            view.frame = CGRectMake(closeBtnX,
                                    closeBtnY,
                                    w,
                                    h);
        }
    }
    _scrollView.contentSize = CGSizeMake((page + 1) * size.width, 0);
    _pageControl.numberOfPages = page + 1;
}

- (UIButton *)createCloseBtn
{
    UIButton *btn = [[UIButton alloc] init];
    btn.backgroundColor = _closeBtnColor;
    [btn setBackgroundImage:_closeImage forState:(UIControlStateNormal)];
    [btn addTarget:self action:@selector(closeBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
    return btn;
}
@end
