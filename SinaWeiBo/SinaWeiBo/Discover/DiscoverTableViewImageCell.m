//
//  DiscoverTableViewImageCell.m
//  WBTest
//
//  Created by mjx on 15/2/5.
//  Copyright (c) 2015年 MJX. All rights reserved.
//

#import "DiscoverTableViewImageCell.h"

@implementation DiscoverTableViewImageCell
{
    NSTimer *timer;
    BOOL isLastPage;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self.indentationLevel = 0;
    self.indentationWidth = 0;
    //delegate 写在这里无效
    //这地方可能写什么都无效,是因为没调用super吗
    return [[NSBundle mainBundle] loadNibNamed:@"DiscoverTableViewImageCell" owner:nil options:nil].firstObject;
}
- (void) show
{
    self.imgScroll.delegate = self;
    self.imgScroll.pagingEnabled = YES;
    self.imgScroll.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width*4, 100);
    int i = arc4random()%9;
    self.theImage1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 100)];
    self.theImage1.image = [UIImage imageNamed:[NSString stringWithFormat:@"AD%d.jpg",i]];
    self.theImage1.backgroundColor = [UIColor blueColor];
    
    self.theImage2 = [[UIImageView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width, 0, [UIScreen mainScreen].bounds.size.width, 100)];
    i = (i+2)%9;
    self.theImage2.image = [UIImage imageNamed:[NSString stringWithFormat:@"AD%d.jpg",i]];
    self.theImage2.backgroundColor = [UIColor redColor];
    
    self.theImage3 = [[UIImageView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width*2, 0, [UIScreen mainScreen].bounds.size.width, 100)];
    i = (i+2)%9;
    self.theImage3.image = [UIImage imageNamed:[NSString stringWithFormat:@"AD%d.jpg",i]];
    self.theImage3.backgroundColor = [UIColor greenColor];
    
    self.theImage4 = [[UIImageView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width*3, 0, [UIScreen mainScreen].bounds.size.width, 100)];
    self.theImage4.image = self.theImage1.image;
    
    [self.imgScroll addSubview:self.theImage1];
    [self.imgScroll addSubview:self.theImage2];
    [self.imgScroll addSubview:self.theImage3];
    [self.imgScroll addSubview:self.theImage4];
    
    timer = [NSTimer timerWithTimeInterval:3 target:self selector:@selector(changeAD) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];

    

    
}
- (void)changeAD
{
    if (self.page.currentPage == 0 && isLastPage) {
        [self.imgScroll setContentOffset:CGPointMake(0, 0)];
        isLastPage = NO;
    }
    float x = self.page.currentPage * [UIScreen mainScreen].bounds.size.width;
        x = x + [UIScreen mainScreen].bounds.size.width;
    [self.imgScroll setContentOffset:CGPointMake(x, YES) animated:YES];
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [timer setFireDate:[NSDate distantFuture]];
    
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    timer = [NSTimer timerWithTimeInterval:3 target:self selector:@selector(changeAD) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];

}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.imgScroll.contentOffset.x >= [UIScreen mainScreen].bounds.size.width*3) {
        self.page.currentPage = 0;
        isLastPage = YES;
    }
    else if(self.imgScroll.contentOffset.x >= [UIScreen mainScreen].bounds.size.width*2 )
    {
        self.page.currentPage = 2;
    }
    else if(self.imgScroll.contentOffset.x >= [UIScreen mainScreen].bounds.size.width )
    {
        self.page.currentPage = 1;
    }
    else if(self.imgScroll.contentOffset.x >= 0 )
    {
        self.page.currentPage = 0;
    }

}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
