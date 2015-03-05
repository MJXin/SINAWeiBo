//
//  LRWPhotoAlbumCell.h
//  获取系统所有图片
//
//  Created by lrw on 15/2/6.
//  Copyright (c) 2015年 LRW. All rights reserved.
//

#import <UIKit/UIKit.h>
#define IMAGEKEY @"image"
#define SELECTEDKEY @"isSelected"
@interface LRWPhotoAlbumCell : UICollectionViewCell
@property (nonatomic, assign) BOOL chosed;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic, assign, readonly) BOOL isAnimating;
@end
