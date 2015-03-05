//
//  SendStatuViewController.h
//  SinaWeiBo
//
//  Created by William-zhang on 15/2/9.
//  Copyright (c) 2015年 LMZ. All rights reserved.
//  发微博界面

#import "TextViewController.h"


@class Geo;

@interface SendStatuViewController : TextViewController
/**微博可见性：微博的可见性，0：所有人能看，1：仅自己可见，2：密友可见，3：指定分组可见，默认为0
 */
@property(nonatomic, assign)NSInteger visible;

/**发微博时的定位
 */
@property(nonatomic, strong)Geo* geo;

/**发微博的图片的url
 */
@property(nonatomic, strong)NSArray* images;



@end
