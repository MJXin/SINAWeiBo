//
//  PoisCategory.h
//  WBTest
//
//  Created by mjx on 15/2/3.
//  Copyright (c) 2015年 MJX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+PropertyMethod.h"
@interface PoisCategory : NSObject

@property (nonatomic, strong) NSString *Id;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *pid;

-(instancetype)initWithDict:(NSDictionary*)dict;
@end
