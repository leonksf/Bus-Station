//
//  LoginViewController.m
//  登陆界面测试
//
//  Created by Maominghui on 16/9/24.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "LoginViewController.h"
#import "ForgetPasswordViewController.h"
#import "SVProgressHUD.h"
#import "Masonry.h"
#import "LoginViewController.h"
//#import "IQKeyboardReturnKeyHandler.h"
#import "RegisterViewController.h"
#import "TLPersonalViewController.h"


@interface LoginViewController ()
@property(strong,nonatomic)UITextField *userName;
@property(strong,nonatomic)UITextField *passWord;
@property(strong,nonatomic)NSString *confirmUn;
@property(strong,nonatomic)NSString *confirmPw;
@end

@implementation LoginViewController


#pragma mark: 1.登录首界面设置
- (void)viewDidLoad {
    
 //   IQKeyboardReturnKeyHandler *returnKeyHandler= [[IQKeyboardReturnKeyHandler alloc]init];
//    returnKeyHandler.lastTextFieldReturnKeyType=UIReturnKeyNext;
#pragma mark:1.1/*背景图片设置*/
    UIImageView *bgPicture = [[UIImageView alloc]initWithFrame:self.view.bounds];
    bgPicture.image = [UIImage imageNamed:@"背景.jpg"];
    [self.view addSubview:bgPicture];
    
#pragma mark:1.2/*标题设置*/
    UILabel *title=[[UILabel alloc]init];
    title.text=@"巴士驿站";
    title.font=[UIFont systemFontOfSize:30];
    title.textColor=[UIColor whiteColor];
    title.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(bgPicture.mas_centerX);
        make.centerY.equalTo(bgPicture.mas_centerY).with.offset(-100);
    }];
#pragma mark:1.3/*用户名和密码设置*/
    self.userName=[[UITextField alloc]init];
    self.userName.borderStyle=UITextBorderStyleRoundedRect;
    self.userName.placeholder=@"用户名:";
    self.userName.textColor=[UIColor colorWithRed:128/255.0 green:129/255.0 blue:129/255.0 alpha:1];
    [self.userName setBackgroundColor:[UIColor colorWithRed:164/255.0 green:193/255.0 blue:224/255.0 alpha:1]];
    [self.view addSubview:self.userName];
    [self.userName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgPicture.mas_centerX).with.offset(100);
        make.left.equalTo(self.view).with.offset(50);
        make.right.equalTo(self.view).with.offset(-50);
        make.height.mas_equalTo(40);
    }];
    self.passWord=[[UITextField alloc]init];
    self.passWord.borderStyle=UITextBorderStyleRoundedRect;
    self.passWord.placeholder=@"密    码:";
    self.passWord.secureTextEntry=YES;
    self.passWord.textColor=[UIColor colorWithRed:128/255.0 green:129/255.0 blue:129/255.0 alpha:1];
    [self.passWord setBackgroundColor:[UIColor colorWithRed:164/255.0 green:193/255.0 blue:224/255.0 alpha:1]];
    [self.view addSubview:self.passWord];
    [self.passWord mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.userName.mas_bottom);
        make.left.equalTo(self.view).with.offset(50);
        make.right.equalTo(self.view).with.offset(-50);
        make.height.mas_equalTo(40);
    }];
#pragma mark:1.4/*忘记密码设置*/
    UIButton *forgetPw=[[UIButton alloc]init];
    [forgetPw setTitle:@"忘记密码" forState:UIControlStateNormal];
    [forgetPw setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    forgetPw.titleLabel.font=[UIFont systemFontOfSize:14.0];
    [forgetPw addTarget:self action:@selector(forgetpassword:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:forgetPw];
    [forgetPw mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.passWord.mas_bottom).with.offset(5);
        make.left.equalTo(self.view).with.offset(50);
    }];
#pragma mark:1.5/*注册设置*/
    UIButton *Register=[[UIButton alloc]init];
    [Register setTitle:@"注册" forState:UIControlStateNormal];
    [Register setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    Register.titleLabel.font=[UIFont systemFontOfSize:14.0];
    [self.view addSubview:Register];
    [Register mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.passWord.mas_bottom).with.offset(5);
        make.right.equalTo(self.view).with.offset(-50);
    }];
    [Register addTarget:self action:@selector(forRegister:) forControlEvents:UIControlEventTouchUpInside];
#pragma mark:1.6/*登录设置*/
    UIButton *login=[[UIButton alloc]init];
    [login.layer setMasksToBounds:YES];
    [login.layer setCornerRadius:5.0];
    [login setBackgroundColor:[UIColor colorWithRed:172/255.0 green:205/255.0 blue:242/255.0 alpha:0.60]];
    [login setTitle:@"登  录" forState:UIControlStateNormal];
    [forgetPw setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [login addTarget:self action:@selector(backPw:) forControlEvents:UIControlEventTouchUpInside];//点击登录所传的事件
    [self.view addSubview:login];
    [login mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(bgPicture.mas_centerX);
        make.centerY.equalTo(bgPicture.mas_centerY).with.offset(100);
        make.width.mas_equalTo(80);
    }];
#pragma mark:1.7导航设置
    self.navigationItem.title=@"登录界面";
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:nil action:nil];
    [super viewDidLoad];
    //Do any additional setup after loading the view, typically from a nib.
}
-(void)dismissKeyboard {
    [self.view endEditing:YES];
    [self.passWord resignFirstResponder];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return YES;
}
#pragma mark:2.点击登录响应的事件
-(void)backPw:(UIButton*)sender
{
    
    _confirmPw=@"1";
    _confirmUn=@"1";
    if ([_confirmUn isEqualToString:self.userName.text]&&[_confirmPw isEqualToString:self.passWord.text]) {
        
        [self showWithStatus];
    }else
    {
#pragma mark:2.2登录失败界面设置
        /*背景图片设置*/
        UIImageView *bgPicture = [[UIImageView alloc]initWithFrame:self.view.bounds];
        bgPicture.image = [UIImage imageNamed:@"背景.jpg"];
        bgPicture.tintColor=[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
        [self.view addSubview:bgPicture];
        UIView *view=[[UIView alloc] initWithFrame:self.view.bounds];
        view.backgroundColor=[UIColor colorWithRed:122/255.0 green:128/255.0 blue:138/255.0 alpha:0.5];
        [self.view addSubview:view];
        /*标题设置*/
        UILabel *title=[[UILabel alloc]init];
        title.text=@"巴士驿站";
        title.font=[UIFont systemFontOfSize:30];
        title.textColor=[UIColor colorWithRed:82/255.0 green:83/255.0 blue:85/255.0 alpha:1];
        title.textAlignment=NSTextAlignmentCenter;
        [self.view addSubview:title];
        [title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view).with.offset(10);
            make.right.equalTo(self.view).with.offset(-10);
            make.bottom.equalTo(bgPicture.mas_centerX).with.offset(70);
            
        }];
        /*用户名和密码设置*/
        self.userName=[[UITextField alloc]init];
        self.userName.borderStyle=UITextBorderStyleRoundedRect;
        self.userName.placeholder=@"用户名";
        self.userName.textColor=[UIColor colorWithRed:144/255.0 green:146/255.0 blue:148/255.0 alpha:1];
        [self.userName setBackgroundColor:[UIColor colorWithRed:167/255.0 green:185/255.0 blue:205/255.0 alpha:1]];
        [self.view addSubview:self.userName];
        [self.userName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(bgPicture.mas_centerX).with.offset(100);
            make.left.equalTo(self.view).with.offset(50);
            make.right.equalTo(self.view).with.offset(-50);
            make.height.mas_equalTo(40);
        }];
        self.passWord=[[UITextField alloc]init];
        self.passWord.borderStyle=UITextBorderStyleRoundedRect;
        self.passWord.placeholder=@"密    码";
        self.passWord.secureTextEntry=YES;
        self.passWord.textColor=[UIColor colorWithRed:144/255.0 green:146/255.0 blue:148/255.0 alpha:1];
        [self.passWord setBackgroundColor:[UIColor colorWithRed:167/255.0 green:185/255.0 blue:205/255.0 alpha:1]];
        [self.view addSubview:self.passWord];
        [self.passWord mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.userName.mas_bottom);
            make.left.equalTo(self.view).with.offset(50);
            make.right.equalTo(self.view).with.offset(-50);
            make.height.mas_equalTo(40);
        }];
        /*忘记密码提示框设置*/
        UILabel *prompt=[[UILabel alloc]init];
        prompt.text=@"请填写正确的用户名和密码";
        prompt.textColor=[UIColor colorWithRed:210/255.0 green:1/255.0 blue:1/255.0 alpha:1];
        prompt.textAlignment=NSTextAlignmentCenter;
        prompt.backgroundColor=[UIColor whiteColor];
        [self.view addSubview:prompt];
        [prompt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.passWord.mas_bottom).with.offset(3);
            make.left.equalTo(self.view).with.offset(50);
            make.right.equalTo(self.view).with.offset(-50);
            make.height.mas_equalTo(30);
        }];
        /*登录设置*/
        UIButton *login=[[UIButton alloc]init];
        [login.layer setMasksToBounds:YES];
        [login.layer setCornerRadius:5.0];
        [login setTitle:@"登   录" forState:UIControlStateNormal];
        [login setTitleColor:[UIColor colorWithRed:116/255.0 green:125/255.0 blue:135/255.0 alpha:1] forState:UIControlStateNormal];
        [login setBackgroundColor:[UIColor colorWithRed:167/255.0 green:185/255.0 blue:205/255.0 alpha:1]];
        [login addTarget:self action:@selector(backPw:) forControlEvents:UIControlEventTouchUpInside];//点击登录所传的事件
        [self.view addSubview:login];
        [login mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(bgPicture.mas_centerX);
            make.centerY.equalTo(bgPicture.mas_centerY).with.offset(110);
            make.width.mas_equalTo(80);
        }];
        UINavigationBar *navigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
        navigationBar.backgroundColor=[UIColor clearColor];
        [self.view addSubview:navigationBar];
    }
}
-(void)forgetpassword:(UIButton*)button
{
    ForgetPasswordViewController *pushview=[[ForgetPasswordViewController alloc]init];
    [self.navigationController pushViewController:pushview animated:YES];
}

-(void)forRegister:(UIButton*)button
{
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"登录" style:UIBarButtonItemStylePlain target:nil action:nil];
    RegisterViewController *pushview=[[RegisterViewController alloc]init];
    self.navigationItem.backBarButtonItem = item;
    [self.navigationController pushViewController:pushview animated:YES ];
}

- (void)showWithStatus {
    [SVProgressHUD showWithStatus:@"登录中"];
    [self performSelector:@selector(dismiss) withObject:nil afterDelay:0.3];
    
}
- (void)dismiss {
    [SVProgressHUD dismiss];
    TLPersonalViewController *pushCell1 = [[TLPersonalViewController alloc]init];
    [self presentViewController:pushCell1 animated:YES completion:nil];
}

- (void)dismissSuccess {
    [SVProgressHUD showSuccessWithStatus:@"登录成功!"];
}

- (void)dismissError {
    [SVProgressHUD showErrorWithStatus:@"登录失败"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
