//
//  NSObject+PropertyListing.h
//  SQLite
//
//  Created by lrw on 14-10-18.
//  Copyright (c) 2014年 lrw. All rights reserved.
//  MJX修改版本

#import <Foundation/Foundation.h>

@interface NSObject (PropertyMethod)


/** 
 * 返回对象的所有属性名
 */
- (NSArray*)propertiesName;

/**
 * 规范化字典转属性的字典
 * 1.过滤没有属性对应key
 * 2.过滤没有值的key(字典不能set空值)
 */
- (NSMutableDictionary*)StandardizePropertyDictionary:(NSDictionary*)dict;


/**
 *将对象转换为字典
 *  @return 返回对象所有  属性 ： 值
 */
- (NSDictionary *)properties_aps;

/**
 *  返回对象所有方法
 */
-(void)printMothList;
@end
