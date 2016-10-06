//
//  TLWriteOrderTableViewController.m
//  巴士驿站
//
//  Created by Edge on 16/7/28.
//  Copyright © 2016年 Edge. All rights reserved.
//

#import "TLWriteOrderTableViewController.h"
#import "TLWriteOrderView.h"
#import "Masonry.h"
#import "TLPayView.h"
#import "TLAddPassengerTableViewController.h"
#import "TLUsers.h"

@interface TLWriteOrderTableViewController ()<UITableViewDataSource,UITableViewDelegate,TLAddPassengerTableViewControllerDelegate>

@property (nonatomic,strong) UITableView *tableView;

@property(nonatomic,weak)UIView *m_headView;

//  储存数据
@property(nonatomic,strong)NSMutableArray *users;

@end

@implementation TLWriteOrderTableViewController


// 模型数据初始化
- (NSMutableArray *)users{
    if (!_users) {
        _users = [NSMutableArray array];
    }
    // NSLog(@"user_%@",_users);
    return _users;
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    //  设置CGRectZero从导航栏下开始计算
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
//    NSString *docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
//    NSString *file = [docPath stringByAppendingPathComponent:@"TLPasserger.data"];
//    self.users = [NSKeyedUnarchiver unarchiveObjectWithFile:file];
    
    self.view.backgroundColor = [UIColor colorWithRed:0.888 green:0.865 blue:0.872 alpha:1.000];
    self.navigationItem.title = @"订单填写";
    [self addHeaderView];
    
    TLPayView *payTabBar = [[TLPayView alloc] init];
    
    [self.view addSubview:payTabBar];
    
    [payTabBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
        make.height.equalTo(@50);
    }];
    
    _tableView = [[UITableView alloc] init];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    
      [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(-50);
        make.top.equalTo(self.view.mas_top).with.offset(136);
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -------------------
#pragma mark UITableViewDataSource
//委托里 @required 的必须实现

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return self.users.count;
        //return 3;
    }else{
        return 1;
    }
}

//每个分组上边预留的空白高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return 10;
    }
    return 1;
}

//每个分组下边预留的空白高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section==0) {
        return 20;
    }
    return 20;
}

//每一个分组下对应的tableview 高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID =@"cell";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        //  定义cell显示风格
        cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        
    }
    if (indexPath.section==0) {
     
        TLUsers * user = self.users[indexPath.row];
        cell.textLabel.text = user.passName;
        cell.detailTextLabel.text = user.passID;
        
        if (cell.detailTextLabel.text.length>7) {
            [self numberApperStar:cell];
        }
    }else{
        cell.textLabel.text=@"添加乘客";
      //  cell.imageView.image = [UIImage imageNamed:@"add"];
        //添加cell右边的小箭头
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        
    }
    //  分割线左对齐
    [cell setLayoutMargins:UIEdgeInsetsZero];
    [cell setSeparatorInset:UIEdgeInsetsZero];
    [tableView setLayoutMargins:UIEdgeInsetsZero];
    [tableView setSeparatorInset:UIEdgeInsetsZero];
    
    return cell;
}


    




#pragma mark -------------------
#pragma mark UITableViewDelegate


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return YES;
    }
    else
    {
        return NO;
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==0) {
        //
    }
    if (indexPath.section==1) {
        TLAddPassengerTableViewController *pushCell = [[TLAddPassengerTableViewController alloc]init];
         pushCell.delegate = self;
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"订单填写" style:UIBarButtonItemStylePlain target:nil action:nil];
        self.navigationItem.backBarButtonItem = item;
        [self.navigationController pushViewController:pushCell animated:YES ];
    }
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        
    //  删除数组中的元素
    [self.users removeObjectAtIndex:indexPath.row];
    
    //  先删除模型再删除cell
    //  删除cell
    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimationRight)];
    }
    
    // 删除完了再归档 数据归档保存在Documents
//    NSString *docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    //  NSString *file = [docPath stringByAppendingPathComponent:@"TLPasserger.data"];
    //  [NSKeyedArchiver archiveRootObject:self.users toFile:file];//  归档整个数组模型
    
}

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
        return @"删除";
}

//  获取User的数据
-(void)addViewController:(TLAddPassengerTableViewController *)viewController addUser:(TLUsers *)user
{
    
    [self.users addObject:user];  //  将数据添加进来
    [self.tableView reloadData]; //  刷新表格
    
//    //  数据归档保存在Documents
//    NSString *docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
//    NSString *file = [docPath stringByAppendingPathComponent:@"TLPasserger.data"];
//    [NSKeyedArchiver archiveRootObject:self.users toFile:file];//  归档整个数组模型
}

//  当数字大于7位，中间显示星号
-(void)numberApperStar:(UITableViewCell *)cell{
    //星号字符串
    NSString *xinghaoStr = @"";
    NSString *idcardNumber = cell.detailTextLabel.text;
    //动态计算星号的个数
    for (int i  = 0; i < idcardNumber.length - 7; i++) {
        xinghaoStr = [xinghaoStr stringByAppendingString:@"*"];
    }
    //身份证号取前3后四中间以星号拼接
    idcardNumber = [NSString stringWithFormat:@"%@%@%@",[idcardNumber substringToIndex:3],xinghaoStr,[idcardNumber substringFromIndex:idcardNumber.length-4]];
    cell.detailTextLabel.text = idcardNumber;
}


//  添加headView
-(void)addHeaderView{
    //    UIView *m_headView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width,130)];
    //    self.m_headView=m_headView;
    //    self.m_headView.backgroundColor = [UIColor colorWithRed:0.959 green:0.9966 blue:1.0 alpha:1.0];
    //    [self.view addSubview:m_headView];
    TLWriteOrderView *writeView = [[TLWriteOrderView alloc]init];
    [self.view addSubview:writeView];
    [writeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(0);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.height.equalTo(@140);
    }];
    
}
@end
