//
//  TLMapSiteTableViewController.h
//  巴士驿站
//
//  Created by Edge on 16/9/18.
//  Copyright © 2016年 Edge. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MAMapKit/MAMapKit.h>
#import<AMapSearchKit/AMapSearchKit.h>
@interface TLMapSiteTableViewController : UITableViewController
@property (nonatomic,retain) MAUserLocation *currentLocation;//当前位置

@property (nonatomic,retain) NSString *currentCity;//当前参数

//@property (nonatomic,copy) moveBlock moveBlock;

@property (nonatomic,retain) NSString *searchStr;//搜索的内容

@end
