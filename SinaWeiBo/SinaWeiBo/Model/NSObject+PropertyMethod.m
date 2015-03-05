//
//  NSObject+PropertyListing.m
//  SQLite
//
//  Created by lrw on 14-10-18.
//  Copyright (c) 2014年 lrw. All rights reserved.
//  MJX修改版本

#import "NSObject+PropertyMethod.h"
//必须导入才能使用放射机制
#import <objc/runtime.h>

@implementation NSObject (PropertyMethod)

/* 获取对象的所有属性,返回一个字典 */
- (NSDictionary *)properties_aps
{
    NSMutableDictionary *props = [NSMutableDictionary dictionary];
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    for (i = 0; i<outCount; i++)
    {
        objc_property_t property = properties[i];
        const char* char_f =property_getName(property);
        NSString *propertyName = [NSString stringWithUTF8String:char_f];
        //NSLog(@"%@",propertyName);
        id propertyValue = [self valueForKey:(NSString *)propertyName];
        if (propertyValue) [props setObject:propertyValue forKey:propertyName];
    }
    free(properties);
    return props;
}
/* 获取对象的所有方法 */
-(void)printMothList
{
    unsigned int mothCout_f =0;
    Method* mothList_f = class_copyMethodList([self class],&mothCout_f);
    for(int i=0;i<mothCout_f;i++)
    {
        Method temp_f = mothList_f[i];
        IMP imp_f = method_getImplementation(temp_f);
        SEL name_f = method_getName(temp_f);
        const char* name_s =sel_getName(method_getName(temp_f));
        int arguments = method_getNumberOfArguments(temp_f);
        const char* encoding =method_getTypeEncoding(temp_f);
       // NSLog(@"方法名：%@,参数个数：%d,编码方式：%@",[NSString stringWithUTF8String:name_s],arguments,[NSString stringWithUTF8String:encoding]);
    }
    free(mothList_f);
}

/** 
 *获取对象的所有属性,返回一个数组
 */
- (NSArray*)propertiesName
{
    NSMutableArray *array =[NSMutableArray new];
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    for (i = 0; i<outCount; i++)
    {
        objc_property_t property = properties[i];
        const char* char_f =property_getName(property);
        NSString *propertyName = [NSString stringWithUTF8String:char_f];
        [array addObject:propertyName];
    }
    return array;
    
}

- (NSMutableDictionary *)StandardizePropertyDictionary:(NSDictionary *)dict
{
    
    //获取该类的所有属性,用于过滤接口中未知的key,防止字典转模型时崩溃
    NSArray *propertyNames = [self propertiesName];
    NSMutableDictionary *mDict = [NSMutableDictionary new];
    if(dict[@"id"])
    {
        [mDict setObject:dict[@"id"] forKey:@"Id"];
    }
    
    //获取所有有效属性字典
    for (NSString *propertyName in propertyNames) {
        
        //如果key没有数据直接过滤
        if (dict[propertyName])
        {
#warning 1.27修改此处逻辑错误,若后面有id出错问题,可能与此处有关
//            //id特殊处理
//            if ([propertyName isEqualToString:@"Id"]) {
//
//                
//                [mDict setObject:dict[@"id"] forKey:@"Id"];
//                
//                continue;
//            }
            
            [mDict setObject:dict[propertyName] forKey:propertyName];
        }
        
    }    
    
    return mDict;
}



@end