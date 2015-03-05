//
//  Emotions.h
//  WBTest
//
//  Created by mjx on 15/1/21.
//  Copyright (c) 2015年 MJX. All rights reserved.
//  微博表情类

#import <UIKit/UIKit.h>

@interface Emotions : UIView

/**分类 */
@property (nonatomic, strong) NSString *category;
/**不明 */
@property (nonatomic, strong) NSString *common;
/**不明,推断为是否使用人较多的表情 */
@property (nonatomic, strong) NSString *hot;
/**icon 表情的URL */
@property (nonatomic, strong) NSString *icon;
/**表情代表的意思 */
@property (nonatomic, strong) NSString *phrase;
/**意义不明 */
@property (nonatomic, strong) NSString *picid;
/**表情类别 */
@property (nonatomic, strong) NSString *type;
/**标签地址 */
@property (nonatomic, strong) NSString *url;
/**表情代表的短语 */
@property (nonatomic, strong) NSString *value;

- (instancetype)initWithDict:(NSDictionary*)dict;

@end
