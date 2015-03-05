//
//  LRWWeiBoEmoji.m
//  微博label设置
//
//  Created by lrw on 15/1/14.
//  Copyright (c) 2015年 LRW. All rights reserved.
//

#import "LRWWeiBoEmoji.h"

@implementation LRWWeiBoEmoji
@synthesize allEmojis = _allEmojis;
static id _emoji;
+ (instancetype)defaultEmoji
{
    @synchronized(self)
    {
        if (!_emoji) {
            _emoji = [[self alloc] init];
        }
    }
    return _emoji;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    @synchronized(self)
    {
        if (!_emoji) {
            _emoji = [super allocWithZone:zone];
        }
    }
    return _emoji;
}

+ (id)copyWithZone:(struct _NSZone *)zone
{
    return _emoji;
}

- (NSDictionary *)allEmojis
{
    if (!_allEmojis) {
        _allEmojis = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"expressionImage_custom" ofType:@"plist"]];
    }
    return _allEmojis;
}
@end
