//
//  DiscoverMapOtherView.m
//  SinaWeiBo
//
//  Created by mjx on 15/2/10.
//  Copyright (c) 2015年 LMZ. All rights reserved.
//
#import "DiscoverMapOtherView.h"

@implementation DiscoverMapOtherView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        self.btn1 = [[UIButton alloc]initWithFrame:CGRectMake(0,0,self.frame.size.width/4 , self.frame.size.height)];
        [self.btn1 setTitle:@"微博" forState:UIControlStateNormal];
        self.btn1.titleLabel.font = [UIFont systemFontOfSize:13];
        [self.btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.btn1.tag = 765001;
        [self addSubview:self.btn1];
        
//        NSLog(@"%@",NSStringFromCGRect(_btn1.frame));
        self.btn2 = [[UIButton alloc]initWithFrame:CGRectMake(self.frame.size.width/4,0,self.frame.size.width/4 ,self.frame.size.height)];
        [self.btn2 setTitle:@"地点" forState:UIControlStateNormal];
         self.btn2.titleLabel.font = [UIFont systemFontOfSize:13];
        [self.btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.btn2.tag = 765002;
        [self addSubview:self.btn2];

        
        self.btn3 = [[UIButton alloc]initWithFrame:CGRectMake(self.frame.size.width/2,0,self.frame.size.width/4 ,self.frame.size.height)];
        [self.btn3 setTitle:@"人" forState:UIControlStateNormal];
         self.btn3.titleLabel.font = [UIFont systemFontOfSize:13];
        [self.btn3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.btn3.tag = 765003;
        [self addSubview:self.btn3];

        
        self.btn4 = [[UIButton alloc]initWithFrame:CGRectMake(self.frame.size.width/4*3,0,self.frame.size.width/4 ,self.frame.size.height)];
        
        [self.btn4 setTitle:@"图" forState:UIControlStateNormal];
         self.btn4.titleLabel.font = [UIFont systemFontOfSize:13];
        [self.btn4 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.btn4.tag = 765004;
        [self addSubview:self.btn4];
        
        self.buttom = [[UIView alloc]initWithFrame:CGRectMake(0, 37, self.frame.size.width/4, 3)];
        self.buttom.backgroundColor = [UIColor orangeColor];
        [self addSubview:self.buttom];
        

    }
    return self;
}



@end
