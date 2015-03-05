//
//  LRWSearchTableViewCell.m
//  SinaWeiBo
//
//  Created by lrw on 15/2/9.
//  Copyright (c) 2015年 LMZ. All rights reserved.
//

#import "LRWSearchTableViewCell.h"

@implementation LRWSearchTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [[NSBundle mainBundle] loadNibNamed:@"LRWSearchTableViewCell" owner:nil options:nil].firstObject;
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
