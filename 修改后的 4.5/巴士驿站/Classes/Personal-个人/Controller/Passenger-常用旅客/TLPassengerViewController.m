//
//  TLPassengerViewController.m
//  巴士驿站
//
//  Created by Maominghui on 16/7/15.
//  Copyright © 2016年 Edge. All rights reserved.
//

#import "TLPassengerViewController.h"
#import "TLAddPassengerViewController.h"
#import "TLChangePassengerViewController.h"
#import "Masonry.h"
#import "TLUsers.h"

@interface TLPassengerViewController ()<TLAddPassengerViewControllerDelegate,TLChangePassengerViewControllerDelegate>
//  添加按钮
@property (nonatomic,strong) UIButton *addButton ;
@property(nonatomic,weak)UITableViewCell *cell;  //  cell
@property (nonatomic,strong) UITextField *nameText ;    //姓名
@property (nonatomic,strong) UITextField *paperText ;   //证件号码
@property (nonatomic,strong) UITextField *phoneText ;  //电话号码

//  储存数据
@property(nonatomic,strong)NSMutableArray *users;

@end

@implementation TLPassengerViewController
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
    self.navigationItem.title = @"旅客信息";
    [self addClickButton];
    //  让分割线消失
   // self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //  隐藏不需要的分割线
    self.tableView.tableFooterView = [[UIView alloc]init];
    
    self.tableView.backgroundColor= [UIColor colorWithRed:0.888 green:0.865 blue:0.872 alpha:1.000];
    
    //    解档（加载界面就开始解档案）初始化联系人信息
    NSString *docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString *file = [docPath stringByAppendingPathComponent:@"TLPasserger.data"];
    self.users = [NSKeyedUnarchiver unarchiveObjectWithFile:file];
    
    // NSString *str = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;//  指定路径
  //  NSLog(@"%@",str);
}

#pragma 添加按钮和headView
-(void)addClickButton{
   
    UIView *headView=[[UIView alloc]initWithFrame:CGRectMake(0,0, self.view.bounds.size.width, 60)];
    
    headView.backgroundColor=[UIColor colorWithRed:0.888 green:0.865 blue:0.872 alpha:1.000];
    [self.view addSubview:headView];
    _addButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    UIImage *image = [UIImage imageNamed:@"addPassenger.png"];
    [_addButton setBackgroundImage:image forState:UIControlStateNormal];
    [_addButton setBackgroundColor:[UIColor clearColor]];
    _addButton.layer.borderWidth = 0.0;//  设置按钮边框
    [_addButton.layer setCornerRadius:18.0]; //设置按钮矩圆角半径
    [headView addSubview:_addButton];
    self.tableView.tableHeaderView = headView;
    [_addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@40);
        make.top.equalTo(self.view).with.offset(10);
        make.right.equalTo(headView).with.offset(-10);
        make.left.equalTo(self.view).with.offset(10);
    }];
    
    [_addButton addTarget:self action:@selector(addPassengerButton:) forControlEvents:UIControlEventTouchUpInside];
}
//  点击按钮实现跳转
-(void)addPassengerButton:(UIButton *)sender
{
    TLAddPassengerViewController *pushCell = [[TLAddPassengerViewController alloc]init];
    pushCell.delegate = self;  //  设置添加代理
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"常用旅客" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
    [self.navigationController pushViewController:pushCell animated:YES ];
}

#pragma tableView代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  
    return self.users.count;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *ID = @"cell";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        //  定义cell显示风格
        cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        
    }
    self.cell = cell;
    cell.backgroundColor =[UIColor colorWithRed:0.9543 green:0.9492 blue:0.9593 alpha:1.0];
    //  cell上面的箭头
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//    //用view来画分割线
//    
//    UIView *customLine = [[UIView alloc] init];
//    customLine.frame = CGRectMake(self.cell.frame.origin.x, self.cell.frame.origin.y, self.view.frame.size.width+55, 10);
//    customLine.backgroundColor = [UIColor colorWithRed:0.888 green:0.865 blue:0.872 alpha:1.000];
//    
//    [self.cell.contentView addSubview:customLine];
    
    //  显示传入数据
    TLUsers * user = self.users[indexPath.row];
    cell.textLabel.text = user.passName;
    cell.detailTextLabel.text = user.passID;
    
    if (self.cell.detailTextLabel.text.length>7) {
        [self numberApperStar];
    }

    //  分割线左对齐
    [cell setLayoutMargins:UIEdgeInsetsZero];
    [cell setSeparatorInset:UIEdgeInsetsZero];
    [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    [self.tableView setSeparatorInset:UIEdgeInsetsZero];

    return cell;
}
//  点击实现跳转并且将数据传入第三个控制器
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
  // TLUsers * user = self.users[indexPath.row];
    TLChangePassengerViewController *pushCell = [[TLChangePassengerViewController alloc]init];
   
    pushCell.delegate = self;  //  设置编辑界面代理
    
   //  将数据传给模型（费时间半小时），否则模型是空的，后面取值不到，赋值不成功
    NSIndexPath * index = [self.tableView indexPathForSelectedRow];
    //取出对应的模型
    pushCell.user = self.users[index.row];
//    pushCell.passName = user.passName;
//    pushCell.passID = user.passID;
//    pushCell.pPaper = user.pPaper;
//    pushCell.pNumber = user.pNumber;
    [self.navigationController pushViewController:pushCell animated:YES ];
    
}
//  cell高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
//  进入cell编辑
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    //  删除数组中的元素
    [self.users removeObjectAtIndex:indexPath.row];
 
    //  先删除模型再删除cell
    //  删除cell
    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimationRight)];
    
    // 删除完了再归档 数据归档保存在Documents
    NSString *docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString *file = [docPath stringByAppendingPathComponent:@"TLPasserger.data"];
    [NSKeyedArchiver archiveRootObject:self.users toFile:file];//  归档整个数组模型
    
}

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}
//  获取User的数据
-(void)addViewController:(TLAddPassengerViewController *)viewController addUser:(TLUsers *)user
{
    
    [self.users addObject:user];  //  将数据添加进来
    [self.tableView reloadData]; //  刷新表格
    
    //  数据归档保存在Documents
    NSString *docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString *file = [docPath stringByAppendingPathComponent:@"TLPasserger.data"];
    [NSKeyedArchiver archiveRootObject:self.users toFile:file];//  归档整个数组模型
}
//  获取修稿后的数据
-(void)editViewController:(TLChangePassengerViewController *)editviewController didSaveUser:(TLUsers *)user{
  
   // [self.users addObject:user];  //  将数据添加进来
    [self.tableView reloadData]; //  刷新表格
    
    //  将修改的数据归档保存在Documents
    NSString *docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString *file = [docPath stringByAppendingPathComponent:@"TLPasserger.data"];
    [NSKeyedArchiver archiveRootObject:self.users toFile:file];//  归档整个数组模型
    
}
//  当数字大于7位，中间显示星号
-(void)numberApperStar{
    //星号字符串
    NSString *xinghaoStr = @"";
    NSString *idcardNumber = self.cell.detailTextLabel.text;
    //动态计算星号的个数
    for (int i  = 0; i < idcardNumber.length - 7; i++) {
        xinghaoStr = [xinghaoStr stringByAppendingString:@"*"];
    }
    //身份证号取前3后四中间以星号拼接
    idcardNumber = [NSString stringWithFormat:@"%@%@%@",[idcardNumber substringToIndex:3],xinghaoStr,[idcardNumber substringFromIndex:idcardNumber.length-4]];
     self.cell.detailTextLabel.text = idcardNumber;
  }

@end
