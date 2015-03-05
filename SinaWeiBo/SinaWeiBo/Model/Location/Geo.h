//
//  Geo.h
//  WBTest
//
//  Created by mjx on 15/1/19.
//  Copyright (c) 2015年 MJX. All rights reserved.
//  地理位置

#import <Foundation/Foundation.h>
#import "NSObject+PropertyMethod.h"
@interface Geo : NSObject
/**类型**/
@property (nonatomic, strong)NSString *type;
/**经纬度**/
@property (nonatomic, strong)NSArray *coordinates;
/**经度坐标*/
@property(nonatomic,strong)NSString *longitude;
/**维度坐标*/
@property(nonatomic,strong)NSString *latitude;
/**所在城市的城市代码*/
@property(nonatomic,strong)NSString *city;
/**所在省份的省份代码*/
@property(nonatomic,strong)NSString *province;
/**所在城市的城市名称*/
@property(nonatomic,strong)NSString *city_name;
/**所在省份的省份名称*/
@property(nonatomic,strong)NSString *province_name;
/**所在的实际地址，可以为空*/
@property(nonatomic,strong)NSString *address;
/**地址的汉语拼音，不是所有情况都会返回该字段*/
@property(nonatomic,strong)NSString *pinyin;
/**更多信息，不是所有情况都会返回该字段*/
@property(nonatomic,strong)NSString *more;


- (Geo*)initWithDict:(NSDictionary*)dict;
@end
