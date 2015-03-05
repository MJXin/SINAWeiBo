//
//  DiscoverTableViewCell.m
//  WBTest
//
//  Created by mjx on 15/2/4.
//  Copyright (c) 2015年 MJX. All rights reserved.
//

#import "DiscoverTableViewTrendCell.h"

@implementation DiscoverTableViewTrendCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self.indentationLevel = 0;
    self.indentationWidth = 0;
    return [[NSBundle mainBundle] loadNibNamed:@"DiscoverTableViewTrendCell" owner:nil options:nil].firstObject;
}
- (void)awakeFromNib {
    // Initialization code
}
- (void)drawRect:(CGRect)rect
{
    CGContextRef ref = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(ref, 0.5);
    CGContextSetRGBStrokeColor(ref, 204/255.0, 204/255.0, 204/255.0, 1);
    const CGPoint point[] = {
        CGPointMake(5, self.frame.size.height/2),
        CGPointMake(self.frame.size.width/2 -5, self.frame.size.height/2),
        CGPointMake(self.frame.size.width/2 + 5, self.frame.size.height/2),
        CGPointMake(self.frame.size.width - 5, self.frame.size.height/2),
        CGPointMake(self.frame.size.width/2, 5),
        CGPointMake(self.frame.size.width/2, self.frame.size.height/2 - 5),
        CGPointMake(self.frame.size.width/2, self.frame.size.height/2 + 5),
        CGPointMake(self.frame.size.width/2, self.frame.size.height - 5)};
    CGContextStrokeLineSegments(ref, point,8);
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
