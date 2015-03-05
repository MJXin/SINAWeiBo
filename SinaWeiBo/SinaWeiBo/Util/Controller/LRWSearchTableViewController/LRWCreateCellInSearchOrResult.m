//
//  LRWCreateCellInSearchOrResult.m
//  微博SDK测试
//
//  Created by lrw on 15/2/4.
//  Copyright (c) 2015年 LRW. All rights reserved.
//

#import "LRWCreateCellInSearchOrResult.h"
#import "LRWSearchTableViewCell.h"
@interface LRWCreateCellInSearchOrResult()

@end
@implementation LRWCreateCellInSearchOrResult

+ (UITableViewCell *)createTopicCellInTableView:(UITableView *)tableView searchType:(LRWSearchType)searchType cellData:(Trend *)data
{
    static NSString *ID = @"topic_cell_abc";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"#%@#",data.name];
    cell.imageView.image = [UIImage imageNamed:@"topic_image_default"];
    cell.imageView.contentMode = UIViewContentModeScaleAspectFill;
    //cell.imageView.layer.cornerRadius = SEARCHCELLHEIGHT * 0.5;
    //cell.imageView.clipsToBounds = YES;
    return cell;
}

+ (UITableViewCell *)createAtCellInTableView:(UITableView *)tableView searchType:(LRWSearchType)searchType cellData:(User *)data
{
    static NSString *ID = @"search_table_view_cell";
    LRWSearchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[LRWSearchTableViewCell alloc]init];
    }
    cell.myLabel.text = [NSString stringWithFormat:@"@%@",data.screen_name];
    cell.myImageView.image = [UIImage imageNamed:@"tabbar_profile"];
    [cell.myImageView setImageWithURL:[NSURL URLWithString:data.profile_image_url]];
    //cell.myImageView.layer.cornerRadius = SEARCHCELLHEIGHT * 0.5;
    cell.myImageView.clipsToBounds = YES;
    return cell;
}
@end
