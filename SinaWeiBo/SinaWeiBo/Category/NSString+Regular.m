//
//  NSString+Regular.m
//  微博SDK测试
//
//  Created by lrw on 14/12/30.
//  Copyright (c) 2014年 LRW. All rights reserved.
//

#import "NSString+Regular.h"

@implementation NSString (Regular)
-(NSMutableArray *)substringByRegular:(NSString *)regular{
    
    NSString * reg=regular;
    
    NSRange r= [self rangeOfString:reg options:NSRegularExpressionSearch];
    
    NSMutableArray *arr=[NSMutableArray array];
    
    if (r.length != NSNotFound &&r.length != 0) {
        
//        int i=0;
        
        while (r.length != NSNotFound &&r.length != 0) {
            
//            FCLOG(@"index = %i regIndex = %d loc = %d",(++i),r.length,r.location);
            
            NSString* substr = [self substringWithRange:r];
            
//            FCLOG(@"substr = %@",substr);
            
            [arr addObject:substr];
            
            NSRange startr=NSMakeRange(r.location+r.length, [self length]-r.location-r.length);
            
            r=[self rangeOfString:reg options:NSRegularExpressionSearch range:startr];
        }
    }
    return arr;
}



@end
