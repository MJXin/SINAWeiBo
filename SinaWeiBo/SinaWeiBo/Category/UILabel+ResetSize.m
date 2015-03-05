//
//  UILabel+ResetSize.m
//  sinaWeiboDemo1
//
//  Created by William-zhang on 15/1/30.
//  Copyright (c) 2015年 William-zhang. All rights reserved.
//

#import "UILabel+ResetSize.h"

@implementation UILabel (ResetSize)

#pragma mark - 设置文字后重新设置Label的高和宽,返回设置后的高度
-(CGFloat)resetLabelWithSize:(CGSize)size
{
    size = [self lrw_getTextSizeWithMaxSize:size Text:self.text Font:self.font];
    //加10为了避免出现宽度不足，导致文字显示残缺
    size.width += 10;
    [self setLabelWithSize:size];
    return size.height;
}

#pragma mark - 计算一个Label的高和宽
-(CGSize)lrw_getTextSizeWithMaxSize:(CGSize)maxSize Text:(NSString *)text Font:(UIFont *)font
{
    BOOL iOS7 =  ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 7.0 );
    if (iOS7) {//iso7 以上使用这段代码
        NSDictionary *dic = @{NSFontAttributeName:font};
        return [text boundingRectWithSize:maxSize
                                  options:NSStringDrawingUsesLineFragmentOrigin
                               attributes:dic context:nil].size;
    }
    else//ios7以下使用这段代码(不包括ios7)
    {
        return [text sizeWithFont:font];
    }
}

#pragma mark - 根据CGSize重新设置Label的高和宽
-(void)setLabelWithSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}


@end
