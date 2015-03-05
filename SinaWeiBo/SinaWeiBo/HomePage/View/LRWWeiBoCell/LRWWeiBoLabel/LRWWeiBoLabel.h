//
//  LRWWeiBoLabel.h
//  微博label设置
//
//  Created by lrw on 15/1/12.
//  Copyright (c) 2015年 LRW. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol LRWWeiBoLabelDelegate;
@interface LRWWeiBoLabel : UILabel
@property (nonatomic, assign) id<LRWWeiBoLabelDelegate> delegate;
@property (nonatomic, strong) UIColor *urlColor;
@property (nonatomic, strong) UIColor *atColor;
@property (nonatomic, strong) UIColor *topicColor;
@property (nonatomic, strong) UIFont *urlFont;
@property (nonatomic, strong) UIFont *atFont;
@property (nonatomic, strong) UIFont *topicFont;
/**设置行间距*/
@property (nonatomic, assign) CGFloat lineSpace;
/**设置字体间距 默认是1.0*/
@property (nonatomic, assign) CGFloat fontSpace;
/**设置正方形表情高度 默认是 20.0*/
@property (nonatomic, assign) CGFloat iconHeight;
@end

typedef enum{
    LRWSTringType_AT,// "@"类型字符串
    LRWSTringType_URL,// url类型字符串
    LRWSTringType_TOPIC,// "#"类型字符串
    LRWSTringType_Emoji// 图标类型,
}LRWSTringType;

@interface LRWStringAndRangAndType : NSObject
/**点击的文字*/
@property (nonatomic, copy) NSString *string;//字符串
/**点击文字所在范围*/
@property (nonatomic, assign) NSRange range;//范围
/**类型*/
@property (nonatomic, assign) LRWSTringType strType;
/**点击文字的frame*/
@property (nonatomic, strong) NSMutableArray *frames;
+ string:(NSString *)string range:(NSRange)range stringType:(LRWSTringType)strType;
@end

@protocol LRWWeiBoLabelDelegate <NSObject>
@optional
- (void)weiBoLabel:(LRWWeiBoLabel*)label didClickText:(LRWStringAndRangAndType *)srt;
@end

