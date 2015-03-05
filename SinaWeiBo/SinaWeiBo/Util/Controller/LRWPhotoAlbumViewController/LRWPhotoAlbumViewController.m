//
//  LRWPhotoAlbumViewController.m
//  获取系统所有图片
//
//  Created by lrw on 15/2/6.
//  Copyright (c) 2015年 LRW. All rights reserved.
//

#import "LRWPhotoAlbumViewController.h"
#import "LRWPhotoAlbumCell.h"
#import <AssetsLibrary/AssetsLibrary.h>
@interface LRWPhotoAlbumViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
{
    __weak IBOutlet UIButton *_nextBtn;
    __weak IBOutlet UICollectionView *_collectionView;
    /**{@"image" : UIImage,
        @"isSelected" : Bool}*/
    NSMutableArray *_imagesAndStatus;
    NSMutableArray *_selectedIndexPath;//存放被选中cell的位置
    NSInteger _index;//第几个图片
    NSInteger _countInRow;//一行显示多少个图片
    CGSize _screenSize;
    CGFloat _matgin;//图片间距
}
- (IBAction)nextBtnClick:(UIButton *)sender;
- (IBAction)cancelBtnClick:(id)sender;

@end

static NSString * const reuseIdentifier = @"photo_album_cell";
@implementation LRWPhotoAlbumViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    _screenSize = [[UIScreen mainScreen] bounds].size;
    _index = 0;
    _matgin = 1.5;
    _countInRow = 3.0;
    _imagesAndStatus = [NSMutableArray array];
    _selectedIndexPath = [NSMutableArray array];
    _nextBtn.layer.cornerRadius = 3.0;
    _nextBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _nextBtn.layer.borderWidth = 1.0;
    
    //collection View 属性设置
    UICollectionViewFlowLayout *flowLayout = [UICollectionViewFlowLayout new];
    CGFloat cellWidth = (_screenSize.width - (_countInRow - 1) * _matgin) / 3;
    flowLayout.itemSize = CGSizeMake(cellWidth, cellWidth);//cell大少
    flowLayout.minimumInteritemSpacing = _matgin;//cell间距
    flowLayout.minimumLineSpacing = _matgin;//行间距
    _collectionView.collectionViewLayout = flowLayout;
    _collectionView.dataSource = self;
    _collectionView.bounces = NO;
    _collectionView.delegate = self;
    //注册一个cell，以便重用
    [_collectionView registerNib:[UINib nibWithNibName:@"LRWPhotoAlbumCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:reuseIdentifier];
    
    
    ALAssetsLibrary *assetsLibrary = [[ALAssetsLibrary alloc]init];//生成整个photolibrary句柄的实例
    //NSMutableArray *mediaArray = [[NSMutableArray alloc]init];//存放media的数组
    __block int groupId = 0;
    [assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {//获取所有group
        if (groupId == 1) {
        [group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {//从group里面
            NSString* assetType = [result valueForProperty:ALAssetPropertyType];
            if ([assetType isEqualToString:ALAssetTypePhoto]) {
                //NSLog(@"Photo")
                //for (int i = 0; i < 11; i ++) {
                [self saveImage:[UIImage imageWithCGImage:result.thumbnail]];
               // }
                
            }else if([assetType isEqualToString:ALAssetTypeVideo]){
                //NSLog(@"Video");
            }else if([assetType isEqualToString:ALAssetTypeUnknown]){
                // NSLog(@"Unknow AssetType");
            }
            /*
             NSDictionary *assetUrls = [result valueForProperty:ALAssetPropertyURLs];
             NSUInteger assetCounter = 0;
             for (NSString *assetURLKey in assetUrls) {
             NSLog(@"Asset URL %lu = %@",(unsigned long)assetCounter,[assetUrls objectForKey:assetURLKey]);
             }
             NSLog(@"Representation Size = %lld",[[result defaultRepresentation]size]);
             */
        }];
        }
        groupId++;
    } failureBlock:^(NSError *error) {
        NSLog(@"Enumerate the asset groups failed.");
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - collection view delegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    LRWPhotoAlbumCell *cell = (LRWPhotoAlbumCell *)[collectionView cellForItemAtIndexPath:indexPath];
    if (cell.isAnimating) {
        return;
    }
    if (cell.chosed) {//如果被选中
        [_selectedIndexPath removeObject:indexPath];
        cell.chosed = NO;
    }
    else//如果没有选中
    {
        if (_selectedIndexPath.count >= 9) {
            //NSLog(@"最多只能选中6个");
            UIAlertView *alerView = [[UIAlertView alloc] initWithTitle:nil message:@"最多选择9张图片" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alerView show];
            return;
        }

        [_selectedIndexPath addObject:indexPath];
        cell.chosed = YES;
    }
    if (_selectedIndexPath.count > 0) {
        //显示按钮
        [_nextBtn setTitle:[NSString stringWithFormat:@"下一步(%ld)",_selectedIndexPath.count] forState:(UIControlStateNormal)];
        [_nextBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        _nextBtn.backgroundColor = [UIColor orangeColor];
        _nextBtn.layer.borderColor = [UIColor whiteColor].CGColor;
        _nextBtn.userInteractionEnabled = YES;
    }
    else
    {
        [_nextBtn setTitle:@"下一步" forState:(UIControlStateNormal)];
        [_nextBtn setTitleColor:[UIColor lightGrayColor] forState:(UIControlStateNormal)];
        _nextBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _nextBtn.backgroundColor = [UIColor clearColor];
        _nextBtn.userInteractionEnabled = NO;
    }
}
#pragma mark - collection view datasource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _imagesAndStatus.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LRWPhotoAlbumCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.imageView.image = _imagesAndStatus[indexPath.row][IMAGEKEY];
    cell.chosed = [self isInSelectedIndexPath:indexPath];
    return cell;
}

#pragma mark - 判读IndexPath是否被选中
- (BOOL)isInSelectedIndexPath:(NSIndexPath *)indePath
{
    for (NSIndexPath *aIndexPath in _selectedIndexPath) {
        if (aIndexPath.row == indePath.row && aIndexPath.section == indePath.section) {
            return YES;
        }
    }
    return NO;
}

#pragma mark - 保存图片
- (void)saveImage:(UIImage *)aImage
{
    
    [_imagesAndStatus addObject:[NSMutableDictionary dictionaryWithObjects:@[aImage,[NSNumber numberWithBool:NO]] forKeys:@[IMAGEKEY,SELECTEDKEY]]];
    [_collectionView reloadData];
    //NSIndexPath *indexPath = [NSIndexPath indexPathForRow:_imagesAndStatus.count - 1 inSection:0];
    //[_collectionView insertItemsAtIndexPaths:@[indexPath]];
}
#pragma mark - 创建cell
- (void)createCellInCollectionView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath
{
    LRWPhotoAlbumCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    if (!cell) {
        NSLog(@"创建");
    }
}
- (IBAction)nextBtnClick:(UIButton *)sender {
    NSMutableArray *images = [NSMutableArray array];
    for (NSIndexPath *indexPath  in _selectedIndexPath) {
        LRWPhotoAlbumCell *cell = (LRWPhotoAlbumCell *)[_collectionView cellForItemAtIndexPath:indexPath];
        [images addObject:cell.imageView.image];
    }
    if ([self.delegate respondsToSelector:@selector(photoAlbumViewController:didClickNextBtnImages:)]) {
        [self.delegate photoAlbumViewController:self didClickNextBtnImages:[images copy]];
    }
}

- (IBAction)cancelBtnClick:(id)sender {
    if ([self.delegate respondsToSelector:@selector(photoAlbumViewControllerDidClickCancelBtn:)])
    {
        [self.delegate photoAlbumViewControllerDidClickCancelBtn:self];
    }
}
@end
