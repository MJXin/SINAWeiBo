//
//  LRWPhotoAlbumViewController.h
//  获取系统所有图片
//
//  Created by lrw on 15/2/6.
//  Copyright (c) 2015年 LRW. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol LRWPhotoAlbumViewControllerDelegate;
@interface LRWPhotoAlbumViewController : UIViewController
@property (nonatomic , weak) id<LRWPhotoAlbumViewControllerDelegate> delegate;
@end

@protocol LRWPhotoAlbumViewControllerDelegate <NSObject>
@optional
/**点击下一步按钮会触发*/
- (void)photoAlbumViewController:(LRWPhotoAlbumViewController *)controller didClickNextBtnImages:(NSArray *)images;
/**点击取消按钮会触发*/
- (void)photoAlbumViewControllerDidClickCancelBtn:(LRWPhotoAlbumViewController *)controller;

@end