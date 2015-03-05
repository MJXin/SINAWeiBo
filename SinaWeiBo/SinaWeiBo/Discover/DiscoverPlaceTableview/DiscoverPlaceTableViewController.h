//
//  DiscoverPlaceTableViewController.h
//  WBTest
//
//  Created by mjx on 15/2/6.
//  Copyright (c) 2015年 MJX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlaceRequest.h"
#import "StatuRequest.h"
#import "LocationRequest.h"
#import <CoreLocation/CoreLocation.h>
@interface DiscoverPlaceTableViewController : UITableViewController<PlaceRequestDelegate,StatuRequestDelegate,CLLocationManagerDelegate,LocationRequestDelegation>
//周围的图片
@property (nonatomic, strong)NSArray *photoStatus;
//周围热门微博显示信息
@property (nonatomic, strong)NSArray *status;
//周围的人
@property (nonatomic, strong)NSArray *users;

@end
