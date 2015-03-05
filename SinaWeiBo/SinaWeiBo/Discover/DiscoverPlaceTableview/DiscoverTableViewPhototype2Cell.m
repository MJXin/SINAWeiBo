//
//  DiscoverTableViewPhototype2Cell.m
//  WBTest
//
//  Created by mjx on 15/2/6.
//  Copyright (c) 2015年 MJX. All rights reserved.
//

#import "DiscoverTableViewPhototype2Cell.h"

@implementation DiscoverTableViewPhototype2Cell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    return [[NSBundle mainBundle] loadNibNamed:@"DiscoverTableViewPhototype2Cell" owner:nil options:nil].firstObject;
    
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
