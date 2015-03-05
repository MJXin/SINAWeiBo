//
//  LRWGetAllImagesOrVideosFromIPhone.m
//  SinaWeiBo
//
//  Created by lrw on 15/2/5.
//  Copyright (c) 2015年 LRW. All rights reserved.
//

#import "LRWGetAllImagesOrVideosFromIPhone.h"

@implementation LRWGetAllImagesOrVideosFromIPhone

- (void)getData
{
    ALAssetsLibrary *assetsLibrary = [[ALAssetsLibrary alloc]init];//生成整个photolibrary句柄的实例
    //NSMutableArray *mediaArray = [[NSMutableArray alloc]init];//存放media的数组
    [assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {//获取所有group
        [group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {//从group里面
            NSString* assetType = [result valueForProperty:ALAssetPropertyType];
            if ([assetType isEqualToString:ALAssetTypePhoto]) {
                //NSLog(@"Photo");
               // UIImage *image=[UIImage imageWithCGImage:result.thumbnail];
               // NSLog(@"%@",NSStringFromCGSize(image.size));
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
    } failureBlock:^(NSError *error) {
        NSLog(@"Enumerate the asset groups failed.");
    }];
}
- (NSMutableArray *)imagesArray
{
    if (!_imagesArray) {
        _imagesArray = [[NSMutableArray alloc] init];
    }
    return _imagesArray;
}
@end
