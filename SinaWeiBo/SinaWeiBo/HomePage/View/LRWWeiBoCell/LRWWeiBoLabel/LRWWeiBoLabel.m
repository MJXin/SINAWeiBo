//
//  LRWWeiBoLabel.m
//  微博label设置
//
//  Created by lrw on 15/1/12.
//  Copyright (c) 2015年 LRW. All rights reserved.
//
#define IMAGESIZE CGSizeMake(20,20)
#define URLSTRING @"+网络链接"
#define EMOJIBEGINSTRING @"+"
#define EMOJIENDSTRING @"="
#define ALABEL_EXPRESSION @"(<[aA].*?>.+?</[aA]>)"
#define HREF_PROPERTY_IN_ALABEL_EXPRESSION @"(href\\s*=\\s*(?:\"([^\"]*)\"|\'([^\']*)\'|([^\"\'>\\s]+)))"
//匹配 url
#define URL_EXPRESSION @"([hH][tT][tT][pP][sS]?:\\/\\/[^ ,'\">\\]\\)]*[^\\. ,'\">\\]\\)])"
//匹配 “@*”
#define AT_IN_WEIBO_EXPRESSION @"(@[\u4e00-\u9fa5a-zA-Z0-9_-]{1,30})"
//匹配 “#*#”
#define TOPIC_IN_WEIBO_EXPRESSION @"(#[^#]+#)"
//匹配 "[表情]"
#define EMOJI_IN_WEIBO_EXPRESSION @"(\\[[^\\]]+\\])"
#import "LRWWeiBoLabel.h"
#import "LRWWeiBoEmoji.h"
#import <CoreText/CoreText.h>
#import <CoreGraphics/CoreGraphics.h>
@interface LRWWeiBoLabel()
{
    NSMutableArray *_urlArray;
    NSMutableArray *_atArray;
    NSMutableArray *_topicArray;
    NSMutableArray *_emojiArray;
}
@end

@implementation LRWWeiBoLabel

- (instancetype)init
{
    if (self = [super init]) {
        [self setUp];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setUp];
    }
    return self;
}

#pragma mark - 初始化
- (void)setUp
{
    _urlArray = [NSMutableArray array];
    _atArray = [NSMutableArray array];
    _topicArray = [NSMutableArray array];
    _emojiArray = [NSMutableArray array];
    _iconHeight = 20.0;
    _lineSpace = 1.0;
    self.numberOfLines = 0;
    self.lineBreakMode = NSLineBreakByCharWrapping;
    self.userInteractionEnabled = YES;
}

#pragma mark - setter
- (void)setText:(NSString *)text
{
    //NSLog(@"%@",text);
    NSString *handelString;
    
    //1.替换所有URL文本,并且记录URL位置
    [_urlArray removeAllObjects];
    handelString = [self replaceAllURL:[[NSMutableString alloc] initWithString:text]];
    
    //2.替换所有表情文本,并且记录表情位置
    [_emojiArray removeAllObjects];
    handelString = [self replaceAllEmoji:[[NSMutableString alloc] initWithString:handelString]];

    //3.保存处理后的文本
    [super setText:handelString];
    NSRange range  = NSMakeRange(0, handelString.length);
    
    //4.记录"@"类型字符串的位置
    [_atArray removeAllObjects];
    _atArray = [self delimitedStringWithText:handelString range:range type:LRWSTringType_AT regular:AT_IN_WEIBO_EXPRESSION];
    
    //5.记录"#"类型字符串的位置
    _topicArray = [self delimitedStringWithText:handelString range:range type:LRWSTringType_TOPIC regular:TOPIC_IN_WEIBO_EXPRESSION];

    [self setNeedsDisplay];
}

- (void)setLineSpace:(CGFloat)lineSpace
{
    lineSpace = MAX(lineSpace, 0);
    _lineSpace = lineSpace;
}

- (void)setIconHeight:(CGFloat)iconHeight
{
    iconHeight = MAX(iconHeight, 0);
    _iconHeight = iconHeight;
}

#pragma mark - 获取当前字符所在的 LRWStringAndRangAndType 对象
- (LRWStringAndRangAndType *)getStringAndRangAndTypeByLoaction:(NSUInteger)location
{
    LRWStringAndRangAndType *srt;
    NSArray *all = [self getAllStringAndFrameAndType];
    for (LRWStringAndRangAndType *obj in all) {
        if (NSLocationInRange(location, obj.range))
            return obj;
    }
    return srt;
}

#pragma mark - 字符串分隔方法,返回一个数组
- (NSMutableArray *)delimitedStringWithText:(NSString *)text range:(NSRange)range type:(LRWSTringType)type regular:(NSString *)regular
{
    NSMutableArray *array = [NSMutableArray array];
    NSError *error;
    NSRegularExpression *reg = [NSRegularExpression regularExpressionWithPattern:regular
                                                                        options:0
                                                                          error:&error];
    if (!error) {
        NSArray *result;

        result = [reg matchesInString:text options:NSMatchingReportCompletion range:range];
        for (NSTextCheckingResult *cr in result) {
            LRWStringAndRangAndType *srt = [LRWStringAndRangAndType string:[text substringWithRange:cr.range]
                                                                     range:cr.range
                                                                    stringType:type];
            [array addObject:srt];
        }
    }
    return array;
}

#pragma mark - 获取所有LRWStringAndRangAndType对象
- (NSArray *)getAllStringAndFrameAndType
{
    NSMutableArray *all = [NSMutableArray arrayWithCapacity:_urlArray.count + _emojiArray.count + _atArray.count + _topicArray.count];
    [all addObjectsFromArray:_urlArray];
    [all addObjectsFromArray:_emojiArray];
    [all addObjectsFromArray:_atArray];
    [all addObjectsFromArray:_topicArray];
    return all;
}

#pragma mark - 设置字体颜色和风格
/**设置所有颜色和字体*/
- (void)setUpColorAndFont
{
    UIColor *defaultColor = [UIColor blackColor];
    if (!_urlFont) {
        _urlFont = self.font;
    }
    if (!_atFont) {
        _atFont = self.font;
    }
    if (!_topicFont) {
        _topicFont = self.font;
    }
    if (!_urlColor) {
        _urlColor = self.textColor ? self.textColor : defaultColor;
    }
    if (!_atColor) {
        _atColor = self.textColor ? self.textColor : defaultColor;
    }
    if (!_topicColor) {
        _topicColor = self.textColor ? self.textColor : defaultColor;
    }
}
#pragma mark - 修改attributedString的颜色
- (void)setUpAttributeStringColor
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    for (LRWStringAndRangAndType *srt in _urlArray) {
        [attributedString setAttributes:@{NSForegroundColorAttributeName : _urlColor,
                                          NSFontAttributeName : _urlFont} range:srt.range];
        
    }
    for (LRWStringAndRangAndType *srt in _atArray) {
        [attributedString setAttributes:@{NSForegroundColorAttributeName : _atColor,
                                          NSFontAttributeName : _atFont} range:srt.range];
    }
    for (LRWStringAndRangAndType *srt in _topicArray) {
        [attributedString setAttributes:@{NSForegroundColorAttributeName : _topicColor,
                                          NSFontAttributeName : _topicFont} range:srt.range];
    }
    self.attributedText = attributedString;
}
#pragma mark - 文本处理
/**把所有表情并记录位置*/
- (NSString *)replaceAllEmoji:(NSMutableString *)string
{
    NSError *error;
    NSRegularExpression *reg = [NSRegularExpression regularExpressionWithPattern:EMOJI_IN_WEIBO_EXPRESSION
                                                                         options:0
                                                                           error:&error];
    NSArray *result = [reg matchesInString:string
                                   options:NSMatchingReportCompletion
                                     range:NSMakeRange(0, string.length)];
    
    if (error == nil && result.count > 0) {
        NSTextCheckingResult *cr = result.firstObject;
        NSString *urlString = [string substringWithRange:cr.range];
        NSMutableString *replaceString = [NSMutableString stringWithString:EMOJIBEGINSTRING];
        for (NSInteger i = 1; i < cr.range.length; i++) {
            [replaceString appendString:EMOJIENDSTRING];
        }
        [string replaceCharactersInRange:cr.range withString:replaceString];
        [_emojiArray addObject:[LRWStringAndRangAndType string:urlString
                                                         range:NSMakeRange(cr.range.location, replaceString.length)
                                                    stringType:LRWSTringType_Emoji]];
        
        [self replaceAllEmoji:string];
    }
    return string;
}

/**把所有URL替换“网址链接”*/
- (NSString *)replaceAllURL:(NSMutableString *)string
{
    NSError *error;
    NSRegularExpression *reg = [NSRegularExpression regularExpressionWithPattern:URL_EXPRESSION
                                                                         options:0
                                                                           error:&error];
    NSArray *result = [reg matchesInString:string
                                   options:NSMatchingReportCompletion
                                     range:NSMakeRange(0, string.length)];
    
    if (error == nil && result.count > 0) {
        NSTextCheckingResult *cr = result.firstObject;
        NSString *urlString = [string substringWithRange:cr.range];
        //------------判断是否分隔字符错误,链接中带有“[“----------begin
        NSRange errorRnage = [urlString rangeOfString:@"["];
        NSInteger errorLength = 0;
        if (errorRnage.length != 0)
        {
            errorLength = urlString.length - errorRnage.location;
            urlString = [urlString substringWithRange:NSMakeRange(0, urlString.length - errorLength)];
        }
        //---------------------------------------------------end
        [string replaceCharactersInRange:NSMakeRange(cr.range.location, urlString.length) withString:URLSTRING];
        [_urlArray addObject:[LRWStringAndRangAndType string:urlString
                                                       range:NSMakeRange(cr.range.location, URLSTRING.length)
                                                  stringType:LRWSTringType_URL]];
        [self replaceAllURL:string];
    }
    //NSLog(@"%@",string);
    return string;
}
#pragma mark - 位置处理
/**获取行高*/
- (CGFloat)getLineHeight
{
    NSString *str = @"高";
    CGFloat maxHeight;
    CGFloat iconHeight = _iconHeight;
    CGFloat urlHeight = [str sizeWithAttributes:@{NSFontAttributeName : _urlFont}].height;
    CGFloat  atHeight = [str sizeWithAttributes:@{NSFontAttributeName : _atFont}].height;
    CGFloat  topicHeight = [str sizeWithAttributes:@{NSFontAttributeName : _topicFont}].height;
    maxHeight = iconHeight;
    maxHeight = MAX(maxHeight, urlHeight);
    maxHeight = MAX(maxHeight, atHeight);
    maxHeight = MAX(maxHeight, topicHeight);
//    return maxHeight + _lineSpace;
    return urlHeight;
}

#pragma mark - 渲染文字
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {    //设置字体和颜色
    
    //设置颜色
    [self setUpColorAndFont];
    //跟新字体颜色
    [self setUpAttributeStringColor];
    
    //单个字符在字符串中的位置
    NSRange characterRange;
    //单个字符
    NSAttributedString *character = nil;
    //单个字符显示位置,颜色,字体格式
    CGRect currentFrame = CGRectZero;
    NSDictionary *attributes = nil;
    //真实大小
    CGSize currentSize;
    
    //计算并画出每一个字符
    for (int i = 0; i < self.text.length; ++i) {
        characterRange = NSMakeRange(i, 1);
        character = [self.attributedText attributedSubstringFromRange:characterRange];
        //获取当前字符所在 LRWStringAndRangAndType 的对象
        LRWStringAndRangAndType *srt = [self getStringAndRangAndTypeByLoaction:i];
        //是网络连接的时候，第一个字符要显示图片
        BOOL isURLFirstCharacter = srt.strType == LRWSTringType_URL && i == srt.range.location;
        if (srt.strType == LRWSTringType_Emoji || isURLFirstCharacter )//绘制图片
        {
            //判断是否为表情的填充字符,是就不需要画了
            if (srt.strType == LRWSTringType_Emoji && [character.string isEqualToString:EMOJIENDSTRING
                                                       ]) {
                continue;
            }
            
            NSString *imageName = [[LRWWeiBoEmoji defaultEmoji].allEmojis objectForKey:srt.string];
            if (!imageName) imageName = @"Expression_100";
            if (srt.strType == LRWSTringType_URL)
            {
                imageName = @"timeline_card_small_web";
            }
            
            UIImage *image = [UIImage imageNamed:imageName];
            currentSize = CGSizeMake(_iconHeight, _iconHeight);
            currentFrame = CGRectMake(CGRectGetMaxX(currentFrame) + _fontSpace,
                                      currentFrame.origin.y,
                                      currentSize.width,
                                      currentSize.height);
            
            if( CGRectGetMaxX(currentFrame) > self.bounds.size.width)
            {
                //超出宽度的时候
                //NSLog(@"%@",[character string]);
                currentFrame.origin.y +=  [self getLineHeight];
                currentFrame.origin.x = 0;
            }
            //计算并把图片显示在行的中心
            CGFloat margin = ABS(([self getLineHeight] - _iconHeight)) * 0.5;
            [image drawInRect:CGRectMake(currentFrame.origin.x,
                                             currentFrame.origin.y - margin,
                                             currentSize.width,
                                             currentSize.height)];

            
        }
        else//绘制文本
        {
            //获取字符attribute属性
            attributes = [character attributesAtIndex:0 effectiveRange:nil];
            //当前字符大小
            currentSize = [[character string] sizeWithAttributes:attributes];
            
            currentFrame = CGRectMake(CGRectGetMaxX(currentFrame) + _fontSpace,
                                      currentFrame.origin.y,
                                      currentSize.width,
                                      currentSize.height);
            
            if( CGRectGetMaxX(currentFrame) > self.bounds.size.width)
            {
                //超出宽度的时候
                //NSLog(@"%@",[character string]);
                currentFrame.origin.y += [self getLineHeight];
                currentFrame.origin.x = 0;
            }
            [srt.frames addObject:[NSValue valueWithCGRect:currentFrame]];
            [character drawInRect:currentFrame];
        }
    }
}

#pragma mark - 触碰方法
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = touches.allObjects.firstObject;
    CGPoint currentPoint = [touch locationInView:self];
    for (LRWStringAndRangAndType *srt in [self getAllStringAndFrameAndType]) {
        for (NSValue *obj in srt.frames) {
            if (CGRectContainsPoint([obj CGRectValue], currentPoint)) {
                if ([self.delegate respondsToSelector:@selector(weiBoLabel:didClickText:)]) {
                    [self.delegate weiBoLabel:self didClickText:srt];
                }
                return;
            }
        }
    }
    [super touchesBegan:touches withEvent:event];
}

@end

@implementation LRWStringAndRangAndType
+ (id)string:(NSString *)string range:(NSRange)range stringType:(LRWSTringType)strType
{
    LRWStringAndRangAndType *str = [LRWStringAndRangAndType new];
    str.string = string;
    str.range = range;
    str.strType = strType;
    str.frames = [NSMutableArray arrayWithCapacity:range.length];
    return str;
}
@end

