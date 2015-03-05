//
//  UIImage+ImageCache.m
//  sinaWeiboDemo1
//
//  Created by William-zhang on 15/1/27.
//  Copyright (c) 2015年 William-zhang. All rights reserved.
//

#import "UIImage+ImageCache.h"

@implementation UIImage (ImageCache)

+(UIImage*)imageWithURL:(NSString *)url
{
    UIImage* img;
    NSString* tmpPath = NSTemporaryDirectory();
    NSString* imgName = [[url stringByAppendingString:@".png"] stringByReplacingOccurrencesOfString:@"/" withString:@"-"];
    NSString* imgPath = [tmpPath stringByAppendingPathComponent:imgName];
    img = [UIImage imageNamed:imgPath];
   
    if(img == nil)
    {
        NSURL* imgUrl = [[NSURL alloc]initWithString:url];
        NSData* data = [NSData dataWithContentsOfURL:imgUrl];
        img = [UIImage imageWithData:data];
        BOOL result = [data writeToFile:imgPath atomically:NO];
        NSLog(@"%@",imgPath);
//        if (result) {
//            NSLog(@"文件缓存到本地成功");
//        }
//        NSLog(@"网络请求");
        
    }
//    else
//    {
//        NSLog(@"使用本地缓存");
//    }
    return img;
}

@end
