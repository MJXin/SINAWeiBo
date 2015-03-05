//
//  LRWWeiBoLongImageViewController.h
//  微博SDK测试
//
//  Created by lrw on 15/1/22.
//  Copyright (c) 2015年 LRW. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LRWWeiBoLongImageViewController : UIViewController
- (instancetype)initWithLoadImageWithURL:(NSString *)url defaultImage:(UIImage *)image h_w_proprtion:(CGFloat)h_w_proprtion;
- (void)loadImageWithURL:(NSString *)url defaultImage:(UIImage *)image h_w_proprtion:(CGFloat)h_w_proprtion;
/**开始加载图片*/
- (void)startTheDownload;
/**暂停下载图片*/
- (void)pauseTheDownLoad;

@property (nonatomic, assign) UIViewContentMode imageContentMode;
@end
