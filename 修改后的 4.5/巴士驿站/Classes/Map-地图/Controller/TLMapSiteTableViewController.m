//
//  TLMapSiteTableViewController.m
//  巴士驿站
//
//  Created by Edge on 16/9/18.
//  Copyright © 2016年 Edge. All rights reserved.
//

#import "TLMapSiteTableViewController.h"
#import <AMapSearchKit/AMapSearchKit.h>

//#import "TLMapViewController.h"
@interface TLMapSiteTableViewController ()<UISearchResultsUpdating>
//列表数据
@property(nonatomic,strong)NSMutableArray *siteList;
//筛选后的列表数据
@property(nonatomic,strong)NSMutableArray *searchList;

//搜索框
@property(nonatomic,strong)UISearchController *searchController;
@property (nonatomic,retain) AMapSearchAPI *search;

@end

@implementation TLMapSiteTableViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"搜索";
    //搜索框的设置
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchController.searchResultsUpdater = self;
    self.searchController.dimsBackgroundDuringPresentation = false;
    [self.searchController.searchBar sizeToFit];
    self.tableView.tableHeaderView = self.searchController.searchBar;
   // [self updateData:nil];
    
    self.searchList = [NSMutableArray array];
  }
/**
 *  搜索框的搜索功能实现
 */
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    //发起输入提示搜索
    AMapInputTipsSearchRequest *tipsRequest = [[AMapInputTipsSearchRequest alloc] init];
    tipsRequest.keywords = _searchController.searchBar.text;
    tipsRequest.city = _currentCity;
    [_search AMapInputTipsSearch: tipsRequest];}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (self.searchController.active) {
        self.searchController.active = NO;
        [self.searchController.searchBar removeFromSuperview];
    }
}
/**
 *  获取列表的数据
 *
 *  @param array 传入数组类型的数据
 */
//-(void)updateData:(NSMutableArray *)array
//{
//    self.siteList = [NSMutableArray array];
//    
//    //    self.siteList = array;
//    
//    self.siteList = @[@"北京市",@"上海市",@"天津市"];
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    /**
     *  判断搜索框的状态
     */
    if (!self.searchController.active) {
        return self.siteList.count;
    }
    else{
        return self.searchList.count;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    /**
     *  判断搜索框的状态
     */
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    if (!self.searchController.active) {
        cell.textLabel.text = self.siteList[indexPath.row];
    }
    else{
        cell.textLabel.text = self.searchList[indexPath.row];
    }
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    
//    /**
//     *  判断搜索框的状态
//     */
//    if (!self.searchController.active) {
//        self.siteBlock(self.siteList[indexPath.row]);
//    }
//    else{
//        self.siteBlock(self.searchList[indexPath.row]);
//        
//    }
    [self.navigationController popViewControllerAnimated:YES];
    
}


@end
