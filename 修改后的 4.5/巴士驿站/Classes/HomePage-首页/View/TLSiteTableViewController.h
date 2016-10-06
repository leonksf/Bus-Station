//
//  TLSiteTableViewController.h
//  巴士驿站
//
//  Created by 胡潇炜 on 16/7/12.
//  Copyright © 2016年 Edge. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TLSiteTableViewController : UITableViewController

-(void)updateData:(NSMutableArray *)array;

/**
 *  定义一个block
 */
@property(nonatomic,strong)void(^siteBlock)(NSString *str);

@end
