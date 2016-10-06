//
//  TLMapViewController.m
//  巴士驿站
//
//  Created by mac on 16/9/12.
//  Copyright © 2016年 Edge. All rights reserved.
//

//常量
#define kWidth [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height


#import "TLMapViewController.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import "TLMapSiteTableViewController.h"
#import "Masonry.h"
@interface TLMapViewController ()<MAMapViewDelegate,AMapSearchDelegate,UISearchBarDelegate,UISearchResultsUpdating,UIGestureRecognizerDelegate>

@property (nonatomic, strong) UISearchController *searchController;

@property (nonatomic,retain) AMapSearchAPI *search;

@property (nonatomic,retain) NSString *currentCity;

@property (nonatomic,retain) UILongPressGestureRecognizer *longPressGesture;//长按手势

@property (nonatomic,retain) NSArray *pathPolylines;

@property(nonatomic,weak)UIButton *button;
@end

@implementation TLMapViewController
//常量
#pragma mark 地图显示和定位
-(void)initMapView{
    
    if (self.mapView == nil)
    {
        self.mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
        [self.mapView setDelegate:self];
        
        [self.view insertSubview:self.mapView atIndex:0];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"地图";
    self.navigationItem.title = @"地图";
    [self initMapView];
    _mapView.showsUserLocation = YES;    //YES 为打开定位，NO为关闭定位
    
    [_mapView setUserTrackingMode: MAUserTrackingModeFollow animated:YES];
  
    _mapView.allowsBackgroundLocationUpdates = YES;
   
    _mapView.pausesLocationUpdatesAutomatically = NO;//  允许后台定位
    
    [self addjumpButton];
   // [self addRouteButton];
}
#pragma mark 添加跳转按钮
-(void)addjumpButton{
    
    UIButton *jumpButton =[[UIButton alloc]init];//WithFrame:CGRectMake(0, 64.0, kWidth, 44.0)];
    self.button=jumpButton;
    [jumpButton setBackgroundColor:[UIColor clearColor]];
    [jumpButton setBackgroundImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
    //self.navigationItem.titleView = button;
    [self.view addSubview:jumpButton];
    [jumpButton addTarget:self action:@selector(addButtonJumpForSearch) forControlEvents:UIControlEventTouchUpInside];
    [jumpButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(0);
        make.right.equalTo(self.view).offset(0);
        make.top.mas_equalTo(self.view).offset(64);
        make.height.mas_equalTo(44);
    }];
}

//#pragma mark 添加路线按钮
//-(void)addRouteButton{
//    UIButton *routeButton = [[UIButton alloc]init];
//    [routeButton setTitle:@"查看路线" forState:UIControlStateNormal];
//    routeButton.titleLabel.font = [UIFont systemFontOfSize:15];
//     [routeButton setBackgroundColor:[UIColor redColor]];
//    [self.view addSubview:routeButton];
//    [routeButton addTarget:self action:@selector(addButtonJumpForSearch) forControlEvents:UIControlEventTouchUpInside];
//    [routeButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        //make.left.equalTo(self.view).offset(0);
//       // make.right.equalTo(self.view).offset(0);
//        make.bottom.mas_equalTo(self.view).offset(50);
//        make.height.mas_equalTo(30);
//       // make.centerX.mas_equalTo(self.view);
//        make.width.mas_equalTo(50);
//    }];
//
//}

#pragma mark 添加返回原点按钮
-(void)addButtonJumpForSearch{
    
    TLMapSiteTableViewController *searchView = [[TLMapSiteTableViewController alloc]init];
    //
    [self.navigationController pushViewController:searchView animated:YES];
   //   [self presentViewController:searchView animated:YES completion:nil];
}
#pragma mark 大头针
- (MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id <MAOverlay>)overlay
{
    /* 自定义定位精度对应的MACircleView. */
//    if (overlay == mapView.userLocation)
//    {
//        MACircleRenderer *accuracyCircleRenderer = [[MACircleRenderer alloc] initWithCircle:overlay];
//        
//        accuracyCircleRenderer.lineWidth    = 2.f;
//        accuracyCircleRenderer.strokeColor  = [UIColor lightGrayColor];
//        accuracyCircleRenderer.fillColor    = [UIColor colorWithRed:1 green:0 blue:0 alpha:.3];
//        
//        return accuracyCircleRenderer;
//    }
    //画路线
    if ([overlay isKindOfClass:[MAPolyline class]])
    {
        
        MAPolylineRenderer *polygonView = [[MAPolylineRenderer alloc] initWithPolyline:overlay];
        
        polygonView.lineWidth = 8.f;
        polygonView.strokeColor = [UIColor colorWithRed:0.015 green:0.658 blue:0.986 alpha:1.000];
        polygonView.fillColor = [UIColor colorWithRed:0.940 green:0.771 blue:0.143 alpha:0.800];
        polygonView.lineJoin = kCGLineJoinRound;//连接类型
        
        return polygonView;
    }
    return nil;

}

//添加大头针
-(void)addAnnotation{
    MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc]init];
    //  设置经纬度
    pointAnnotation.coordinate = CLLocationCoordinate2DMake(_currentPOI.location.latitude, _currentPOI.location.longitude);
    //  大头针上显示名字
    pointAnnotation.title = _currentPOI.name;
    //  显示地址
    pointAnnotation.subtitle = _currentPOI.address;
    [_mapView addAnnotation:pointAnnotation];
    [_mapView selectAnnotation:pointAnnotation animated:YES];
    
}


//大头针的回调
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation
{
    
    /* 自定义userLocation对应的annotationView. */
    if ([annotation isKindOfClass:[MAUserLocation class]])
    {
        static NSString *userLocationStyleReuseIndetifier = @"userLocationStyleReuseIndetifier";
        MAAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:userLocationStyleReuseIndetifier];
        if (annotationView == nil)
        {
            annotationView = [[MAAnnotationView alloc] initWithAnnotation:annotation
                                                          reuseIdentifier:userLocationStyleReuseIndetifier];
        }
        annotationView.image = [UIImage imageNamed:@"userPosition"];
        
        return annotationView;
    }
    
    //大头针
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *pointReuseIndentifier = @"pointReuseIndentifier";
        MAPinAnnotationView*annotationView = (MAPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndentifier];
        if (annotationView == nil)
        {
            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndentifier];
        }
        annotationView.canShowCallout= YES;       //设置气泡可以弹出，默认为NO
        annotationView.animatesDrop = YES;        //设置标注动画显示，默认为NO
        annotationView.draggable = YES;        //设置标注可以拖动，默认为NO
        annotationView.pinColor = MAPinAnnotationColorPurple;
        
        return annotationView;
    }
    return nil;
}


#pragma mark 定位更新回调
-(void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation
updatingLocation:(BOOL)updatingLocation
{
    if(updatingLocation)
    {
        //取出当前位置的坐标
        //        NSLog(@"latitude : %f,longitude: %f",userLocation.coordinate.latitude,userLocation.coordinate.longitude);
    }
    _currentLocation = [userLocation.location copy];
}
- (void)cancelAllRequests{
    
    NSLog(@"error");
}
@end
