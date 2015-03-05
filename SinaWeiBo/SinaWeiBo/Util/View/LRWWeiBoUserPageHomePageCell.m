//
//  LRWWeiBoUserPageHomePageCell.m
//  微博SDK测试
//
//  Created by lrw on 15/2/2.
//  Copyright (c) 2015年 LRW. All rights reserved.
//

#import "LRWWeiBoUserPageHomePageCell.h"

@implementation LRWWeiBoUserPageHomePageCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [[[NSBundle mainBundle] loadNibNamed:@"LRWWeiBoUserPageHomePageCell" owner:nil options:nil] firstObject];
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
