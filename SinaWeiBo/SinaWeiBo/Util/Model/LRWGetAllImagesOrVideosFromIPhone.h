//
//  LRWGetAllImagesOrVideosFromIPhone.h
//  SinaWeiBo
//
//  Created by lrw on 15/2/5.
//  Copyright (c) 2015年 LRW. All rights reserved.
//  获取iphone所有图片和视频

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
@interface LRWGetAllImagesOrVideosFromIPhone : NSObject
/**获取相册所有图片*/
@property (nonatomic, strong) NSMutableArray *imagesArray;
- (void)getData;
@end
