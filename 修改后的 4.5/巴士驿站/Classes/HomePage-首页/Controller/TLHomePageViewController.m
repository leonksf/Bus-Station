//
//  TLHomePageViewController.m
//  巴士驿站
//
//  Created by Edge on 16/7/10.
//  Copyright © 2016年 Edge. All rights reserved.
//

#import "TLHomePageViewController.h"
#import "XRCarouselView.h"
#import "Masonry.h"
#import "TLSiteTableViewController.h"
#import "TLSearchTableViewController.h"

@interface TLHomePageViewController ()<XRCarouselViewDelegate>

//顶部的动态滚动广告
@property(nonatomic,strong)XRCarouselView *carouselView;

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
@end

@implementation TLHomePageViewController

-(NSMutableArray *)dateList
{
    if (!_dateList) {
        _dateList = [NSMutableArray arrayWithObjects:@"5月20日周五",@"5月21日周六",@"5月22日周日",@"5月23日周一",@"5月24日周二",@"5月25日周三",@"5月26日周四",@"5月27日周五",@"5月28日周六",@"5月29日周日",@"5月30日周一",@"5月31日周二", nil];
    }
    return _dateList;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"首页";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.number = 0;
    /**
     *  设置添加广告滚动视图
     */
    //把广告滚动的图片放到数组中保存
    NSArray *arr = @[[UIImage imageNamed:@"1"],[UIImage imageNamed:@"2"],[UIImage imageNamed:@"3"]];
    //NSArray *arr = @[@"1",@"2",@"3"];
    self.carouselView = [[XRCarouselView alloc] init];
    self.carouselView.frame = CGRectMake(0, 65, [UIScreen mainScreen].bounds.size.width, 100);
    self.carouselView.imageArray = arr;
    //用代理处理图片点击
    self.carouselView.delegate = self;
    
    //设置每张图片的停留时间，默认值为5s，最少为2s
    _carouselView.time = 2;
    
    _carouselView.pagePosition = PositionBottomRight;
    
    [self.view addSubview:self.carouselView];
    
    [self setAllChildController];
    
}

/**
 *  设置添加所有控件的函数
 */
-(void)setAllChildController
{
    self.startLabel = [[UILabel alloc] init];
    self.startLabel.text = @"初始地";
    self.startLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.startLabel];
    
    self.destinationLabel = [[UILabel alloc] init];
    self.destinationLabel.text = @"目的地";
    self.destinationLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.destinationLabel];
    
    self.startButton = [self setButton:self.startButton image:nil selectimage:nil str:@"北京市"];
    self.startButton.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:25];
    [self.startButton addTarget:self action:@selector(startButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.startButton];
    
    self.destinationButton = [self setButton:self.destinationButton image:nil selectimage:nil str:@"上海市"];
    self.destinationButton.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:25];
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
    
    self.dateButton = [self setButton:self.dateButton image:nil selectimage:nil str:@"5月28日周六"];
    [self.view addSubview:self.dateButton];
    
    self.searchButton = [self setButton:self.searchButton image:nil selectimage:nil str:@"查询"];
    [self.searchButton setBackgroundImage:[UIImage imageNamed:@"login_btn_blue_nor"] forState:UIControlStateNormal];
    [self.searchButton setBackgroundImage:[UIImage imageNamed:@"login_btn_blue_press"] forState:UIControlStateSelected];
    [self.searchButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.searchButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [self.searchButton addTarget:self action:@selector(searchButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.searchButton];
    
    [self.startLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.carouselView.mas_bottom).with.offset(30);
        make.right.equalTo(self.destinationLabel.mas_left).with.offset(-100);
        make.bottom.equalTo(self.startButton.mas_top).with.offset(-30);
        make.left.equalTo(self.view.mas_left).with.offset(40);
        make.width.equalTo(self.destinationLabel);
    }];
    [self.destinationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.carouselView.mas_bottom).with.offset(30);
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
        make.left.equalTo(self.view.mas_left).with.offset(20);
        make.right.equalTo(self.arrowImageView.mas_left).with.offset(-20);
        make.height.equalTo(@50);
        make.width.equalTo(self.destinationButton);
    }];
    
    [self.destinationButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.destinationLabel.mas_bottom).with.offset(30);
        make.left.equalTo(self.arrowImageView.mas_right).with.offset(20);
        make.right.equalTo(self.view.mas_right).with.offset(-20);
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



#pragma mark XRCarouselViewDelegate

/**
 *  XRCarouselViewDelegate协议
 *
 *  @param carouselView 视图
 *  @param index        第几张图片
 */
//- (void)carouselView:(XRCarouselView *)carouselView clickImageAtIndex:(NSInteger)index {
//    NSLog(@"点击了第%ld张图片", index);
//}

//
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}


/**
 *  出发地按钮响应的事件
 */
-(void)startButtonPressed
{
    TLSiteTableViewController *siteView = [[TLSiteTableViewController alloc] init];
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
    TLSiteTableViewController *siteView = [[TLSiteTableViewController alloc] init];
    siteView.siteBlock  = ^(NSString *str){
        [self.startButton setTitle:str forState:UIControlStateNormal];
    };
    
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
    if (self.number>0) {
        self.number--;
        [self.dateButton setTitle:[self.dateList objectAtIndex:self.number] forState:UIControlStateNormal];
    }
    
}

-(void)rightButtonPressed
{
    if (self.number<self.dateList.count-1) {
        self.number++;
        [self.dateButton setTitle:[self.dateList objectAtIndex:self.number] forState:UIControlStateNormal];
    }
}
@end
