//
//  LRWWeiBoImageToStatu.h
//  微博SDK测试
//
//  Created by lrw on 15/2/2.
//  Copyright (c) 2015年 LRW. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Statu;
@interface LRWWeiBoImageToStatu : NSObject
/**图片来源的微博*/
@property (nonatomic, strong) Statu *statu;
/**图片缩略图地址*/
@property (nonatomic, copy) NSString *url;
+ (instancetype)image:(NSString *)url statu:(Statu *)statu;
@end
