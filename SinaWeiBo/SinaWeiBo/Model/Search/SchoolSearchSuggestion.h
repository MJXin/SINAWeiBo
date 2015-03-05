//
//  SchoolSearchSuggestion.h
//  WBTest
//
//  Created by mjx on 15/1/29.
//  Copyright (c) 2015年 MJX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+PropertyMethod.h"
@interface SchoolSearchSuggestion : NSObject
/**搜索建议学校名字 */
@property (nonatomic, strong) NSString *school_name;
/**不知道什么属性 */
@property (nonatomic, strong) NSNumber *location;
/**搜索建议学校Id */
@property (nonatomic, strong) NSNumber *Id;
/**搜索建议学校类型 学校类型，0：全部、1：大学、2：高中、3：中专技校、4：初中、5：小学，默认为0。*/
@property (nonatomic, strong) NSNumber *type;
-(instancetype)initWithDict:(NSDictionary*)dict;
@end
