//
//  Site.h
//  WBTest
//
//  Created by mjx on 15/1/30.
//  Copyright (c) 2015年 MJX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Site : NSObject
/**地点的Id*/
@property (nonatomic, strong) NSString *Id;
/**地点的名字*/
@property (nonatomic, strong) NSString *name;

- (instancetype)initWithDict:(NSDictionary*)dict;
@end
