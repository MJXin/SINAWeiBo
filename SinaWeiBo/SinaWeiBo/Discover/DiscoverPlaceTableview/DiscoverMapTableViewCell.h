//
//  DiscoverMapTableViewCell.h
//  SinaWeiBo
//
//  Created by mjx on 15/2/9.
//  Copyright (c) 2015年 LMZ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
@interface DiscoverMapTableViewCell : UITableViewCell<CLLocationManagerDelegate,MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet UIStepper *stepper;
@property (weak, nonatomic) IBOutlet MKMapView *map;
@property (nonatomic, strong)CLLocationManager *locationManager;
@property (nonatomic, strong)NSString *lat;
@property (nonatomic, strong)NSString *Long;
@end
