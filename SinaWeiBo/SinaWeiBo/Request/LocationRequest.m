//
//  LocationRequest.m
//  WBTest
//
//  Created by mjx on 15/2/3.
//  Copyright (c) 2015年 MJX. All rights reserved.
//

#import "LocationRequest.h"

@implementation LocationRequest

- (void)GeoRequestByIPWithParma:(RequestLoactionParma *)parma
{
    NSDictionary *pramas = [parma dictaryValue];
    NSString *url = @"https://api.weibo.com/2/location/geo/ip_to_geo.json";
    
    [WBHttpRequest requestWithURL:url httpMethod:@"GET" params:pramas queue:nil withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error)
     {
         NSDictionary *dict = result;
         NSArray *geoArr = dict[@"geos"];
         NSMutableArray *geos = [NSMutableArray new];
         for (NSDictionary *geoDict in geoArr) {
             Geo *geo = [[Geo alloc]initWithDict:geoDict];
             [geos addObject:geo];
         }
         [self.delegate GeoRequestByIPDidFinishedWithGeos:geos error:error];
        
     }];
}

/**根据实际地址返回地理信息
 *access_token 采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 *address 需要获取坐标的实际地址，必须进行URLencode。
 */
- (void)GeoRequestByAddressWithParma:(RequestLoactionParma *)parma
{
    NSDictionary *pramas = [parma dictaryValue];
    NSString *url = @"https://api.weibo.com/2/location/geo/address_to_geo.json";
    
    [WBHttpRequest requestWithURL:url httpMethod:@"GET" params:pramas queue:nil withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error)
     {
         NSDictionary *dict = result;
         NSArray *geoArr = dict[@"geos"];
         NSMutableArray *geos = [NSMutableArray new];
         for (NSDictionary *geoDict in geoArr) {
             Geo *geo = [[Geo alloc]initWithDict:geoDict];
             [geos addObject:geo];
         }
         [self.delegate GeoRequestByAddressDidFinishedWithGeos:geos error:error];
     }];
}

/**根据地理信息(经纬度)返回实际地址
 *access_token 采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 *coordinate 需要获取实际地址的坐标，经度纬度用逗号分隔。
 */
- (void)AddressRequestByGeoWithParma:(RequestLoactionParma*)parma
{
    NSDictionary *pramas = [parma dictaryValue];
    NSString *url = @"https://api.weibo.com/2/location/geo/geo_to_address.json";
    
    [WBHttpRequest requestWithURL:url httpMethod:@"GET" params:pramas queue:nil withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error)
     {
         NSDictionary *dict = result;
         NSArray *geoArr = dict[@"geos"];
         NSMutableArray *geos = [NSMutableArray new];
         for (NSDictionary *geoDict in geoArr) {
             Geo *geo = [[Geo alloc]initWithDict:geoDict];
             [geos addObject:geo];
         }
         [self.delegate AddressRequestByGeoDidFinishedWithGeos:geos error:error];
    }];
}

/**根据GPS获取偏移后的坐标
 *access_token 采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 *coordinate 需要获取偏移坐标的源坐标，经度纬度用逗号分隔。
 */
- (void)OffsetRequestByGpsWithParma:(RequestLoactionParma*)parma
{
    NSDictionary *pramas = [parma dictaryValue];
    NSString *url = @"https://api.weibo.com/2/location/geo/gps_to_offset.json";
    
    [WBHttpRequest requestWithURL:url httpMethod:@"GET" params:pramas queue:nil withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error)
     {
         NSDictionary *dict = result;
         NSArray *geoArr = dict[@"geos"];
         NSMutableArray *geos = [NSMutableArray new];
         for (NSDictionary *geoDict in geoArr) {
             Geo *geo = [[Geo alloc]initWithDict:geoDict];
             [geos addObject:geo];
         }
         [self.delegate OffsetRequestByGpsDidFinishedWithGeos:geos error:error];
     }];

}

@end
