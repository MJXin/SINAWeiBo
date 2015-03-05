//
//  DiscoverMapTableViewController.m
//  SinaWeiBo
//
//  Created by mjx on 15/2/9.
//  Copyright (c) 2015年 LMZ. All rights reserved.
//

#import "DiscoverMapTableViewController.h"
#import "DiscoverMapTableViewCell.h"
#import "DiscoverMapOtherView.h"
#import "Statu.h"
#import "User.h"
#import "Poi.h"
#import "UIImageView+AFNetworking.h"

@interface DiscoverMapTableViewController ()
{
    DiscoverMapTableViewCell *mapCell;
    DiscoverMapOtherView *otherView;
    NSMutableArray *annotations;
    NSMutableArray *frames;
   
}
@end

@implementation DiscoverMapTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"地图搜索"];
    annotations = [NSMutableArray new];
    PlaceRequest *requset = [PlaceRequest new];
    requset.delegate = self;
    RequestPlaceParma *parma = [[RequestPlaceParma alloc]initWithAccess_token:@"2.00QQgbnC7EgnqC2605fe88a8uNtL8B"];
    parma.lat = self.lat;
    parma.Long = self.Long;
    

    parma.count = @"8";
    parma.range = @"3000";
    [requset PoisRequestByNearbyWithParma:parma];
    
  

}
-(void)PoisRequestByNearbyDidFinishedWithPois:(NSArray *)pois error:(NSError *)error
{
    if(!error)
    {
        self.pois = pois;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    mapCell = [tableView dequeueReusableCellWithIdentifier:@"map"];
    if(!mapCell)
    {
        mapCell = [[DiscoverMapTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"map"];
    }
    UIImage *imageD = [mapCell.stepper decrementImageForState:UIControlStateNormal];
    [mapCell.stepper setDecrementImage:[mapCell.stepper incrementImageForState:UIControlStateNormal] forState:UIControlStateNormal];
    [mapCell.stepper setIncrementImage:imageD forState:UIControlStateNormal];
    
    
    mapCell.locationManager = [[CLLocationManager alloc] init];
    mapCell.locationManager.delegate = self;
    mapCell.map.delegate = self;
    if ([mapCell.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [mapCell.locationManager requestWhenInUseAuthorization];
    }
    [mapCell.locationManager startUpdatingLocation];
    [mapCell.locationManager requestWhenInUseAuthorization];
    [mapCell.locationManager requestAlwaysAuthorization];
    [self addAnnotation];
    mapCell.lat = _lat;
    mapCell.Long = _Long;
    //用户位置追踪(用户位置追踪用于标记用户当前位置，此时会调用定位服务)
    mapCell.map.userTrackingMode = MKUserTrackingModeFollow;
       return mapCell;
}
#pragma mark 添加大头针
-(void)addAnnotation{
    
    frames = [NSMutableArray new];
    for (Statu *statu in self.photoStatus) {
        if (statu.geo) {
            CLLocationCoordinate2D location=CLLocationCoordinate2DMake([statu.geo.latitude doubleValue], [statu.geo.longitude doubleValue]);
            KCAnnotation *annotation=[[KCAnnotation alloc]init];
            annotation.title = statu.user.name;
            annotation.subtitle= statu.text;
            annotation.imageUrl = [NSURL URLWithString:statu.thumbnail_pic];
            annotation.coordinate=location;
            
            [annotations addObject:annotation];
        }
    }
    
    [mapCell.map addAnnotations:annotations];
}
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    if ([[annotation class] isSubclassOfClass:[MKUserLocation class]])
    {
        
        MKAnnotationView* annoView = [[MKAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"mylocation"];
        return nil;
    }
    
    KCAnnotation *temp = annotation;

    //KCAnnotation *temp = annotation;
    static NSString* annoId = @"Anno";
    // 获取可重用的锚点控件
    MKAnnotationView* annoView = [mapView dequeueReusableAnnotationViewWithIdentifier:annoId];
    // 如果可重用的锚点控件不存在，创建新的可重用锚点控件
    if (!annoView)
    {
        annoView= [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:annoId];
        
        /*
         如果不想改变锚点控件的图片，只想改变颜色，则可创建MKPinAnnotationView实例
         再修改MKPinAnnotationView对象的pinColor属性即可。
         */
    }
    
//    // 为锚点控件设置图片
//    if (temp.tag == 76501) {
//         annoView.image =[UIImage imageNamed:@"pointMe"];
        UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
        [image setImageWithURL:temp.imageUrl];
        annoView.leftCalloutAccessoryView = image;
//    }
//    else
    
    annoView.image =[UIImage imageNamed:@"pin"];
    // 设置该锚点控件是否可显示气泡信息
    annoView.canShowCallout = YES;
    // 可通过锚点控件的rightCalloutAccessoryView、leftCalloutAccessoryView设置附加控件
    //NSLog(@"%@",NSStringFromCGRect(annoView.frame));
    CGRect rect = annoView.frame;
    rect.size.width = 35;
    rect.size.height = 35;
    //位置是无法在这里改变的
    annoView.frame = rect;
    return annoView;
}
-(void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray *)views
{
    frames = [NSMutableArray new];
    for (MKAnnotationView *view in views) {
        CGRect rect = view.frame;
        [frames addObject:[NSValue valueWithCGRect:rect]];
        view.frame = CGRectMake(0, 0, 0, 0);
        view.center = mapCell.map.center;
    }
    //用于动画
    MKAnnotationView *view;
    for (int i = 0; i < views.count; i++) {
        view = views[i];
        [UIView animateWithDuration:1 animations:^()
         {
             if (view) {
                 CGRect rect = view.frame;
                 rect.size.width = 170;
                 rect.size.height = 170;
                 view.frame = rect;
                 view.center = mapCell.map.center;
             }
         }];
        [UIView animateWithDuration:1 delay:1 options:UIViewAnimationOptionCurveEaseInOut animations:^(){
            view.frame = [frames[i] CGRectValue];
        } completion:nil];
    }
    
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    otherView = [[DiscoverMapOtherView alloc]initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 40)];
    [otherView.btn1 addTarget:self action:@selector(otherViewBtnPress:) forControlEvents:UIControlEventTouchUpInside];
    [otherView.btn2 addTarget:self action:@selector(otherViewBtnPress:) forControlEvents:UIControlEventTouchUpInside];
    [otherView.btn3 addTarget:self action:@selector(otherViewBtnPress:) forControlEvents:UIControlEventTouchUpInside];
    [otherView.btn4 addTarget:self action:@selector(otherViewBtnPress:) forControlEvents:UIControlEventTouchUpInside];


    return otherView;
}
- (void)otherViewBtnPress:(UIButton*)sender
{
    [UIView animateWithDuration:0.35 animations:^(void){
        CGRect rect =  otherView.buttom.frame;
        rect.origin.x = sender.frame.origin.x;
        otherView.buttom.frame = rect;

    }];
    switch (sender.tag) {
        case 765001:
            [mapCell.map removeAnnotations:annotations];
            [annotations removeAllObjects];
            frames = [NSMutableArray new];
            for (Statu *statu in self.photoStatus) {
                if (statu.geo) {
                    CLLocationCoordinate2D location=CLLocationCoordinate2DMake([statu.geo.latitude doubleValue], [statu.geo.longitude doubleValue]);
                    KCAnnotation *annotation=[[KCAnnotation alloc]init];
                    annotation.title = statu.user.name;
                    annotation.subtitle= statu.text;
                    annotation.imageUrl = [NSURL URLWithString:statu.thumbnail_pic];
                    annotation.coordinate=location;
                    
                    [annotations addObject:annotation];
                }
            }
            [mapCell.map addAnnotations:annotations];
            break;
        case 765002:
            [mapCell.map removeAnnotations:annotations];
            [annotations removeAllObjects];
            frames = [NSMutableArray new];
            for (Poi *poi in self.pois) {
                CLLocationCoordinate2D location=CLLocationCoordinate2DMake([poi.lat doubleValue], [poi.lon doubleValue]);
                KCAnnotation *annotation=[[KCAnnotation alloc]init];
                annotation.title = poi.title;
                    annotation.subtitle= poi.address;
                annotation.imageUrl = [NSURL URLWithString:poi.poi_pic];
                annotation.coordinate=location;
                [annotations addObject:annotation];
            }
            [mapCell.map addAnnotations:annotations];

            break;
        case 765003:
            [mapCell.map removeAnnotations:annotations];
            [annotations removeAllObjects];
            frames = [NSMutableArray new];
            for (User *user in self.users) {
                long double lat = arc4random()%150;
                if(lat>70)
                    lat =[self.lat doubleValue] - lat*0.0001;
                else
                    lat =[self.lat doubleValue] + lat*0.0001;
                long double lon = arc4random()%150;
                if(lon>70)
                    lon =[self.Long doubleValue] - lon*0.0001;
                else
                    lon =[self.Long doubleValue] + lon*0.0001;
               // NSLog(@"%lf,%lf",lat,lon);
                CLLocationCoordinate2D location=CLLocationCoordinate2DMake(lat, lon);
                KCAnnotation *annotation=[[KCAnnotation alloc]init];
                annotation.title = user.name;
                annotation.subtitle= user.Description;
                annotation.imageUrl = [NSURL URLWithString:user.profile_image_url];
                annotation.coordinate=location;
                [annotations addObject:annotation];
            }
            [mapCell.map addAnnotations:annotations];


            break;
        case 765004:
            [mapCell.map removeAnnotations:annotations];
            [annotations removeAllObjects];
            frames = [NSMutableArray new];
            for (Statu *statu in self.photoStatus) {
                if (statu.geo) {
                    CLLocationCoordinate2D location=CLLocationCoordinate2DMake([statu.geo.latitude doubleValue], [statu.geo.longitude doubleValue]);
                    KCAnnotation *annotation=[[KCAnnotation alloc]init];
                    annotation.title = statu.user.name;
                    annotation.subtitle= statu.text;
                    annotation.imageUrl = [NSURL URLWithString:statu.thumbnail_pic];
                    annotation.coordinate=location;
                    
                    [annotations addObject:annotation];
                }
            }
            [mapCell.map addAnnotations:annotations];

            break;
            
        default:
            break;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 40;
}
-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
  
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{

}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 562;
    }
    return 50;
}



@end
