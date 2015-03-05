//
//  AtUserSuggestion.h
//  WBTest
//
//  Created by mjx on 15/1/29.
//  Copyright (c) 2015年 MJX. All rights reserved.
//  艾特用户的联想列表

#import <Foundation/Foundation.h>
#import "NSObject+PropertyMethod.h"
@interface AtUserSuggestion : NSObject

@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) NSString *nickname;
@property (nonatomic, strong) NSString *remark;
-(instancetype)initWithDict:(NSDictionary*)dict;
@end
