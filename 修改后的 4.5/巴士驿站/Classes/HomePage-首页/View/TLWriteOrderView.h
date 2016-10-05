//
//  TLWriteOrderView.h
//  巴士驿站
//
//  Created by Edge on 16/7/28.
//  Copyright © 2016年 Edge. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TLWriteOrderView : UIView
@property(nonatomic,strong)UILabel *busLabel;

@property(nonatomic,strong)UIImageView *startImage;

@property(nonatomic,strong)UILabel *startLabel;

@property(nonatomic,strong)UIImageView *arrowImage;

@property(nonatomic,strong)UILabel *timeLabel;

@property(nonatomic,strong)UIImageView *destinationImage;

@property(nonatomic,strong)UILabel *destinationLabel;

@property(nonatomic,strong)UILabel *startTime;

@property(nonatomic,strong)UILabel *destinationTime;

@property(nonatomic,strong)UILabel *time;

@property(nonatomic,strong)UILabel *date;

@property(nonatomic,strong)UILabel *leftTicket;

@property(nonatomic,strong)UILabel *priceLabel;

//@property(nonatomic,weak)UIView *m_headView;
@end
