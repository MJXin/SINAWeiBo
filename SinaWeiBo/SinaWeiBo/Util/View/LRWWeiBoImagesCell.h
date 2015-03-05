//
//  LRWWeiBoImagesCell.h
//  微博SDK测试
//
//  Created by lrw on 15/2/2.
//  Copyright (c) 2015年 LRW. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Statu;
@protocol LRWWeiBoImagesCellDelegate;
@interface LRWWeiBoImagesCell : UITableViewCell
@property (nonatomic , weak) id<LRWWeiBoImagesCellDelegate> delegate;
@property (nonatomic, strong) NSArray *dataArray;
@end

@protocol LRWWeiBoImagesCellDelegate <NSObject>
@optional
/**图片点击，返回点击图片，图片中等图url，来源微博*/
- (void)weiBoImagesCellDidClickImage:(UIImage *)image url:(NSString *)url statu:(Statu *)statu;
@end
