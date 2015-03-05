//
//  DiscoverSearchTableViewController.h
//  WBTest
//
//  Created by mjx on 15/2/6.
//  Copyright (c) 2015年 MJX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchSuggestionsRequest.h"
@interface DiscoverSearchUserTableViewController : UITableViewController<SearchSuggestionsRequestDelegate,UISearchResultsUpdating,UISearchControllerDelegate,UISearchBarDelegate>
@property (nonatomic, strong)UIViewController *preController;
@end
