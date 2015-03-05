//
//  SendStatuViewController.m
//  SinaWeiBo
//
//  Created by William-zhang on 15/2/9.
//  Copyright (c) 2015年 LMZ. All rights reserved.
//

#import "SendStatuViewController.h"
#import "Statu.h"
#import "StatuRequest.h"
#import "RequestStatuParma.h"
#import "AppDelegate.h"
#import "VisibleViewController.h"
#import "LRWWeiBoKeyBoardToolBar.h"
#import "LRWSearchTableViewController.h"
#import "LRWPhotoAlbumViewController.h"
#import <CoreLocation/CoreLocation.h>


#define BUTTONHEIGHT 25
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@interface SendStatuViewController ()<LRWWeiBoKeyBoardToolBarDelegate, VisibleViewControllerDelegate, LRWSearchTableViewControllerDelegate, StatuRequestDelegate,LRWPhotoAlbumViewControllerDelegate, CLLocationManagerDelegate>
{
    //定位按钮
    UIButton* _locationButton;
    //可见性按钮
    UIButton* _visibleButton;
    //image对象数组
    NSMutableArray* _imageObjects;
    
    UILabel* _locationLabel;
    
    UILabel* _visibleLabel;
    
    UIImageView* _imgView;
    UIImage* _statuImage;
    
    LRWWeiBoKeyBoardToolBar* _toolBar;
    
    UIImageView* _visibleImg;
    
    //定位管理器
    CLLocationManager *_locationManager;
    //经度坐标
    float _longtitude;
    //纬度
    float _latitude;
    
    RequestStatuParma* parma;
    
}
@end

@implementation SendStatuViewController

-(instancetype)init
{
    if (self = [super init]) {
        self.send = @selector(sendStatu);
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"发微博";
    self.placeholderText = @"分享新鲜事...";
    self.visible = 0;
    UIView* view = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 80, SCREEN_WIDTH, 80)];
//    view.backgroundColor = [UIColor blackColor];

    AppDelegate* ad = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    parma = [[RequestStatuParma alloc]initWithAccess_token:ad.currentAccessToken];

    
    _locationButton = [[UIButton alloc]initWithFrame:CGRectMake(10, 0, 90, BUTTONHEIGHT)];
    [_locationButton  addTarget:self action:@selector(location:) forControlEvents:UIControlEventTouchUpInside];
//    [_locationButton setTitle:@"显示位置" forState:UIControlStateNormal];
    _locationButton.backgroundColor = [UIColor colorWithRed:250/255.0 green:250/255.0 blue:250/255.0 alpha:1];
//    [_locationButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    _locationButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _locationButton.layer.borderWidth = 0.5;
    _locationButton.layer.cornerRadius = BUTTONHEIGHT/2;
//    _locationButton.titleLabel.font = [UIFont systemFontOfSize:14];
    
    _locationLabel = [[UILabel alloc]initWithFrame:CGRectMake(25, 0, 80, BUTTONHEIGHT)];
    _locationLabel.text = @"显示位置";
    _locationLabel.font = [UIFont systemFontOfSize:14];
    _locationLabel.textColor = [UIColor lightGrayColor];
    [_locationButton addSubview:_locationLabel];
    
    
    UIImageView* locationImg = [[UIImageView alloc]initWithFrame:CGRectMake(5, 2, 20, 20)];
    locationImg.image = [UIImage imageNamed:@"wl_location"];
    [_locationButton addSubview:locationImg];
    [view addSubview:_locationButton];
    
    _visibleButton = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 70, 0, 60, BUTTONHEIGHT)];
//    [_visibleButton setTitle:@"公开" forState:UIControlStateNormal];
    _visibleButton.backgroundColor = [UIColor colorWithRed:250/255.0 green:250/255.0 blue:250/255.0 alpha:1];
//    [_visibleButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    _visibleButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _visibleButton.layer.borderWidth = 0.5;
    _visibleButton.layer.cornerRadius = BUTTONHEIGHT/2;
    _visibleButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [_visibleButton addTarget:self action:@selector(pushToVisibleViewController) forControlEvents:UIControlEventTouchUpInside];
    
    _visibleLabel = [[UILabel alloc]initWithFrame:CGRectMake(25, 0, 80, BUTTONHEIGHT)];
    _visibleLabel.text = @"公开";
    _visibleLabel.font = [UIFont systemFontOfSize:14];
    _visibleLabel.textColor = [UIColor colorWithRed:78/255.0 green:124/255.0 blue:177/255.0 alpha:1];
    [_visibleButton addSubview:_visibleLabel];
    _visibleImg = [[UIImageView alloc]initWithFrame:CGRectMake(5, 2, 20, 20)];
    _visibleImg.image = [UIImage imageNamed:@"wl_earth"];
    [_visibleButton addSubview:_visibleImg];

    
    
    _toolBar = [[LRWWeiBoKeyBoardToolBar alloc]initWithFrame:CGRectMake(0, BUTTONHEIGHT+10, SCREEN_WIDTH, 44)];
    _toolBar.delegateToWeiBoKeyBoardToolBar = self;
    [view addSubview:_visibleButton];
    [view addSubview:_toolBar];
    self.bottomView = view;
    
    _imgView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 200, 100, 100)];
    [self.view addSubview:_imgView];
}

#pragma mark- 发微博
-(void)sendStatu
{
    NSLog(@"发微博");
    parma.visible = [NSString stringWithFormat:@"%ld",_visible];
    parma.status = self.textView.text;
    StatuRequest* request = [[StatuRequest alloc]init];
    request.delegate = self;
    if (_statuImage) {
        parma.pic = UIImageJPEGRepresentation(_statuImage, 1.0);
        [request UploadWriteWithPramas:parma];
    }
    else
    {
        [request UpdateWriteWithPramas:parma];
    }
    [super goBack];
}

#pragma mark - 设置当前位置
-(void)location:(id)sender
{
    if(_latitude >= 0)
        parma.lat = [NSString stringWithFormat:@"+%f",_latitude ];
    else
        parma.lat = [NSString stringWithFormat:@"%f",_latitude ];
    
    if(_longtitude >= 0)
        parma.Long = [NSString stringWithFormat:@"+%f",_longtitude ];
    else
        parma.Long = [NSString stringWithFormat:@"%f",_longtitude ];


    _locationLabel.textColor = [UIColor colorWithRed:78/255.0 green:124/255.0 blue:177/255.0 alpha:1];
    _locationLabel.text = @"已定位";
}

#pragma mark - 发微博代理方法实现
-(void)didfinishedUpdateWithError:(NSError *)error
{
    if (!error) {
        NSLog(@"微博发送成功");
    }
    else
    {
        NSLog(@"微博发送失败:%@",error);
    }
}

-(void)didfinishedUploadWithError:(NSError *)error
{
    if (!error) {
        NSLog(@"微博发送成功");
    }
    else
    {
        NSLog(@"微博发送失败:%@",error);
    }
}

#pragma mark - toolbar的代理方法实现
-(void)weiBoKeyBoardToolBar:(LRWWeiBoKeyBoardToolBar *)toolBar didClickItem:(NSInteger)index isShowEmojiIcon:(BOOL)isShow
{
    NSLog(@"%ld",index);
    if (index == 0) {
        LRWSearchTableViewController* s = [[LRWSearchTableViewController alloc]initWithType:LRWSearchTypeAt];
        s.delegate = self;
        
        [self presentViewController:[[UINavigationController alloc]initWithRootViewController:s] animated:YES completion:nil];
    }
    else if(index == 1)
    {
        
    }
    else if(index == 3)
    {
        LRWPhotoAlbumViewController* pac = [[LRWPhotoAlbumViewController alloc]init];
        pac.view.backgroundColor = pac.view.backgroundColor;
        pac.delegate = self;
        [self presentViewController:pac animated:YES completion:nil];
    }
}

-(void)weiBoKeyBoardToolBar:(LRWWeiBoKeyBoardToolBar *)toolBar didClickEmoji:(NSString *)emoji
{
    self.textView.text = [NSString stringWithFormat:@"%@%@",self.textView.text,emoji];
    [self hiddenPlaceholderText];
}

-(void)weiBoKeyBoardToolBarDidClickDeleteBtn:(LRWWeiBoKeyBoardToolBar *)toolBar
{
    NSRange leftRange = [self.textView.text rangeOfString:@"[" options:NSBackwardsSearch];
    NSRange rightRange = [self.textView.text rangeOfString:@"]" options:NSBackwardsSearch];
    if (leftRange.length>0&&rightRange.length>0) {
//        NSLog(@"删除表情");
        NSRange range = NSMakeRange(leftRange.location, rightRange.location - leftRange.location+1);
        NSMutableString* text = [NSMutableString stringWithString:self.textView.text];
        [text deleteCharactersInRange:range];
        self.textView.text = text;
        if (self.textView.text.length == 0) {
            [self displayPlaceholderText];
        }
    }
    else
    {
//        NSLog(@"找不到表情，删除文字");
        [self.textView deleteBackward];
    }
}

#pragma mark - PhotoAlbumViewController代理实现
-(void)photoAlbumViewController:(LRWPhotoAlbumViewController *)controller didClickNextBtnImages:(NSArray *)images{
    [controller dismissViewControllerAnimated:YES completion:nil];
    _statuImage = (UIImage*)images[0];
    _imgView.image = _statuImage;
}

-(void)photoAlbumViewControllerDidClickCancelBtn:(LRWPhotoAlbumViewController *)controller
{
    [controller dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - search的代理实现
-(void)searchTableViewController:(LRWSearchTableViewController *)viewController didClickCell:(UITableViewCell *)cell searchType:(LRWSearchType)searchType
{
//    NSLog(@"%@",cell.textLabel.text);
    self.textView.text = [NSString stringWithFormat:@"%@%@",self.textView.text,cell.textLabel.text];
    [self hiddenPlaceholderText];
    [viewController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 可见性选项视图
-(void)pushToVisibleViewController
{
    VisibleViewController* vvc = [[VisibleViewController alloc]init];
    vvc.delegate = self;
    vvc.visible = self.visible;
    [self presentViewController:vvc animated:YES completion:nil];
}

#pragma mark - VisibleViewController代理实现
-(void)itemDidClicked:(NSInteger)index
{
//    NSLog(@"可见性：%ld",index);
    _visible = index;
    switch (_visible) {
        case 0:
            _visibleLabel.text = @"公开";
            _visibleImg.image = [UIImage imageNamed:@"wl_earth"];
            _visibleButton.frame = CGRectMake(SCREEN_WIDTH - 70, 0, 60, BUTTONHEIGHT);
            break;
        case 1:
            _visibleLabel.text = @"仅自己可见";
            _visibleImg.image = [UIImage imageNamed:@"wl_myself"];

            _visibleButton.frame = CGRectMake(SCREEN_WIDTH - 115, 0, 105, BUTTONHEIGHT);
            break;
        case 2:
            _visibleLabel.text = @"好友圈";
            _visibleImg.image = [UIImage imageNamed:@"wl_firends"];
            _visibleButton.frame = CGRectMake(SCREEN_WIDTH - 90, 0, 80, BUTTONHEIGHT);
            break;
        default:
            break;
    }
}

#pragma mark - 图片set方法
-(void)setImages:(NSArray *)images
{
    _images = images;
    for (NSString* url in images) {
        UIImage* img = [[UIImage alloc]initWithContentsOfFile:url];
        [_imageObjects addObject:img];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //    定位
    _locationManager = [[CLLocationManager alloc]init];
    if ([CLLocationManager locationServicesEnabled]) {
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        _locationManager.distanceFilter = 50;
        _locationManager.delegate = self;
        [_locationManager startUpdatingLocation];
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *location = [locations lastObject];
    _longtitude = location.coordinate.longitude;
    _latitude = location.coordinate.latitude;
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
