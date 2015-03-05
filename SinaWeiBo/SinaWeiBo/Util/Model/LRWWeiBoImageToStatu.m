//
//  LRWWeiBoImageToStatu.m
//  微博SDK测试
//
//  Created by lrw on 15/2/2.
//  Copyright (c) 2015年 LRW. All rights reserved.
//

#import "LRWWeiBoImageToStatu.h"

@implementation LRWWeiBoImageToStatu
+ (instancetype)image:(NSString *)url statu:(Statu *)statu
{
    LRWWeiBoImageToStatu *its = [LRWWeiBoImageToStatu new];
    its.url = url;
    its.statu = statu;
    return its;
}
@end
