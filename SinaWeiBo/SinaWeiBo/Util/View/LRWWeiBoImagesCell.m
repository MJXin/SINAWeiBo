//
//  LRWWeiBoImagesCell.m
//  微博SDK测试
//
//  Created by lrw on 15/2/2.
//  Copyright (c) 2015年 LRW. All rights reserved.
//

#import "LRWWeiBoImagesCell.h"
#import "LRWWeiBoImageToStatu.h"
#import "UIImageView+AFNetworking.h"
@interface LRWWeiBoImagesCell()
{
    NSArray *_tapArray;
}
@property (weak, nonatomic) IBOutlet UIImageView *oneImage;
@property (weak, nonatomic) IBOutlet UIImageView *twoImage;
@property (weak, nonatomic) IBOutlet UIImageView *threeImage;

@end
@implementation LRWWeiBoImagesCell
- (void)setDataArray:(NSArray *)dataArray
{
    _dataArray = dataArray;
    for (NSInteger index = 0; index < dataArray.count; ++index) {
        UIImageView *imageView = (UIImageView *)[self viewWithTag:index + 1];
        imageView.image = nil;
        [imageView setImageWithURL:[NSURL URLWithString:[(LRWWeiBoImageToStatu *)dataArray[index] url]]];
    }
    
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [[NSBundle mainBundle] loadNibNamed:@"LRWWeiBoImagesCell" owner:nil options:nil].firstObject;
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageClick:)];
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageClick:)];
    UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageClick:)];
    _tapArray = @[tap1,tap2,tap3];
    self.backgroundColor = self.backgroundColor;
    [_oneImage addGestureRecognizer:tap1];
    [_twoImage addGestureRecognizer:tap2];
    [_threeImage addGestureRecognizer:tap3];
    return self;
}

- (void)imageClick:(UIGestureRecognizer *)tap
{
    if ([self.delegate respondsToSelector:@selector(weiBoImagesCellDidClickImage:url:statu:)]) {
        LRWWeiBoImageToStatu *its = _dataArray[tap.view.tag - 1];
        UIImage *image = [(UIImageView *)tap.view image];
        if (!image) {
            image = [UIImage imageNamed:@"empty_picture"];
        }
        NSMutableString *url = [NSMutableString stringWithString:its.url];
        [url replaceOccurrencesOfString:@"thumbnail" withString:@"bmiddle" options:NSCaseInsensitiveSearch range:NSMakeRange(0, url.length)];
        [self.delegate weiBoImagesCellDidClickImage:image url:url statu:its.statu];
    }
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
