//
//  LRWWeiBoUserFriendsTableViewCell.m
//  微博SDK测试
//
//  Created by lrw on 15/2/4.
//  Copyright (c) 2015年 LRW. All rights reserved.
//

#import "LRWWeiBoUserFriendsTableViewCell.h"
#import "UIImageView+AFNetworking.h"
@interface LRWWeiBoUserFriendsTableViewCell()
{
    __weak IBOutlet UIImageView *_vipIcon;
    /**用户简介*/
    __weak IBOutlet UILabel *_userIntroduce;
    /**用户呢称*/
    __weak IBOutlet UILabel *_userName;
    /**用户头像*/
    __weak IBOutlet UIImageView *_userIcon;
}
@end;
@implementation LRWWeiBoUserFriendsTableViewCell
+ (id)cellWithTableView:(UITableView *)tableView
{
    LRWWeiBoUserFriendsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"user_table_view_cell"];
    if (cell == nil) {
        cell = [[LRWWeiBoUserFriendsTableViewCell alloc] initWithStyle:0 reuseIdentifier:0];
    }
    return cell;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    return [[NSBundle mainBundle] loadNibNamed:@"LRWWeiBoUserFriendsTableViewCell" owner:nil options:nil].firstObject;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setUser:(User *)user
{
    _user = user;
    _vipIcon.image = nil;
    _userIcon.image = nil;
    
    NSInteger vipRank = user.mbrank.integerValue;
    NSString *vipIconName = vipRank ? [NSString stringWithFormat:@"common_icon_membership_level%ld",vipRank] :
    [NSString stringWithFormat:@"common_icon_membership_expired"];
    _vipIcon.image = [UIImage imageNamed:vipIconName];
    NSURL *url = [NSURL URLWithString:user.profile_image_url];
    [_userIcon setImageWithURL:url];
    UIColor *color = vipRank ? [UIColor redColor] : [UIColor blackColor];
    _userName.attributedText = [[NSAttributedString alloc] initWithString:user.screen_name attributes:@{NSForegroundColorAttributeName : color}];
    _userIntroduce.text = user.Description;
}

@end
