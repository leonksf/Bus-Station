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
@interface TLMapViewController ()<MAMapViewDelegate,AMapSearchDelegate,UIGestureRecognizerDelegate>

@property (nonatomic, strong) UISearchController *searchController;

//@property (nonatomic,retain) AMapSearchAPI *search;

@property (nonatomic,retain) NSString *currentCity;

@property (nonatomic,retain) UILongPressGestureRecognizer *longPressGesture;//长按手势

@property (nonatomic,retain) NSArray *pathPolylines;

@property(nonatomic,weak)UIButton *button;
@end

@implementation TLMapViewController
//常量
#pragma mark 地图显示和定位
-(NSArray *)pathPolylines{
    
    if (!_pathPolylines) {
        
        _pathPolylines = [NSArray array];
    }
    return _pathPolylines;
}

-(void)initMapView{
    
    if (self.mapView == nil)
    {
        self.mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
        [self.mapView setDelegate:self];
        _mapView.showsUserLocation = YES;    //YES 为打开定位，NO为关闭定位
        
        [_mapView setUserTrackingMode: MAUserTrackingModeFollow animated:NO];
        
        _mapView.allowsBackgroundLocationUpdates = YES;
        
        _mapView.pausesLocationUpdatesAutomatically = NO;//  允许后台定位
        [self.view insertSubview:self.mapView atIndex:0];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"地图";
    self.navigationItem.title = @"地图";
    [self initMapView];
   
    [self addGesture];
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

//#pragma mark 大头针
//- (MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id <MAOverlay>)overlay
//{
//    /* 自定义定位精度对应的MACircleView. */
////    if (overlay == mapView.userLocation)
////    {
////        MACircleRenderer *accuracyCircleRenderer = [[MACircleRenderer alloc] initWithCircle:overlay];
////        
////        accuracyCircleRenderer.lineWidth    = 2.f;
////        accuracyCircleRenderer.strokeColor  = [UIColor lightGrayColor];
////        accuracyCircleRenderer.fillColor    = [UIColor colorWithRed:1 green:0 blue:0 alpha:.3];
////        
////        return accuracyCircleRenderer;
////    }
//    //画路线
//    if ([overlay isKindOfClass:[MAPolyline class]])
//    {
//        
//        MAPolylineRenderer *polygonView = [[MAPolylineRenderer alloc] initWithPolyline:overlay];
//        
//        polygonView.lineWidth = 8.f;
//        polygonView.strokeColor = [UIColor colorWithRed:0.015 green:0.658 blue:0.986 alpha:1.000];
//        polygonView.fillColor = [UIColor colorWithRed:0.940 green:0.771 blue:0.143 alpha:0.800];
//        polygonView.lineJoin = kCGLineJoinRound;//连接类型
//        
//        return polygonView;
//    }
//    return nil;
//
//}
//
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


////大头针的回调
//- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation
//{
//    
//    /* 自定义userLocation对应的annotationView. */
//    if ([annotation isKindOfClass:[MAUserLocation class]])
//    {
//        static NSString *userLocationStyleReuseIndetifier = @"userLocationStyleReuseIndetifier";
//        MAAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:userLocationStyleReuseIndetifier];
//        if (annotationView == nil)
//        {
//            annotationView = [[MAAnnotationView alloc] initWithAnnotation:annotation
//                                                          reuseIdentifier:userLocationStyleReuseIndetifier];
//        }
//        annotationView.image = [UIImage imageNamed:@"userPosition"];
//        
//        return annotationView;
//    }
//    
//    //大头针
//    if ([annotation isKindOfClass:[MAPointAnnotation class]])
//    {
//        static NSString *pointReuseIndentifier = @"pointReuseIndentifier";
//        MAPinAnnotationView*annotationView = (MAPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndentifier];
//        if (annotationView == nil)
//        {
//            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndentifier];
//        }
//        annotationView.canShowCallout= YES;       //设置气泡可以弹出，默认为NO
//        annotationView.animatesDrop = YES;        //设置标注动画显示，默认为NO
//        annotationView.draggable = YES;        //设置标注可以拖动，默认为NO
//        annotationView.pinColor = MAPinAnnotationColorPurple;
//        
//        return annotationView;
//    }
//    return nil;
//}

//
#pragma mark 定位更新回调
-(void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation
updatingLocation:(BOOL)updatingLocation
{
    if(updatingLocation)
    {
        //取出当前位置的坐标
        NSLog(@"%f,%f,%@",userLocation.coordinate.latitude,userLocation.coordinate.longitude,userLocation.title);
        self.currentLocation = userLocation;
        
        //构造AMapReGeocodeSearchRequest对象
        AMapReGeocodeSearchRequest *regeo = [[AMapReGeocodeSearchRequest alloc] init];
        regeo.location = [AMapGeoPoint locationWithLatitude:userLocation.coordinate.latitude longitude:userLocation.coordinate.longitude];
        
        regeo.radius = 10000;
        regeo.requireExtension = YES;
    }
    _currentLocation = [userLocation.location copy];
}

//#pragma mark -- 路径查询
////规划线路查询
//- (void)findWayAction:(id)sender {
//    //构造AMapDrivingRouteSearchRequest对象，设置驾车路径规划请求参数
//    AMapWalkingRouteSearchRequest *request = [[AMapWalkingRouteSearchRequest alloc] init];
//    //    request.origin = [AMapGeoPoint locationWithLatitude:34.223979 longitude:108.900445];
//    //    request.destination = [AMapGeoPoint locationWithLatitude:34.224113 longitude:108.900536];
//    
//    
//    request.origin = [AMapGeoPoint locationWithLatitude:_currentLocation.coordinate.latitude longitude:_currentLocation.coordinate.longitude];
//    
//    request.destination = [AMapGeoPoint locationWithLatitude:_destinationPoint.coordinate.latitude longitude:_destinationPoint.coordinate.longitude];
//    
//    
//    //    request.strategy = 2;//距离优先
//    //    request.requireExtension = YES;
//    
//    //发起路径搜索
////    [_search AMapWalkingRouteSearch: request];
//    
//    
//    //    [self drawPolygon];
//    
//}
//
//
//添加手势
- (void)addGesture
{
    //    _annotations = [NSMutableArray array];
    //    _pois = nil;
    _longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
    _longPressGesture.delegate = self;
    [_mapView addGestureRecognizer:_longPressGesture];
}

//长按手势相应
- (void)handleLongPress:(UILongPressGestureRecognizer *)gesture
{
    if (gesture.state == UIGestureRecognizerStateBegan)
    {
        CGPoint p = [gesture locationInView:_mapView];
        NSLog(@"press on (%f, %f)", p.x, p.y);
    }
    CLLocationCoordinate2D coordinate = [_mapView convertPoint:[gesture locationInView:_mapView] toCoordinateFromView:_mapView];
    
    // 添加标注
    if (_destinationPoint != nil) {
        // 清理
        [_mapView removeAnnotation:_destinationPoint];
        _destinationPoint = nil;
    }
    _destinationPoint = [[MAPointAnnotation alloc] init];
    _destinationPoint.coordinate = coordinate;
    _destinationPoint.title = @"目标点";
    [_mapView addAnnotation:_destinationPoint];
    
}

////路线解析
//- (NSArray *)polylinesForPath:(AMapPath *)path
//{
//    if (path == nil || path.steps.count == 0)
//    {
//        return nil;
//    }
//    NSMutableArray *polylines = [NSMutableArray array];
//    [path.steps enumerateObjectsUsingBlock:^(AMapStep *step, NSUInteger idx, BOOL *stop) {
//        NSUInteger count = 0;
//        CLLocationCoordinate2D *coordinates = [self coordinatesForString:step.polyline
//                                                         coordinateCount:&count
//                                                              parseToken:@";"];
//        
//        
//        MAPolyline *polyline = [MAPolyline polylineWithCoordinates:coordinates count:count];
//        
//        //          MAPolygon *polygon = [MAPolygon polygonWithCoordinates:coordinates count:count];
//        
//        [polylines addObject:polyline];
//        free(coordinates), coordinates = NULL;
//    }];
//    return polylines;
//}
//
////解析经纬度
//- (CLLocationCoordinate2D *)coordinatesForString:(NSString *)string
//                                 coordinateCount:(NSUInteger *)coordinateCount
//                                      parseToken:(NSString *)token
//{
//    if (string == nil)
//    {
//        return NULL;
//    }
//    
//    if (token == nil)
//    {
//        token = @",";
//    }
//    
//    NSString *str = @"";
//    if (![token isEqualToString:@","])
//    {
//        str = [string stringByReplacingOccurrencesOfString:token withString:@","];
//    }
//    
//    else
//    {
//        str = [NSString stringWithString:string];
//    }
//    
//    NSArray *components = [str componentsSeparatedByString:@","];
//    NSUInteger count = [components count] / 2;
//    if (coordinateCount != NULL)
//    {
//        *coordinateCount = count;
//    }
//    CLLocationCoordinate2D *coordinates = (CLLocationCoordinate2D*)malloc(count * sizeof(CLLocationCoordinate2D));
//    
//    for (int i = 0; i < count; i++)
//    {
//        coordinates[i].longitude = [[components objectAtIndex:2 * i]     doubleValue];
//        coordinates[i].latitude  = [[components objectAtIndex:2 * i + 1] doubleValue];
//    }
//    
//    
//    return coordinates;
//}
//

- (void)cancelAllRequests{
    
    NSLog(@"error");
}
@end
