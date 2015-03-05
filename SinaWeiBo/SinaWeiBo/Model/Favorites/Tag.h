//
//  Tag.h
//  WBTest
//
//  Created by mjx on 15/1/27.
//  Copyright (c) 2015年 MJX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+PropertyMethod.h"
@interface Tag : NSObject

/**标签Id*/
@property (nonatomic) NSInteger Id;
/**标签名*/
@property (nonatomic, strong) NSString *tag;
/**数量*/
@property (nonatomic) NSInteger count;

- (instancetype)initWithDict:(NSDictionary*)dict;
@end
