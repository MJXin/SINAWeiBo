//
//  LRWWeiBoKeyBoardToolBar.m
//  微博SDK测试
//
//  Created by lrw on 15/2/4.
//  Copyright (c) 2015年 LRW. All rights reserved.
//

#import "LRWWeiBoKeyBoardToolBar.h"
#import "LRWEmojiKeyboardController.h"
@interface LRWWeiBoKeyBoardToolBar()<LRWEmojiKeyboardControllerDelegate>
{
    UIView *_keyBoardEmojiView;
    CGRect _keyBoardEmojiViewFrame;
    LRWEmojiKeyboardController *_emojiController;
    UIButton *_emojiBtn;
}
- (IBAction)atBtnClick:(UIButton *)sender;
- (IBAction)topicBtnClick:(UIButton *)sender;
- (IBAction)emojiBtnClick:(UIButton *)sender;
- (IBAction)pictureBtnClick:(id)sender;

@end
@implementation LRWWeiBoKeyBoardToolBar
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [[NSBundle mainBundle] loadNibNamed:@"LRWWeiBoKeyBoardToolBar" owner:nil options:nil].firstObject;
    self.frame = frame;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillAppear:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidChangeFrame:) name:UIKeyboardDidChangeFrameNotification object:nil];
    
    return self;
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
#pragma mark - 键盘将要弹出方法
- (void)keyboardWillAppear:(NSNotification *)notification
{
    NSArray *windows =  [[UIApplication sharedApplication] windows];
    _emojiController = [LRWEmojiKeyboardController new];
    _emojiController.delegate = self;
    _keyBoardEmojiView = _emojiController.view;
    _keyBoardEmojiView.hidden = YES;
    _keyBoardEmojiView.backgroundColor = [UIColor whiteColor];
    [windows.lastObject addSubview:_keyBoardEmojiView];
}
- (void)keyboardWillHide:(NSNotification *)notification
{
    [_keyBoardEmojiView removeFromSuperview];
    _keyBoardEmojiView = nil;
}
- (void)keyboardDidChangeFrame:(NSNotification *)notification
{
    _keyBoardEmojiView.frame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
}
- (UIView *)createKeyboardEmojiView
{
    UIView *view = [[UIView alloc] initWithFrame:_keyBoardEmojiViewFrame];
    view.backgroundColor = [UIColor orangeColor];
    return view;
}


- (IBAction)atBtnClick:(id)sender {
    [self btnClickAtIndex:0];
}

- (IBAction)topicBtnClick:(UIButton *)sender {
    [self btnClickAtIndex:1];
}

static bool isShowEmojiIcon = YES;
- (IBAction)emojiBtnClick:(UIButton *)sender {
    isShowEmojiIcon = !isShowEmojiIcon;
    if (!_emojiBtn) {
        _emojiBtn = sender;
    }
    NSString *normalImageName;
    NSString *highlightedImageName;
    if (isShowEmojiIcon) {
        normalImageName = @"message_emotion_background";
        highlightedImageName = @"message_emotion_background_highlighted";
        _keyBoardEmojiView.hidden = YES;
    }
    else
    {
        normalImageName = @"message_keyboard_background";
        highlightedImageName = @"message_keyboard_background_highlighted";
        _keyBoardEmojiView.hidden = NO;
    }
    [sender setImage:[UIImage imageNamed:normalImageName] forState:(UIControlStateNormal)];
    [sender setImage:[UIImage imageNamed:highlightedImageName] forState:(UIControlStateHighlighted)];
    [self btnClickAtIndex:2];
}

- (IBAction)pictureBtnClick:(id)sender {
    [self btnClickAtIndex:3];
}

- (void)btnClickAtIndex:(NSInteger)index
{
    if (index != 2) {
        [_emojiBtn setImage:[UIImage imageNamed:@"message_emotion_background"] forState:(UIControlStateNormal)];
        [_emojiBtn setImage:[UIImage imageNamed:@"message_emotion_background_highlighted"] forState:(UIControlStateHighlighted)];
        _keyBoardEmojiView.hidden = YES;
        isShowEmojiIcon = YES;
    }
    if ([self.delegateToWeiBoKeyBoardToolBar respondsToSelector:@selector(weiBoKeyBoardToolBar:didClickItem:isShowEmojiIcon:)]) {
        [self.delegateToWeiBoKeyBoardToolBar weiBoKeyBoardToolBar:self didClickItem:index isShowEmojiIcon:isShowEmojiIcon];
    }
}

#pragma mark - 表情键盘代理方法
- (void)emojiKeyboardControllerDidClose:(LRWEmojiKeyboardController *)controller
{
    if ([self.delegateToWeiBoKeyBoardToolBar respondsToSelector:@selector(weiBoKeyBoardToolBarDidClickDeleteBtn:)]) {
        [self.delegateToWeiBoKeyBoardToolBar weiBoKeyBoardToolBarDidClickDeleteBtn:self ];
    }
}

- (void)emojiKeyboardController:(LRWEmojiKeyboardController *)controller eomjiClick:(NSString *)emoji
{
    if ([self.delegateToWeiBoKeyBoardToolBar respondsToSelector:@selector(weiBoKeyBoardToolBar:didClickEmoji:)]) {
        [self.delegateToWeiBoKeyBoardToolBar weiBoKeyBoardToolBar:self didClickEmoji:emoji];
    }
}

@end
