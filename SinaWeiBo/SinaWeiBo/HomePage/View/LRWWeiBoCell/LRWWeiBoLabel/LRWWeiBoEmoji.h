//
//  LRWWeiBoEmoji.h
//  微博label设置
//
//  Created by lrw on 15/1/14.
//  Copyright (c) 2015年 LRW. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LRWWeiBoEmoji : NSObject
+ (instancetype)defaultEmoji;
/**所有表情 {@"[***]" : @"imageName"}*/
@property (nonatomic, strong, readonly) NSDictionary *allEmojis;
@end
