//
//  NSString+Date.m
//  微博SDK测试
//
//  Created by lrw on 14/12/30.
//  Copyright (c) 2014年 LRW. All rights reserved.
//

#import "NSString+Date.h"

@implementation NSString (Date)
+ (NSString *) returnUploadTime:(NSDictionary *)dic
{
    //Tue May 21 10:56:45 +0800 2013
    NSString *timeStr = [dic objectForKey:@"created_at"];
    if(timeStr)
    {
        NSRange rang = {4,3};
        NSString *mouth = [timeStr substringWithRange:rang];
        if ([mouth isEqualToString:@"Jan"]) {
            mouth = @"01";
        }
        else if ([mouth isEqualToString:@"Feb"]) {
             mouth = @"02";
        }
        else if ([mouth isEqualToString:@"Mar"]) {
             mouth = @"03";
        }
        else if ([mouth isEqualToString:@"Apr"]) {
             mouth = @"04";
        }
        else if ([mouth isEqualToString:@"May"]) {
             mouth = @"05";
        }
        else if ([mouth isEqualToString:@"Jun"]) {
             mouth = @"06";
        }
        else if ([mouth isEqualToString:@"Jul"]) {
             mouth = @"07";
        }
        else if ([mouth isEqualToString:@"Aug"]) {
             mouth = @"08";
        }
        else if ([mouth isEqualToString:@"Sep"]) {
             mouth = @"09";
        }
        else if ([mouth isEqualToString:@"Oct"]) {
             mouth = @"10";
        }
        else if ([mouth isEqualToString:@"Nov"]) {
             mouth = @"11";
        }
        else if ([mouth isEqualToString:@"Dec"]) {
             mouth = @"12";
        }

        
        timeStr = [timeStr substringFromIndex:8];
        timeStr = [NSString stringWithFormat:@"%@ %@",mouth,timeStr];
    }
    NSDateFormatter *date=[[NSDateFormatter alloc] init];
    [date setDateFormat:@"MM dd HH:mm:SS Z yyyy"];
    NSDate *d=[date dateFromString:timeStr];
    
    NSTimeInterval late=[d timeIntervalSince1970]*1;
    
    
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval now=[dat timeIntervalSince1970]*1;
    NSString *timeString=@"";
    
    NSTimeInterval cha=now-late;
    
    if (cha/3600<1) {
        timeString = [NSString stringWithFormat:@"%f", cha/60];
        timeString = [timeString substringToIndex:timeString.length-7];
        if ([timeString isEqualToString:@"0"]) {
            timeString = [NSString stringWithFormat:@"刚刚"];
        }
        else
        timeString=[NSString stringWithFormat:@"%@分钟前", timeString];
        
    }
    if (cha/3600>1&&cha/86400<1) {
        //        timeString = [NSString stringWithFormat:@"%f", cha/3600];
        //        timeString = [timeString substringToIndex:timeString.length-7];
        //        timeString=[NSString stringWithFormat:@"%@小时前", timeString];
        NSDateFormatter *dateformatter=[[NSDateFormatter alloc] init];
        [dateformatter setDateFormat:@"HH:mm"];
        timeString = [NSString stringWithFormat:@"昨天 %@",[dateformatter stringFromDate:d]];
    }
    if (cha/86400>1)
    {
        //        timeString = [NSString stringWithFormat:@"%f", cha/86400];
        //        timeString = [timeString substringToIndex:timeString.length-7];
        //        timeString=[NSString stringWithFormat:@"%@天前", timeString];
        NSDateFormatter *dateformatter=[[NSDateFormatter alloc] init];
        [dateformatter setDateFormat:@"YY-MM-dd HH:mm"];
        timeString = [NSString stringWithFormat:@"%@",[dateformatter stringFromDate:d]];
    }
    return timeString;
}
@end
