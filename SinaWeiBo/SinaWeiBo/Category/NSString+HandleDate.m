//
//  NSString+HandleDate.m
//  sinaWeiboDemo1
//
//  Created by William-zhang on 15/2/2.
//  Copyright (c) 2015年 William-zhang. All rights reserved.
//

#import "NSString+HandleDate.h"

@implementation NSString (HandleDate)

/**日期处理
 */
-(NSString*)dateHandle
{
    NSArray* strs = [self componentsSeparatedByString:@" "];
    NSMutableString* date = [[NSMutableString alloc]init];

    NSDate* now = [NSDate date];
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* comp = [calendar components:NSYearCalendarUnit fromDate:now];
    if ([strs[strs.count - 1] integerValue] != [comp year]) {
        //拼接年份
        [date appendString:strs[strs.count - 1]];
        [date appendString:@"-"];

    }
       //拼接月份
    [date appendString:[self monthNumberStringBy:strs[1]]];
    //拼接日期
    [date appendString:@"-"];
    [date appendString:strs[2]];
    //拼接时分秒
    [date appendString:@" "];
    [date appendString:strs[3]];
    //NSLog(@"%@",date);
    return date;
}

/**月份字符转换成数字
 */
-(NSString*)monthNumberStringBy:(NSString*)month
{
    /*
     January（Jan．） 一月
     February(Feb.) 二月
     March 三月
     April 四月
     May 五月
     June 六月
     July 七月
     August(Aug.) 八月
     September(Sept.) 九月
     October(Oct.) 十月
     November(Nov.) 十一月
     December(Dec.) 十二月
     */
    NSArray* months = @[@"Jan",@"Feb",@"Mar",@"Apr",@"May",@"Jun",@"Jul",@"Aug",@"Sep",@"Oct",@"Nov",@"Dec"];
    int i = 1;
    for (NSString* mon in months) {
        if ([mon isEqualToString:month]) {
            break;
        }
        i++;
    }
    return [NSString stringWithFormat:@"%02d",i];
}

#pragma mark - 来源字符处理
-(NSString*)sourceHandle
{
    NSRange range1 = [self rangeOfString:@">"];
    //     NSLog(@"%ld",range1.location);
    NSRange other = range1;
    other.length = self.length - range1.location;
    NSRange range2 = [self rangeOfString:@"<" options:NSCaseInsensitiveSearch range:other];
    //    NSLog(@"%ld",range2.location);
    NSRange sourceRange = range1;
    sourceRange.location += 1;
    sourceRange.length = range2.location - range1.location-1;
    //    NSLog(@"%@",[string substringWithRange:sourceRange]);
    NSString* source = [NSString stringWithFormat:@"来自%@",[self substringWithRange:sourceRange]];
    //    NSLog(@"%@",source);
    return source;
}


@end
