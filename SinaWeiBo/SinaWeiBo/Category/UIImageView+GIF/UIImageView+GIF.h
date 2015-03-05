//
//  UIImageView+GIF.h
//  类目
//
//  Created by lrw on 15/1/21.
//  Copyright (c) 2015年 LRW. All rights reserved.
//
//
//  使用此类目必须导入 ImageIO.framework
//  然后导入 ImageIO/CGImageSource.h 头文件

#import <UIKit/UIKit.h>
#import <ImageIO/ImageIO.h>
@interface UIImageView (GIF)
- (void)showGIFWithData:(NSData *)imageData replace:(BOOL)replace;
@end
