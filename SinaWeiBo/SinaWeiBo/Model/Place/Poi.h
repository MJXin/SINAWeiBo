//
//  Poi.h
//  WBTest
//
//  Created by mjx on 15/2/2.
//  Copyright (c) 2015年 MJX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+PropertyMethod.h"
@interface Poi : NSObject
/**地点的id */
@property (nonatomic, strong) NSString *poiid;
/**地点的名字 */
@property (nonatomic, strong) NSString *title;
/**地点的地址 */
@property (nonatomic, strong) NSString *address;
/**另一种格式的地址 */
@property (nonatomic, strong) NSString *poi_street_address;
/**另一种地址 */
@property (nonatomic, strong) NSString *poi_street_summary;
/**描述*/
@property (nonatomic, strong) NSString *extra;
/**地点的经度 */
@property (nonatomic, strong) NSString *lon;
/**地点的纬度 */
@property (nonatomic, strong) NSString *lat;
/**猜测是目录编号 */
@property (nonatomic, strong) NSString *category;
/**城市编号 */
@property (nonatomic, strong) NSString *city;
/**省份编号 */
@property (nonatomic, strong) NSString *province;
/**国家编号 */
@property (nonatomic, strong) NSString *country;
/**不知道作用 */
@property (nonatomic, strong) NSString *url;
/**地点电话 */
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *postcode;
@property (nonatomic, strong) NSString *weibo_id;
@property (nonatomic, strong) NSString *categorys;
/**分类名称 */
@property (nonatomic, strong) NSString *category_name;
/**图标*/
@property (nonatomic, strong) NSString *icon;
/**地点图片*/
@property (nonatomic, strong) NSString *poi_pic;
/**签到数*/
@property (nonatomic, strong) NSString *checkin_num;
/**签到用户数*/
@property (nonatomic, strong) NSString *checkin_user_num;
/**点评数*/
@property (nonatomic, strong) NSNumber *tip_num;
/*图片数*/
@property (nonatomic, strong) NSNumber *photo_num;
@property (nonatomic, strong) NSNumber *todo_num;

- (instancetype)initWithDict:(NSDictionary*)dict;
@end
