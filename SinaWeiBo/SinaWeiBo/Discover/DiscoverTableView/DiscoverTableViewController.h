//
//  DiscoverTableViewController.h
//  WBTest
//
//  Created by mjx on 15/2/4.
//  Copyright (c) 2015年 MJX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DiscoverTableViewTrendCell.h"
#import "DiscoverTableViewImageCell.h"
#import "DiscoverUserTableViewController.h"
#import "DiscoverPlaceTableViewController.h"
#import "TrendsRequest.h"
@interface DiscoverTableViewController : UITableViewController<TrendsRequestDelegate>

@end
