//
//  TLOrderDetailTableViewCell.h
//  巴士驿站
//
//  Created by 胡潇炜 on 16/7/13.
//  Copyright © 2016年 Edge. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TLSiteDetailView.h"
#import "TLPassengerDetailView.h"
#import "TLStationDetailView.h"

@interface TLOrderDetailTableViewCell : UITableViewCell

@property(nonatomic,strong)UILabel *timeLabel;

@property(nonatomic,strong)TLSiteDetailView *siteDetailView;

@property(nonatomic,strong)UILabel *passengerLabel;

@property(nonatomic,strong)TLPassengerDetailView *passengerDetailView;

@property(nonatomic,strong)UILabel *stationLabel;

@property(nonatomic,strong)TLStationDetailView *stationDetailView;


@end
