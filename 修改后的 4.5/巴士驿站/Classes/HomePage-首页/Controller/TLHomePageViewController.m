//
//  TLHomePageViewController.m
//  巴士驿站
//
//  Created by Edge on 16/7/10.
//  Copyright © 2016年 Edge. All rights reserved.
//

#import "TLHomePageViewController.h"
//#import "XRCarouselView.h"
#import "Masonry.h"
#import "TLSearchTableViewController.h"
#import "AddressPickerDemo.h"
#import "NiceCalendarController.h"
#import "TranstionScrollView.h"
@interface TLHomePageViewController ()//<XRCarouselViewDelegate>

//顶部的动态滚动广告
//@property(nonatomic,strong)TranstionScrollView * vi;

//出发地
@property(nonatomic,strong)UILabel *startLabel;

//目的地
@property(nonatomic,strong)UILabel *destinationLabel;

//出发地按钮
@property(nonatomic,strong)UIButton *startButton;

//目的地按钮
@property(nonatomic,strong)UIButton *destinationButton;

//中间箭头图标
@property(nonatomic,strong)UIImageView *arrowImageView;

//向左选择时间
@property(nonatomic,strong)UIButton *leftButton;

//向右选择时间
@property(nonatomic,strong)UIButton *rightButton;

//时间
@property(nonatomic,strong)UIButton *dateButton;

//查询
@property(nonatomic,strong)UIButton *searchButton;

@property(nonatomic,strong)NSMutableArray *dateList;

@property(nonatomic,assign)NSInteger number;

//@property(nonatomic,weak)UITableView *tableView;
@end

@implementation TLHomePageViewController

- (void)viewDidLoad {
//    self.tabBarItem.tag = 1;
//    NSLog(@"%ld",(long)self.tabBarItem.tag);
    [super viewDidLoad];
    //  设置CGRectZero从导航栏下开始计算
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    self.navigationItem.title = @"首页";
   //  self.navigationController.navigationBar.translucent = YES;
 //    [self addTableView];
    //  self.automaticallyAdjustsScrollViewInsets = NO;
    
        [self addScrlllView];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.number = 0;
      [self setAllChildController];
    
    
    NSLog(@"is here");
   }
-(void)addScrlllView{
   ;
    TranstionScrollView * ScrollView =[[TranstionScrollView alloc]initWithFrame:CGRectMake(0,0,self.view.bounds.size.width, 120) placeholder:[UIImage imageNamed:@"default"]];
    [self.view addSubview:ScrollView];
   // self.tableView.tableHeaderView = ScrollView;
   // ScrollView.backgroundColor = [UIColor blueColor];
    [ScrollView setSelectImageBlock:^(NSInteger index){
        NSLog(@"%ld",(long)index);
    }];
        NSArray * array = @[@"1",@"2",@"3",@"img_05"];
        [ScrollView setImageArrayWithArray:array];
    
  //  self.navigationController.navigationBar.translucent = YES;

}
//-(void)addTableView{
//    UITableView *tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
//    tableView.backgroundColor = [UIColor redColor];
//    self.tableView = tableView;
//    //  让分割线消失
//      self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//   // [self.view addSubview:tableView];
//     [self.view insertSubview:self.tableView atIndex:0];
//}
/**
 *  设置添加所有控件的函数
 */
-(void)setAllChildController
{
    //获取当前日期
    NSDateFormatter *dataFormatter = [[NSDateFormatter alloc] init];
    [dataFormatter setDateFormat:@"YYYY年MM月dd日"];
    NSString *strDate = [dataFormatter stringFromDate:[NSDate date]];
//    //获取星期几
//    NSDateComponents *componets = [[NSCalendar autoupdatingCurrentCalendar] components:NSCalendarUnitWeekday fromDate:[NSDate date]];
//    NSInteger weekday = [componets weekday];//a就是星期几，1代表星期日，2代表星期一，后面依次
//    NSArray *weekArray = @[@"星期日",@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六"];
//    NSString *weekStr = weekArray[weekday-1];
//    NSString *week = [strDate stringByAppendingString:[@" " stringByAppendingString: weekStr ]];
//    
    self.startLabel = [[UILabel alloc] init];
    self.startLabel.text = @"初始地";
    self.startLabel.textAlignment = NSTextAlignmentCenter;
    self.startLabel.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:20];
    [self.view addSubview:self.startLabel];
    
    self.destinationLabel = [[UILabel alloc] init];
    self.destinationLabel.text = @"目的地";
    self.destinationLabel.textAlignment = NSTextAlignmentCenter;
     self.destinationLabel.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:20];
    [self.view addSubview:self.destinationLabel];
    
    self.startButton = [self setButton:self.startButton image:nil selectimage:nil str:@"北京市"];
    self.startButton.titleLabel.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:25];
    
    [self.startButton addTarget:self action:@selector(startButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.startButton];
    
    self.destinationButton = [self setButton:self.destinationButton image:nil selectimage:nil str:@"上海市"];
    self.destinationButton.titleLabel.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:25];
    
    [self.destinationButton addTarget:self action:@selector(destinationButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.destinationButton];
    
    self.arrowImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"切片"]];
    [self.arrowImageView sizeToFit];
    [self.view addSubview:self.arrowImageView];
    
    self.leftButton = [self setButton:self.leftButton image:[UIImage imageNamed:@"previous"] selectimage:[UIImage imageNamed:@"previousDisable"] str:nil];
    [self.leftButton addTarget:self action:@selector(leftButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.leftButton];
    
    self.rightButton = [self setButton:self.rightButton image:[UIImage imageNamed:@"next"] selectimage:[UIImage imageNamed:@"nextDisable"] str:nil];
    [self.rightButton addTarget:self action:@selector(rightButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.rightButton];
    
    self.dateButton = [self setButton:self.dateButton image:nil selectimage:nil str:strDate];
    self.dateButton.titleLabel.font = [UIFont systemFontOfSize:18.0];
    [self.view addSubview:self.dateButton];
    [self.dateButton addTarget:self action:@selector(clickDataButton) forControlEvents:UIControlEventTouchUpInside];
    
    self.searchButton = [self setButton:self.searchButton image:nil selectimage:nil str:@"查询"];
    [self.searchButton setBackgroundImage:[UIImage imageNamed:@"login_btn_blue_nor"] forState:UIControlStateNormal];
    [self.searchButton setBackgroundImage:[UIImage imageNamed:@"login_btn_blue_press"] forState:UIControlStateSelected];
    [self.searchButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.searchButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [self.searchButton addTarget:self action:@selector(searchButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.searchButton];
    
    [self.startLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).with.offset(145);
        make.right.equalTo(self.destinationLabel.mas_left).with.offset(-100);
        make.bottom.equalTo(self.startButton.mas_top).with.offset(-30);
        make.left.equalTo(self.view.mas_left).with.offset(40);
        make.width.equalTo(self.destinationLabel);
    }];
    [self.destinationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).with.offset(145);
        make.right.equalTo(self.view.mas_right).with.offset(-40);
        make.bottom.equalTo(self.destinationButton.mas_top).with.offset(-30);
        make.left.equalTo(self.startLabel.mas_right).with.offset(100);
        make.width.equalTo(self.startLabel);
        
    }];
    [self.arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.startLabel.mas_bottom);
        make.height.equalTo(@40);
        make.width.equalTo(@50);
        
    }];
    
    [self.startButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.startLabel.mas_bottom).with.offset(30);
        make.left.equalTo(self.view.mas_left).with.offset(15);
        make.right.equalTo(self.arrowImageView.mas_left).with.offset(-20);
        make.height.equalTo(@50);
        make.width.equalTo(self.destinationButton);
    }];
    
    [self.destinationButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.destinationLabel.mas_bottom).with.offset(30);
        make.left.equalTo(self.arrowImageView.mas_right).with.offset(20);
        make.right.equalTo(self.view.mas_right).with.offset(-15);
        make.height.equalTo(@50);
        make.width.equalTo(self.destinationButton);
    }];
    
    [self.leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(15);
        make.right.equalTo(self.dateButton.mas_left).with.offset(-10);
        make.top.equalTo(self.startButton.mas_bottom).with.offset(20);
        make.height.equalTo(@30);
        make.width.equalTo(@30);
    }];
    
    [self.rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.mas_right).with.offset(-15);
        make.left.equalTo(self.dateButton.mas_right).with.offset(10);
        make.top.equalTo(self.destinationButton.mas_bottom).with.offset(20);
        make.height.equalTo(@30);
        make.width.equalTo(@30);
    }];
    
    [self.dateButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.rightButton.mas_left).with.offset(-10);
        make.left.equalTo(self.leftButton.mas_right).with.offset(10);
        make.centerY.equalTo(self.leftButton);
        make.height.equalTo(@40);
    }];
    
    [self.searchButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.dateButton.mas_bottom).with.offset(20);
        make.left.equalTo(self.view.mas_left).with.offset(10);
        make.right.equalTo(self.view.mas_right).with.offset(-10);
        make.height.equalTo(@40);
    }];
    
}
/**
 *  自定义按钮创建函数
 *
 *  @param button      按钮
 *  @param image       正常状态下按钮图片
 *  @param selectimage 被选择状态下按钮图片
 *  @param string      按钮上的文字
 *
 *  @return UIButton
 */
-(UIButton *)setButton:(UIButton *)button image:(UIImage *)image selectimage:(UIImage *)selectimage str:(NSString *)string
{
    button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:string forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setImage:image forState:UIControlStateNormal];
    [button setImage:selectimage forState:UIControlStateSelected];
    [button sizeToFit];
    return button;
}

/**
 *  点击时间按钮
 */
-(void)clickDataButton{
    
    NiceCalendarController *Calendar = [[NiceCalendarController alloc]init];
    Calendar.DateBlock = ^(NSString *str){
        //  date->string
//        NSDateFormatter *format = [[NSDateFormatter alloc]init];
//        [format setDateFormat:@"yyyy-MM-dd"];
//        NSString *date = [format stringFromDate:str];
    [self.dateButton setTitle:str forState:UIControlStateNormal];
  
    };
    [self.navigationController pushViewController:Calendar animated:YES];
}
/**
 *  出发地按钮响应的事件
 */
-(void)startButtonPressed
{
    AddressPickerDemo *siteView = [[AddressPickerDemo alloc] init];
    siteView.siteBlock  = ^(NSString *str){
        [self.startButton setTitle:str forState:UIControlStateNormal];
    };

    [self.navigationController pushViewController:siteView animated:YES];
    
}
/**
 *  目的地按钮响应的事件
 */

-(void)destinationButtonPressed
{
    //TLSiteTableViewController *siteView = [[TLSiteTableViewController alloc] init];
    AddressPickerDemo *siteView = [[AddressPickerDemo alloc] init];

    siteView.siteBlock  = ^(NSString *str){
        [self.destinationButton setTitle:str forState:UIControlStateNormal];
    };
    
//    [self.navigationController pushViewController:siteView animated:YES];
    [self.navigationController pushViewController:siteView animated:YES];
}

-(void)searchButtonPressed
{
    TLSearchTableViewController *searchView = [[TLSearchTableViewController alloc] init];
    //  跳转隐藏tabBar
     searchView.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:searchView animated:YES];
}

-(void)leftButtonPressed
{
        //获取当前日期
        NSDateFormatter *dataFormatter = [[NSDateFormatter alloc] init];
        [dataFormatter setDateFormat:@"YYYY年MM月dd日"];
        NSString *strDate = [dataFormatter stringFromDate:[NSDate dateWithTimeIntervalSinceNow:-(24*60*60)]];
//        //获取星期几
//        NSDateComponents *componets = [[NSCalendar autoupdatingCurrentCalendar] components:NSCalendarUnitWeekday fromDate:[NSDate date]];
//        NSInteger weekday = [componets weekday];//a就是星期几，1代表星期日，2代表星期一，后面依次
//        NSArray *weekArray = @[@"星期日",@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六"];
//        NSString *weekStr = weekArray[weekday-2];
//        NSString *week = [strDate stringByAppendingString:[@" " stringByAppendingString: weekStr ]];
        NSLog(@"%@",strDate);
        [self.dateButton setTitle:strDate forState:UIControlStateNormal];

    
//
//    if (self.number>0) {
//        self.number--;
//        [self.dateButton setTitle:[self.dateList objectAtIndex:self.number] forState:UIControlStateNormal];
//    }
    
}

-(void)rightButtonPressed
{
    //获取当前日期
    NSDateFormatter *dataFormatter = [[NSDateFormatter alloc] init];
    [dataFormatter setDateFormat:@"YYYY年MM月dd日"];
    NSString *strDate = [dataFormatter stringFromDate:[NSDate dateWithTimeIntervalSinceNow:+(24*60*60)]];
    //获取星期几
//    NSDateComponents *componets = [[NSCalendar autoupdatingCurrentCalendar] components:NSCalendarUnitWeekday fromDate:[NSDate date]];
//    NSInteger weekday = [componets weekday];//a就是星期几，1代表星期日，2代表星期一，后面依次
//    NSArray *weekArray = @[@"星期日",@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六"];
//    NSString *weekStr = weekArray[weekday];
//    NSString *week = [strDate stringByAppendingString:[@" " stringByAppendingString: weekStr ]];
    NSLog(@"%@",strDate);
    [self.dateButton setTitle:strDate forState:UIControlStateNormal];
    

}

















@end
