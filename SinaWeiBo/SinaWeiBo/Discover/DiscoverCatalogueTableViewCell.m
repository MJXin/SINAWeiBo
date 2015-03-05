//
//  DoscpverCatalogueTableViewCell.m
//  WBTest
//
//  Created by mjx on 15/2/5.
//  Copyright (c) 2015年 MJX. All rights reserved.
//

#import "DiscoverCatalogueTableViewCell.h"

@implementation DiscoverCatalogueTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    return [[NSBundle mainBundle] loadNibNamed:@"DiscoverCatalogueTableViewCell" owner:nil options:nil].firstObject;

}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
