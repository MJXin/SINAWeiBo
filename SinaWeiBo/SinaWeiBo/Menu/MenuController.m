//
//  MenuController.m
//  SinaWeiBo
//
//  Created by William-zhang on 15/2/5.
//  Copyright (c) 2015年 LMZ. All rights reserved.
//

#import "MenuController.h"
#import "HomeNavigationController.h"
#import "ShouyeViewController.h"

@interface MenuController ()

@end

@implementation MenuController
-(instancetype)init
{
    if (self = [super init]) {
        NSMutableArray* controllers = [[NSMutableArray alloc]init];
        ShouyeViewController* sy = [ShouyeViewController new];
        HomeNavigationController* home = [[HomeNavigationController alloc]initWithRootViewController:sy];
        [controllers addObject:home];
        
        
        self.viewControllers = controllers;
        self.delegate = self;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
