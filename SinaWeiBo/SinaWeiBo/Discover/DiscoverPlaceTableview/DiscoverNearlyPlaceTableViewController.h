//
//  DiscoverNearlyPlaceTableViewController.h
//  WBTest
//
//  Created by mjx on 15/2/9.
//  Copyright (c) 2015年 MJX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlaceRequest.h"
@interface DiscoverNearlyPlaceTableViewController : UITableViewController<PlaceRequestDelegate>
@property (nonatomic, strong)NSString *lat;
@property (nonatomic, strong)NSString *Long;
@end
