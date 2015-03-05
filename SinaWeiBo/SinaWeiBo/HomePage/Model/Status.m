//
//  Statuse.m
//  微博SDK测试
//
//  Created by lrw on 14/12/26.
//  Copyright (c) 2014年 LRW. All rights reserved.
//

#import "Status.h"
#import "NSString+Regular.h"
#import "NSString+Date.h"
@implementation Status
+ (instancetype)statuseWithDic:(NSDictionary *)dic
{
    //NSLog(@"%@",dic);
    Status *status = [Status new];
    //设置转发微博内容
    NSDictionary *retweeted_statusDic = dic[@"retweeted_status"];
    if (retweeted_statusDic != nil) {
        //添加一个key:value 用来表示这个字典是转发内容
        Status *status2 = [Status statuseWithDic:retweeted_statusDic];
        status2.is_retweeted_status = YES;
        status.retweeted_status = status2;
    }
    //设置微博创建时间
    status.created_at = [NSString returnUploadTime:dic];
    status.ID = [dic[@"id"] integerValue];
    status.mid = [dic[@"mid"] integerValue];
    status.idstr = dic[@"idstr"];
    status.text = dic[@"text"];
    //NSLog(@"%@",status.text);
    //设置attributeString类型的文本内容
    [status setUpAtttibuteString];
    //提取html<a>标签的内容
    NSString *aHtml = dic[@"source"];
    status.source = [status getAContentByHtmlStr:aHtml];
    status.favorited = [dic[@"favorited"] boolValue];
    status.truncated = [dic[@"truncated"] boolValue];
    status.in_reply_to_status_id = dic[@"in_reply_to_status_id"];
    status.in_reply_to_user_id = dic[@"in_reply_to_user_id"];
    status.in_reply_to_screen_name = dic[@"in_reply_to_screen_name"];
    status.thumbnail_pic = dic[@"thumbnail_pic"];
    status.bmiddle_pic = dic[@"bmiddle_pic"];
    status.original_pic = dic[@"original_pic"];
    status.geo = dic[@"geo"];
    status.user = dic[@"user"];
    status.reposts_count = [dic[@"reposts_count"] integerValue];
    status.comments_count = [dic[@"comments_count"] integerValue];
    status.attitudes_count = [dic[@"attitudes_count"] integerValue];
    status.mlevel = [dic[@"mlevel"] integerValue];
    status.visible = dic[@"visible"];
    status.pic_ids = dic[@"pic_ids"];
    status.ad = dic[@"ad"];
    //-------------------------------------------文档没有提到的字段
    //图片数据
    NSArray *imgsArray = dic[@"pic_urls"];
    NSMutableArray *imgsTmpArray = [NSMutableArray array];
    for (int i = 0; i < imgsArray.count; ++i ) {
        NSString *urlString = imgsArray[i][@"thumbnail_pic"];
//        NSURL *url = [NSURL URLWithString:imgsArray[i][@"thumbnail_pic"]];
//        [imgsTmpArray addObject:url];
        [imgsTmpArray addObject:urlString];
    }
    status.pic_urls = imgsTmpArray;
    
    return status;
}

#pragma mark - 文本内容转换
- (void)setUpAtttibuteString
{
    NSArray *subString = [_text substringByRegular:@"@(.*): "];
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:_text];
    for (NSString *str in subString) {
        NSRange rang = [_text rangeOfString:str];
        [attributeString setAttributes:@{ NSForegroundColorAttributeName: [UIColor blueColor] } range:rang];
    }
    _attributeText = attributeString;
}

#pragma mark - html 过滤
/**获取<a>标签内容*/
- (NSString *)getAContentByHtmlStr:(NSString *)html
{
    NSString *sourceStr = html;
    NSMutableArray *sourceContentArray = [sourceStr substringByRegular:@">(.*)</a>"];
    for (int i = 0; i < sourceContentArray.count; ++i) {
        NSString *str1 = sourceContentArray[i];
        NSString *str2 = [str1 stringByReplacingOccurrencesOfString:@"</a>" withString:@""];
        NSString *str3 = [str2 stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:@""];
        [sourceContentArray setObject:str3 atIndexedSubscript:i];
    }
    //NSLog(@"%@",sourceContentArray);
    return [sourceContentArray firstObject];
}
@end
