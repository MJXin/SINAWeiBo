//
//  UIImageView+GIF.m
//  类目
//
//  Created by lrw on 15/1/21.
//  Copyright (c) 2015年 LRW. All rights reserved.
//

#import "UIImageView+GIF.h"

@implementation UIImageView (GIF)
- (void)showGIFWithData:(NSData *)imageData replace:(BOOL)replace
{
    self.animationImages = nil;
    CGImageSourceRef imageSource = CGImageSourceCreateWithData((CFDataRef)imageData, NULL);
    size_t imageCount = CGImageSourceGetCount(imageSource);
    NSMutableArray *imagesArray = [[NSMutableArray alloc] initWithCapacity:(NSInteger)imageCount];
    NSTimeInterval totalTime = 0;
    for (NSInteger index = 0; index < imageCount; ++index) {
        CGImageRef aImageRef = CGImageSourceCreateImageAtIndex(imageSource, index, NULL);
        UIImage *aImage = [UIImage imageWithCGImage:aImageRef];
        [imagesArray addObject:aImage];
        
        NSDictionary *properties = (__bridge NSDictionary *)CGImageSourceCopyPropertiesAtIndex(imageSource, index, NULL);
        NSDictionary *gifProperties = [properties valueForKey:(__bridge NSString *)kCGImagePropertyGIFDictionary];
        NSString *gifDelayTime = [gifProperties valueForKey:(__bridge NSString* )kCGImagePropertyGIFDelayTime];
        totalTime += [gifDelayTime floatValue];
    }
    self.animationImages = imagesArray;
    self.animationDuration = totalTime;
    if (replace) {
        self.animationRepeatCount = 0;
    }
    else
    {
        self.animationRepeatCount = 1;
    }
    [self startAnimating];
}
@end
