//
//  NSString+Date.h
//  微博SDK测试
//
//  Created by lrw on 14/12/30.
//  Copyright (c) 2014年 LRW. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Date)
/**
 *  求时间差
 *
 *  @param dic 字典中带有 "created_at":"Tue May 21 10:56:45 +0800 2013"
 *
 *  @return 和当前时间差 “1分钟前” “1天前”
 */
+ (NSString *) returnUploadTime:(NSDictionary *)dic;
@end
