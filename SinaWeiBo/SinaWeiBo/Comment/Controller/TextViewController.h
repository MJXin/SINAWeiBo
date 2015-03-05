//
//  TextViewController.h
//  SinaWeiBo
//
//  Created by William-zhang on 15/2/5.
//  Copyright (c) 2015年 LMZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TextViewController : UIViewController<UITextViewDelegate>
/**文本框里面的提示文字
 */
@property(nonatomic, strong)NSString* placeholderText;
/**输入文本框
 */
@property(nonatomic, strong)UITextView* textView;
/**工具栏的View
 */
@property(nonatomic, strong)UIView* bottomView;
/**发送方法
 */
@property(nonatomic, assign)SEL send;

-(void)goBack;

-(void)hiddenPlaceholderText;

-(void)displayPlaceholderText;


@end
