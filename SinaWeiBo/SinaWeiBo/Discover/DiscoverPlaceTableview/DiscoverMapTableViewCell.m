//
//  DiscoverMapTableViewCell.m
//  SinaWeiBo
//
//  Created by mjx on 15/2/9.
//  Copyright (c) 2015年 LMZ. All rights reserved.
//

#import "DiscoverMapTableViewCell.h"

@implementation DiscoverMapTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [[NSBundle mainBundle] loadNibNamed:@"DiscoverMapTableViewCell" owner:nil options:nil].firstObject;
    return self;
}
- (IBAction)zoom:(UIStepper *)sender {
    CLLocationCoordinate2D center = {[self.lat doubleValue],[self.Long doubleValue]};
    center = self.map.centerCoordinate;
    MKCoordinateSpan span;
    span.latitudeDelta = sender.value;
    span.longitudeDelta = sender.value;
    MKCoordinateRegion region = {center,span};
    [self.map setRegion:region animated:YES];
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
