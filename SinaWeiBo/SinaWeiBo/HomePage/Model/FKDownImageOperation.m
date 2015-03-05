//
//  FKPageLoadOperation.m
//  operationTest
//
//  Created by yeeku on 13-9-13.
//  Copyright (c) 2013年 crazyit.org. All rights reserved.
//

#import "FKDownImageOperation.h"

@implementation FKDownImageOperation
- (id)initWithURL:(NSURL*)url imageView:(UIImageView*)iv
{
	self = [super init];
	if (self) {
		_imageView = iv;
		_url = url;
	}
	return self;
}
// 重写main方法，该方法将作为线程执行体
- (void)main
{	
	// 从网络获取数据
	NSData *data = [[NSData alloc]
		initWithContentsOfURL:self.url];
	// 将网络数据初始化为UIImage对象
	UIImage *image = [[UIImage alloc]initWithData:data];
	if(image != nil)
	{
		// 在主线程中执行updateUI:方法
		[self performSelectorOnMainThread:@selector(updateUI:)
			withObject:image waitUntilDone:NO]; // ①
	}
	else
	{
		NSLog(@"---下载图片出现错误---");
	}
}
-(void)updateUI:(UIImage*) image
{
	self.imageView.image = image;
}
@end
