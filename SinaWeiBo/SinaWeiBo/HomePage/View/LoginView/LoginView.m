//
//  LoginView.m
//  SinaWeiBo
//
//  Created by lrw on 15/2/27.
//  Copyright (c) 2015年 LMZ. All rights reserved.
//

#import "LoginView.h"

@implementation LoginView
- (IBAction)login:(id)sender {
    if ([self.delegate respondsToSelector:@selector(loginViewLoginBtnClick:)]) {
        [self.delegate loginViewLoginBtnClick:self];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [[NSBundle mainBundle] loadNibNamed:@"LoginView" owner:nil options:nil].firstObject;
    self.frame = frame;
    return self;
}
@end
