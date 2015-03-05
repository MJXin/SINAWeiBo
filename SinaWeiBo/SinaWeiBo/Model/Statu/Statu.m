//
//  Home_TimeLine.m
//  WBTest
//
//  Created by mjx on 15/1/18.
//  Copyright (c) 2015年 MJX. All rights reserved.
//

#import "Statu.h"
#import "User.h"
#import "NSString+Date.h"
@implementation Statu

- (Statu*)initWithDict:(NSDictionary*)dict
{
    if (self = [super init]) {
        
        NSMutableDictionary *mDict = [self StandardizePropertyDictionary:dict];
        
        //将微博的图片数组中所有字典提取出来,并获取url后存入新数组,将新数组作为pics_url值
        NSMutableArray *array = [NSMutableArray array];
        if (mDict[@"pic_urls"]) {
            for (NSDictionary *dic in mDict[@"pic_urls"]) {
                NSString *urlStr = dic[@"thumbnail_pic"];
                [array addObject:urlStr];
            }
            [mDict setObject:array forKey:@"pic_urls"];
        }
       
        
        //将微博的用户信息从字典转换为user对象属性
       // NSLog(@"user = %@",mDict[@"user"]);
        if(mDict[@"user"])
        {
        User *temp = [[User alloc]initWithDict:mDict[@"user"]];
        [mDict setObject:temp forKey:@"user"];
        }

        //若本微博包含地理信息,先将地理信息字典转换为对象
#warning 先不进行处理,这里的地理信息是经纬度,还有个type应该指传过来的值类型,目前只知道经纬度要调用另一个接口申请地理位置

         // NSLog(@"%@",mDict[@"geo"]);
        if(mDict[@"geo"] && ![mDict[@"geo"] isKindOfClass:[NSNull class]]  )
        {
            Geo *temp = [[Geo alloc]initWithDict:mDict[@"geo"]];
            [mDict setObject:temp forKey:@"geo"];
        }
        
        //若本微博是转发微博,先将转发微博字典转换为对象
        if (mDict[@"retweeted_status"]) {
            Statu *temp = [[Statu alloc]initWithDict:mDict[@"retweeted_status"]];
            temp.is_retweeted_status = YES;
            [mDict setObject:temp forKey:@"retweeted_status"];
            
        }
        if (mDict[@"source"]&& [mDict[@"source"] length]!= 0) {
            NSString *source = mDict[@"source"];
            
            source = [source substringFromIndex:[source rangeOfString:@">"].location + 1];
            
            source = [source substringToIndex:[source rangeOfString:@"<"].location];
            
            [mDict setObject:source forKey:@"source"];
            
        }
        if (mDict[@"created_at"]) {
            NSString *created_at = [NSString returnUploadTime:mDict];
            [mDict setObject:created_at forKey:@"created_at"];
        }
        
        //将有效属性字典转换为属性
        [self setValuesForKeysWithDictionary:mDict];
        
    }
    
    return self;
}

- (NSDictionary *)dictaryValue
{
    NSMutableDictionary *mdict = [[self properties_aps] mutableCopy];
    return mdict;
}



@end
