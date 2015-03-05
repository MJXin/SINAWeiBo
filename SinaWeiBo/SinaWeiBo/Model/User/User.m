//
//  User.m
//  WBTest
//
//  Created by mjx on 15/1/19.
//  Copyright (c) 2015年 MJX. All rights reserved.
//

#import "User.h"
#import "NSObject+PropertyMethod.h"
#import "Statu.h"
@implementation User

- (User *)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        
        NSMutableDictionary *mDict = [dict mutableCopy];
        if(mDict[@"description"])
        {
            [mDict setObject:mDict[@"description"] forKey:@"Description"];
            [mDict removeObjectForKey:@"description"];
        }
        mDict = [self StandardizePropertyDictionary:mDict];
        
        //对个人信息中的微博信息从字典中取出转为对象
        if(mDict[@"status"])
        {
        Statu *statu = [[Statu alloc]initWithDict:mDict[@"status"]];
        [mDict setObject:statu forKey:@"status"];
        }
        
        [self setValuesForKeysWithDictionary:mDict];
     
    }
    return self;
   
}



@end
