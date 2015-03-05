//
//  LRWWeiBoImageViewController.h
//  图片控制器
//
//  Created by ibokan on 15-1-20.
//  Copyright (c) 2015年 SX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LRWWeiBoImageViewController : UIViewController
- (instancetype)initWithLoadImageWithURL:(NSString *)url defaultImage:(UIImage *)image;
- (void)loadImageWithURL:(NSString *)url defaultImage:(UIImage *)image;
/**开始加载图片*/
- (void)startTheDownload;
/**暂停下载图片*/
- (void)pauseTheDownLoad;

@property (nonatomic, assign) UIViewContentMode imageContentMode;
@end
