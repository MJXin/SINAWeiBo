//
//  DiscoverMapTableViewController.h
//  SinaWeiBo
//
//  Created by mjx on 15/2/9.
//  Copyright (c) 2015年 LMZ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "KCAnnotation.h"
#import "PlaceRequest.h"
@interface DiscoverMapTableViewController : UITableViewController<CLLocationManagerDelegate,MKMapViewDelegate,PlaceRequestDelegate>
//周围的图片
@property (nonatomic, strong)NSArray *photoStatus;
//周围的人以及热门微博显示信息
@property (nonatomic, strong)NSArray *status;
@property (nonatomic, strong)NSArray *users;
@property (nonatomic, strong)NSArray *pois;
@property (nonatomic, strong)NSString *Long;
@property (nonatomic, strong)NSString *lat;

@end
