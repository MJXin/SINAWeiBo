//
//  UICheckBox.m
//  sinaWeiboDemo1
//
//  Created by William-zhang on 15/1/28.
//  Copyright (c) 2015年 William-zhang. All rights reserved.
//

#import "UICheckBox.h"

@interface UICheckBox ()
{
    UIButton* _checkBox;
    UILabel* _checkLabel;
    CGFloat _disY;
}
@end

@implementation UICheckBox

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _selected = NO;
        CGRect f = frame;
        _boxWidth = 20;
        _disY = (f.size.height - _boxWidth)/2;
        _checkBox = [[UIButton alloc]initWithFrame:CGRectMake(0, _disY, _boxWidth, _boxWidth)];
//        _checkBox.backgroundColor = [UIColor clearColor];
//        _checkBox.layer.borderWidth = 1;
//        _checkBox.layer.borderColor = [UIColor lightGrayColor].CGColor;
//        [_checkBox setTitleColor:[UIColor cyanColor] forState:UIControlStateNormal];
        [_checkBox setImage:[UIImage imageNamed:@"wl_common_checkbox_unchecked"] forState:UIControlStateNormal];
        [_checkBox addTarget:self action:@selector(SelectedAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_checkBox];
        
        _distance = 10;
        _checkLabel = [[UILabel alloc]initWithFrame:CGRectMake(_boxWidth+_distance, 0, f.size.width - (_boxWidth+_distance), f.size.height)];
        [self addSubview:_checkLabel];
    }
    return self;
}

-(void)SelectedAction
{
    self.selected = !_selected;
}

-(void)setText:(NSString *)text
{
    _text = text;
    _checkLabel.text = text;
}

-(void)setFont:(UIFont *)font
{
    _font = font;
    _checkLabel.font = font;
}

-(void)setBoxWidth:(CGFloat)boxWidth
{
    _boxWidth = boxWidth;
    CGRect f = _checkBox.frame;
    _disY = (self.frame.size.height - boxWidth)/2;
    f.origin.y = _disY;
    f.size.width = boxWidth;
    f.size.height = boxWidth;
    _checkBox.frame = f;
}

-(void)setBoxBorderColor:(UIColor *)boxBorderColor
{
    _boxBorderColor = boxBorderColor;
    _checkBox.layer.borderColor = boxBorderColor.CGColor;
}

-(void)setBoxBorderWidth:(CGFloat)boxBorderWidth
{
    _boxBorderWidth = boxBorderWidth;
    _checkBox.layer.borderWidth = boxBorderWidth;
}

-(void)setDistance:(CGFloat)distance
{
    _distance = distance;
    CGRect f = _checkLabel.frame;
    f.origin.x = _checkBox.frame.size.width + distance;
    _checkLabel.frame= f;
}

-(void)setSelected:(BOOL)selected
{
    _selected = selected;
    if (_selected) {
//        [_checkBox setTitle:@"√" forState:UIControlStateNormal];
        [_checkBox setImage:[UIImage imageNamed:@"wl_checkbox"] forState:UIControlStateNormal];
    }
    else
    {
//        [_checkBox setTitle:@" " forState:UIControlStateNormal];
        [_checkBox setImage:[UIImage imageNamed:@"wl_common_checkbox_unchecked"] forState:UIControlStateNormal];
    }
}

@end
