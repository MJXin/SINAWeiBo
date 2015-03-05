//
//  LRWWeiBoContentView.h
//  微博SDK测试
//
//  Created by lrw on 15/1/19.
//  Copyright (c) 2015年 LRW. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LRWWeiBoLabel.h"
//-----------------------------------内容类
@class StatusFrame,Status,Statu;
@protocol LRWWeiBoContentViewDelegate;
@interface LRWWeiBoContentView : UIView
@property (nonatomic , weak) id<LRWWeiBoContentViewDelegate> delegate;
@property (nonatomic, strong) StatusFrame *statusFrame;
@property (nonatomic, strong) Statu *status;
/**是否显示中等图片,默认是NO,这个属性只影响显示一张图片的cell，而且不影响转发内容*/
@property (nonatomic, assign) BOOL showMediumPicture;
@end

@protocol LRWWeiBoContentViewDelegate <NSObject>
@required
@optional
/**点击正文文字*/
- (void)weiBoContetnView:(LRWWeiBoContentView *)weiBoContentView didClickText:(LRWStringAndRangAndType *)srt;
/**点击用户呢称代理方法*/
- (void)weiBoContetnView:(LRWWeiBoContentView *)weiBoContentView didClickScreenName:(Statu *)statu;
/**点击图片*/
- (void)weiBoContetnView:(LRWWeiBoContentView *)weiBoContentView didClickImageAtIndex:(NSInteger)index defaultImages:(NSArray *)defaultImages bmiddleImagesURL:(NSArray *)bmiddleImagesURL goodNumber:(NSString *)goodNumber;
/**点击工具栏*/
- (void)weiBoContetnView:(LRWWeiBoContentView *)weiBoContentView didClickToolBarItemAtIndex:(NSInteger)index;
/**整个view被点击方法*/
- (void)weiBoContetnView:(LRWWeiBoContentView *)weiBoContentView didClickContent:(Statu *)statu;
@end


//-----------------------------------图片区域类
@protocol LRWWeiBoImagesAreaDelegate;
@interface LRWWeiBoImagesArea : UIView
@property (nonatomic , weak) id<LRWWeiBoImagesAreaDelegate> delegate;
/**是否显示中等图片,默认是NO,这个属性只影响显示一张图片的cell，而且不影响转发内容*/
@property (nonatomic, assign) BOOL showMediumPicture;
/**图片的位置数组*/
@property (nonatomic, strong) NSArray *imagesFrame;
/**图片数据URL*/
@property (nonatomic, strong) NSArray *imagesURL;
@end
@protocol LRWWeiBoImagesAreaDelegate <NSObject>
- (void)weiBoImagesView:(LRWWeiBoImagesArea *)weiboImagesArea imageViewIndex:(NSInteger)index images:(NSArray *)images;
@end



//-----------------------------------工具栏域类
@class LRWWeiBoToolBarParam;
@protocol LRWWeiBoToolBarAreaDelegate;
@interface LRWWeiBoToolBarArea : UIView
/**数据类*/
@property (nonatomic, strong) LRWWeiBoToolBarParam *data;
@property (nonatomic, weak) id<LRWWeiBoToolBarAreaDelegate> delegate;
@end
@protocol LRWWeiBoToolBarAreaDelegate <NSObject>
- (void)weiBoToolBarAreaGoodBtnClick:(LRWWeiBoToolBarArea *)weiBoToolBarArea;
- (void)weiBoToolBarAreaShareBtnClick:(LRWWeiBoToolBarArea *)weiBoToolBarArea;
- (void)weiBoToolBarAreaMessageBtnClick:(LRWWeiBoToolBarArea *)weiBoToolBarArea;
@end


//-----------------------------------工具栏数据类
@interface LRWWeiBoToolBarParam : NSObject
/**转发数*/
@property (nonatomic, assign) NSInteger reposts_count;
/**评论数*/
@property (nonatomic, assign) NSInteger comments_count;
/**表态数*/
@property (nonatomic, assign) NSInteger attitudes_count;
@end
