//
//  UIImage+ImageCache.h
//  sinaWeiboDemo1
//
//  Created by William-zhang on 15/1/27.
//  Copyright (c) 2015年 William-zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ImageCache)

/**图片下载后缓存到tmp文件夹下
 */
+(UIImage*)imageWithURL:(NSString*)url;

/**把图片变成一个方形图片
 */
-(UIImage*)imageTurnRect;

@end
