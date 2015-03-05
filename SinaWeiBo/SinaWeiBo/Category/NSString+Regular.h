//
//  NSString+Regular.h
//  微博SDK测试
//
//  Created by lrw on 14/12/30.
//  Copyright (c) 2014年 LRW. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Regular)
/**
 *  传入正则表达式，解析HTML内容，获取特定标签内容
 *
 *  @param regular 正则表达
 *
 *  @return 内容数组
 */
-(NSMutableArray *)substringByRegular:(NSString *)regular;
@end
