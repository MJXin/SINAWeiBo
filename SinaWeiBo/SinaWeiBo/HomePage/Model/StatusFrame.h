//
//  StatusFrame.h
//  微博SDK测试
//
//  Created by lrw on 15/1/4.
//  Copyright (c) 2015年 LRW. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Status,Statu;
@interface StatusFrame : UIView
@property (nonatomic, strong) Statu *status;
/**是否显示中等图片,默认是NO,这个属性只影响显示一张图片的cell，而且不影响转发内容*/
@property (nonatomic, assign) BOOL showMediumPicture;
/**cell的高度*/
@property (nonatomic, assign, readonly) CGFloat cellHeight;
/**工具栏位置*/
@property (nonatomic, assign, readonly) CGRect toolBarFrame;
/**图片区域位置*/
@property (nonatomic, assign, readonly) CGRect imagesViewFrame;
/**内容文本位置*/
@property (nonatomic, assign, readonly) CGRect textFrame;
/**来源文本位置*/
@property (nonatomic, assign, readonly) CGRect sourceFrame;
/**发布时间文本位置*/
@property (nonatomic, assign, readonly) CGRect created_atFrame;
/**vip图片位置*/
@property (nonatomic, assign, readonly) CGRect vipIconFrame;
/**用户头像位置*/
@property (nonatomic, assign, readonly) CGRect profile_imageFrame;
/**用户呢称位置*/
@property (nonatomic, assign, readonly) CGRect screen_nameFrame;
/**所有图片的位置*/
@property (nonatomic, strong, readonly) NSArray *imagesFrame;
/**转发区域*/
@property (nonatomic, assign, readonly) CGRect transpondAreaFrame;
/**转发区子控件部位置*/
@property (nonatomic, strong, readonly) StatusFrame *transpondArea_viewsFrame;

@end
