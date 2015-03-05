//
//  LRWWeiBoShowImageController.h
//  图片控制器
//
//  Created by ibokan on 15-1-20.
//  Copyright (c) 2015年 SX. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Statu;
@interface LRWWeiBoShowImageController : UIViewController
@property (nonatomic, assign) NSInteger selectIndex;
@property (nonatomic, strong) NSArray *defaultImages;
@property (nonatomic, strong) NSArray *imagesURL;
@property (nonatomic, copy) NSString *goodNumber;
/**创建一个只用来浏览图片的图片控制器*/
- (instancetype)initWithSelectIndex:(NSInteger)selectIndex goodNumber:(NSString *)goodNmuber defaultImages:(NSArray *)defaultImages imagesURL:(NSArray *)imagesURL;
/**创建只有一张图片并且可以跳转到评论的图片控制器*/
- (instancetype)initWithStatu:(Statu *)statu image:(UIImage *)image url:(NSString *)url;
- (void)showShadow;
- (void)hideShadow;
@end
