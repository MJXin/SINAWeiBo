//
//  DiscoverTableViewImageCell.h
//  WBTest
//
//  Created by mjx on 15/2/5.
//  Copyright (c) 2015年 MJX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DiscoverTableViewImageCell : UITableViewCell<UIScrollViewDelegate>
@property (strong, nonatomic)  UIImageView *theImage1;
@property (strong, nonatomic)  UIImageView *theImage2;
@property (strong, nonatomic)  UIImageView *theImage3;
@property (strong, nonatomic)  UIImageView *theImage4;
@property (weak, nonatomic) IBOutlet UIScrollView *imgScroll;
@property (weak, nonatomic) IBOutlet UIPageControl *page;
- (void) show;
@end
