//
//  LRWEmojiKeyboardController.h
//  SinaWeiBo
//
//  Created by lrw on 15/2/10.
//  Copyright (c) 2015年 LMZ. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol LRWEmojiKeyboardControllerDelegate;
@interface LRWEmojiKeyboardController : UIViewController
@property (nonatomic, assign) id<LRWEmojiKeyboardControllerDelegate> delegate;
@end

@protocol LRWEmojiKeyboardControllerDelegate <NSObject>
- (void)emojiKeyboardController:(LRWEmojiKeyboardController*)controller eomjiClick:(NSString *)emoji;
- (void)emojiKeyboardControllerDidClose:(LRWEmojiKeyboardController*)controller;
@end