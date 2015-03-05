//
//  FKPageLoadOperation.h
//  operationTest
//
//  Created by yeeku on 13-9-13.
//  Copyright (c) 2013年 crazyit.org. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
// 定义NSOperation的子类
@interface FKDownImageOperation : NSOperation
@property (nonatomic , strong) NSURL* url;
@property (nonatomic , weak) UIImageView* imageView;
- (id)initWithURL:(NSURL*)url imageView:(UIImageView *)iv;
@end
