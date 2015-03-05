//
//  MayinterestedUesr.h
//  WBTest
//
//  Created by mjx on 15/1/29.
//  Copyright (c) 2015年 MJX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MayinterestedReason.h"
@interface MayinterestedUesr : NSObject

@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) MayinterestedReason *reason;
-(instancetype)initWithDict:(NSDictionary*)dict;
@end
