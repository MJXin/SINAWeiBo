//
//  LRWPhotoAlbumCell.m
//  获取系统所有图片
//
//  Created by lrw on 15/2/6.
//  Copyright (c) 2015年 LRW. All rights reserved.
//

#import "LRWPhotoAlbumCell.h"
@interface LRWPhotoAlbumCell()
{
    __weak IBOutlet UIImageView *_chooseImageView;
    BOOL _isSelected;
    
    __weak IBOutlet UIImageView *_shadowImage;
}

@end
@implementation LRWPhotoAlbumCell
- (void)awakeFromNib {
    _isAnimating = NO;
    _shadowImage.hidden = YES;
}


- (void)setChosed:(BOOL)chosed
{
    if (_isAnimating) {
        return;
    }
    _chosed = chosed;
    if (_chosed) {
        _chooseImageView.image = [UIImage imageNamed:@"compose_photo_preview_right"];
        _shadowImage.hidden = NO;
        CGFloat scale = 1.5;
        NSTimeInterval time = 0.25;
        _isAnimating = YES;
        [UIView animateWithDuration:time animations:^{
            _chooseImageView.frame = CGRectInset(_chooseImageView.frame, -scale, -scale);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:time animations:^{
                _chooseImageView.frame = CGRectInset(_chooseImageView.frame, scale, scale);
            } completion:^(BOOL finished) {
                _isAnimating = NO;
            }];
        }];
    }
    else
    {
        _chooseImageView.image = [UIImage imageNamed:@"compose_photo_preview_default"];
        _shadowImage.hidden = YES;
    }
}
@end
