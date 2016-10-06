//
//  ForgetPasswordTwoViewController.m
//  登陆界面测试
//
//  Created by mac on 16/7/19.
//  Copyright © 2016年 mac. All rights reserved.
//
#import "ForgetPasswordViewController.h"
#import "LoginViewController.h"
#import "ForgetPasswordTwoViewController.h"
#import "Masonry.h"
@interface ForgetPasswordTwoViewController ()
{
    UIView *bgView;
    UITextField *password;
}
@end

@implementation ForgetPasswordTwoViewController

- (void)viewDidLoad {
    self.navigationItem.title=@"找回密码2/2";
    self.view.backgroundColor=[UIColor colorWithRed:231/255.0 green:232/255.0 blue:238/255.0 alpha:1];
    bgView=[[UIView alloc]init];
    bgView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.centerY.equalTo(self.view.mas_centerY).offset(-200);
        make.left.equalTo(self.view.mas_left).offset(20);
        make.right.equalTo(self.view.mas_right).offset(-20);
        make.height.equalTo(@50);
    }];
    UILabel *label=[[UILabel alloc]init];
    label.text=@"请设置新的密码:";
    label.textColor=[UIColor grayColor];
    label.font=[UIFont systemFontOfSize:16];
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(bgView.mas_top).offset(-10);
        make.left.equalTo(self.view.mas_left).offset(20);
    }];
    UILabel *passwordlabel=[[UILabel alloc]init];
    passwordlabel.text=@"密码:";
    passwordlabel.textColor=[UIColor blackColor];
    passwordlabel.font=[UIFont systemFontOfSize:19];
    [bgView addSubview:passwordlabel];
    [passwordlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgView.mas_left).offset(20);
        make.top.equalTo(bgView.mas_top).offset(15);
    }];
    password=[[UITextField alloc]init];
    password.font=[UIFont systemFontOfSize:16];
    password.placeholder=@"6-20位字母或数字";
    password.clearButtonMode = UITextFieldViewModeWhileEditing;
    password.secureTextEntry=YES;
    [bgView addSubview:password];
    [password mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(passwordlabel.mas_bottom);
        make.left.equalTo(passwordlabel.mas_right).offset(10);
    }];
    UIButton *complete=[[UIButton alloc]init];
    [complete.layer setMasksToBounds:YES];
    [complete.layer setCornerRadius:5.0];
    [complete setTitle:@"完成" forState:UIControlStateNormal];
    [complete setTitleColor:[UIColor colorWithRed:116/255.0 green:125/255.0 blue:135/255.0 alpha:1] forState:UIControlStateNormal];
    [complete setBackgroundColor:[UIColor colorWithRed:32/255.0 green:170/255.0 blue:238/255.0 alpha:0.75]];
    [complete addTarget:self action:@selector(okClick) forControlEvents:UIControlEventTouchUpInside];//点击登录所传的事件
    [self.view addSubview:complete];
    [complete mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgView.mas_bottom).offset(50);
        make.left.equalTo(self.view.mas_left).offset(20);
        make.right.equalTo(self.view.mas_right).offset(-20);
    }];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)okClick
{
    //    if([passward.text isEqualToString:@""])
    //    {
    //        return;
    //    }
    //    else if (passward.text.length <6)
    //    {
    //        return;
    //    }
    
    //__weak newPassWardViewController * weakSelf=self;
    
    
    //[SVProgressHUD showSuccessWithStatus:@"修改成功"];
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
