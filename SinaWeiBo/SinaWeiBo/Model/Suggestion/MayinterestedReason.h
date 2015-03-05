//
//  MayinterestedReason.h
//  WBTest
//
//  Created by mjx on 15/1/29.
//  Copyright (c) 2015年 MJX. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface MayinterestedReason : NSObject
@property (nonatomic, strong) NSArray *f;
@property (nonatomic) NSInteger fCount;
@property (nonatomic, strong) NSArray *h;
@property (nonatomic) NSInteger hCount;

-(instancetype)initWithDict:(NSDictionary*)dict;
@end
