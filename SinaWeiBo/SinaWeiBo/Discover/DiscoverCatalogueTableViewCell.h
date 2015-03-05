//
//  DoscpverCatalogueTableViewCell.h
//  WBTest
//
//  Created by mjx on 15/2/5.
//  Copyright (c) 2015年 MJX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DiscoverCatalogueTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *catalogImageOne;
@property (weak, nonatomic) IBOutlet UIImageView *catlogImageTwo;
@property (weak, nonatomic) IBOutlet UIImageView *catlogImageThree;
@property (weak, nonatomic) IBOutlet UIImageView *catlogImageFour;
@property (weak, nonatomic) IBOutlet UILabel *catlogLabelOne;
@property (weak, nonatomic) IBOutlet UILabel *catlogLabelTwo;
@property (weak, nonatomic) IBOutlet UILabel *catlogLabelThree;
@property (weak, nonatomic) IBOutlet UILabel *catlogLabelFour;
@property (weak, nonatomic) IBOutlet UIButton *catalogBtnOne;
@property (weak, nonatomic) IBOutlet UIButton *catalogBtnTwo;
@property (weak, nonatomic) IBOutlet UIButton *catalogBtnThree;
@property (weak, nonatomic) IBOutlet UIButton *catalogBtnFour;

@property (nonatomic, strong)NSString *lat;
@property (nonatomic, strong)NSString *Long;


@end
