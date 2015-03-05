//
//  VisibleViewController.h
//  SinaWeiBo
//
//  Created by William-zhang on 15/2/9.
//  Copyright (c) 2015年 LMZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol VisibleViewControllerDelegate <NSObject>

@optional

-(void)itemDidClicked:(NSInteger)index;

@end

@interface VisibleViewController : UIViewController

@property(nonatomic, weak)id<VisibleViewControllerDelegate> delegate;

@property(nonatomic, assign)NSInteger visible;

@end
