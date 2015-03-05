//
//  UICheckBox.h
//  sinaWeiboDemo1
//
//  Created by William-zhang on 15/1/28.
//  Copyright (c) 2015年 William-zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UICheckBox : UIView

/**复选框是否被选中
*/
@property(nonatomic, assign)BOOL selected;
/**复选框的文字
 */
@property(nonatomic, copy)NSString* text;
/**复选框和文字的间距
 */
@property(nonatomic, assign)CGFloat distance;
/**复选框的文字的字体
 */
@property(nonatomic, strong)UIFont* font;
/**复选框的线条颜色
 */
@property(nonatomic, strong)UIColor* boxBorderColor;
/**复选框的线条宽度
 */
@property(nonatomic, assign)CGFloat boxBorderWidth;
/**复选框的边长
 */
@property(nonatomic, assign)CGFloat boxWidth;

@end
