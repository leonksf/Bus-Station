//
//  TLSearchTableViewController.m
//  巴士驿站
//
//  Created by 胡潇炜 on 16/7/28.
//  Copyright © 2016年 Edge. All rights reserved.
//

#import "TLSearchTableViewController.h"
#import "TLSearchTableViewCell.h"
#import "TLWriteOrderTableViewController.h"
//#import "Masonry.h"
@interface TLSearchTableViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,weak)UIView *m_headView;
@property(nonatomic,weak)UITableView *tableView;
@end

@implementation TLSearchTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"查询";
    [self addTableView];
    [self addHeaderView];
}

#pragma mark - Table view data source

-(void )addTableView{
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0, self.view.bounds.size.width, self.view.bounds.size.height)];
    self.tableView=tableView;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.tableFooterView = [[UIView alloc]init];
    self.tableView.backgroundColor = [UIColor colorWithRed:0.9278 green:0.9179 blue:0.9377 alpha:1.0];
    //  让分割线消失
    //  self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;//  取消分割线

    [self.view addSubview: self.tableView];
}
//  添加headView
-(void)addHeaderView{
    
    UIView *m_headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width,40)];
    self.m_headView=m_headView;
    self.m_headView.backgroundColor = [UIColor colorWithRed:0.9278 green:0.9179 blue:0.9377 alpha:1.0];
    [self.view addSubview: self.m_headView];
    self.tableView.tableHeaderView= self.m_headView;
    
    UILabel *label = [[UILabel alloc]init];
    label.text = @"7月20日";
    label.textAlignment = NSTextAlignmentCenter;
    [self.m_headView addSubview:label];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.m_headView).with.offset(15);
        make.left.equalTo(self.view).offset(80);
        make.width.equalTo(@70);
        make.height.equalTo(@10);
    }];
    UILabel *label1 = [[UILabel alloc]init];
    label1.text = @"星期一";
    label1.textAlignment = NSTextAlignmentCenter;
       [self.m_headView addSubview:label1];
    
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
      make.top.equalTo(self.m_headView).with.offset(15);
        make.right.equalTo(self.view).offset(-80);
        make.width.equalTo(@70);
        make.height.equalTo(@10);
    }];
    

    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 6;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    TLSearchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        cell = [[TLSearchTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    if (indexPath.row >=1) {
        // 用view来画分割线
        UIView *customLine = [[UIView alloc] init];
        customLine.frame = CGRectMake(cell.frame.origin.x, cell.frame.origin.y, self.view.frame.size.width+55, 10);
        customLine.backgroundColor =  [UIColor colorWithRed:0.9278 green:0.9179 blue:0.9377 alpha:1.0];
        [cell.contentView addSubview:customLine];
    }

    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TLWriteOrderTableViewController *vc = [[TLWriteOrderTableViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
