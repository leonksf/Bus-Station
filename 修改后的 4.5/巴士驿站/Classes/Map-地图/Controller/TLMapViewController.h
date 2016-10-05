//
//  TLMapViewController.h
//  巴士驿站
//
//  Created by mac on 16/9/12.
//  Copyright © 2016年 Edge. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MAMapKit/MAMapKit.h>
#import <AMapSearchKit/AMapSearchKit.h>

@interface TLMapViewController : UIViewController
@property (nonatomic,retain) MAMapView *mapView;

@property (nonatomic,retain) MAUserLocation *currentLocation;

@property (nonatomic,retain) AMapPOI *currentPOI;

@property (nonatomic,retain) MAPointAnnotation *destinationPoint;//目标点

@end
