//
//  KCAnnotation.h
//  SinaWeiBo
//
//  Created by mjx on 15/2/9.
//  Copyright (c) 2015年 LMZ. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <MapKit/MapKit.h>

@interface KCAnnotation : UIView<MKAnnotation>

@property (nonatomic) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;
@property (nonatomic, strong)NSURL *imageUrl;
@property (nonatomic)NSInteger tag;

@end

