//
//  StatuDetialViewController.h
//  SinaWeiBo
//
//  Created by William-zhang on 15/2/6.
//  Copyright (c) 2015年 LMZ. All rights reserved.
//

#import "LRWRefreshTableViewController.h"

@class Statu;

@interface StatuDetialViewController : LRWRefreshTableViewController

@property(nonatomic, strong)Statu* statu;

/**如果能确定statu里面的数据是完整的，请用这个初始化方法来跳到单条微博界面
 */
-(instancetype)initWithStatu:(Statu*)statu;

@end
