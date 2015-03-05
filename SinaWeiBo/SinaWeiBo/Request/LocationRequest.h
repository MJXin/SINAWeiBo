//
//  LocationRequest.h
//  WBTest
//
//  Created by mjx on 15/2/3.
//  Copyright (c) 2015年 MJX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WeiboSDK.h"
#import "Geo.h"
#import "RequestLoactionParma.h"
#pragma mark --- 地理位置请求代理 ---
@protocol LocationRequestDelegation <NSObject>

@optional
/**完成根据IP地址返回地理信息坐标触发的代理方法*/
- (void)GeoRequestByIPDidFinishedWithGeos:(NSArray*)geos error:(NSError*)error;
/**完成根据世纪地址返回地理信息触发的代理方法*/
- (void)GeoRequestByAddressDidFinishedWithGeos:(NSArray*)geos error:(NSError*)error;
/**完成根据地理位置返回实际地址触发的代理方法*/
- (void)AddressRequestByGeoDidFinishedWithGeos:(NSArray*)geos error:(NSError*)error;
/**完成根据GPS获取偏移后的坐标触发的代理方法*/
- (void)OffsetRequestByGpsDidFinishedWithGeos:(NSArray*)geos error:(NSError*)error;
@end

#pragma mark --- 地理位置请求类正文 ---
@interface LocationRequest : NSObject
@property (nonatomic, strong) id<LocationRequestDelegation> delegate;

/**根据IP地址返回地理信息坐标
 *access_token 采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 *ip 需要获取坐标的IP地址，多个IP用逗号分隔，最多不超过10个。
 */
- (void)GeoRequestByIPWithParma:(RequestLoactionParma*)parma;

/**根据实际地址返回地理信息
 *access_token 采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 *address 需要获取坐标的实际地址，必须进行URLencode。
 */
- (void)GeoRequestByAddressWithParma:(RequestLoactionParma *)parma;

/**根据地理信息(经纬度)返回实际地址
 *access_token 采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 *coordinate 需要获取实际地址的坐标，经度纬度用逗号分隔。
 */
- (void)AddressRequestByGeoWithParma:(RequestLoactionParma*)parma;

/**根据GPS获取偏移后的坐标
 *access_token 采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 *coordinate 需要获取偏移坐标的源坐标，经度纬度用逗号分隔。
 */
- (void)OffsetRequestByGpsWithParma:(RequestLoactionParma*)parma;

@end
