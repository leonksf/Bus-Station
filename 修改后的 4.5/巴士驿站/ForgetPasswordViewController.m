//
//  ForgetPasswordViewController.m
//  登陆界面测试
//
//  Created by mac on 16/7/19.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ForgetPasswordViewController.h"
#import "ForgetPasswordTwoViewController.h"
#import "Masonry.h"
@interface ForgetPasswordViewController ()
{
    UIView *bgView;
    //UITextField *phone;
    UITextField *code;
    UINavigationBar *customNavigationBar;
    UIButton *yzButton;
}
@property(nonatomic, copy) NSString *oUserPhoneNum;
@property(assign, nonatomic) NSInteger timeCount;
@property(strong, nonatomic) NSTimer *timer;
//验证码
@property(copy, nonatomic) NSString *smsId;
@property (nonatomic, strong) UITextField *phone;
@end

@implementation ForgetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:nil action:nil];
    self.navigationItem.title=@"找回密码1/2";
    self.view.backgroundColor=[UIColor colorWithRed:231/255.0 green:232/255.0 blue:238/255.0 alpha:1];
    bgView=[[UIView alloc]init];
    bgView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.centerY.equalTo(self.view.mas_centerY).offset(-150);
        make.left.equalTo(self.view.mas_left).offset(20);
        make.right.equalTo(self.view.mas_right).offset(-20);
        make.height.equalTo(@100);
    }];
    UILabel *phonelabel=[[UILabel alloc]init];
    phonelabel.text=@"手机号:";
    phonelabel.textColor=[UIColor blackColor];
    phonelabel.font=[UIFont systemFontOfSize:19];
    [bgView addSubview:phonelabel];
    [phonelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgView.mas_left).offset(20);
        make.top.equalTo(bgView.mas_top).offset(15);
    }];
    UITextField *phone=[[UITextField alloc]init];
    self.phone=phone;
    phone.placeholder=@"请填写11位手机号";
    phone.font=[UIFont systemFontOfSize:16];
   phone.clearButtonMode = UITextFieldViewModeWhileEditing;
   // phone.keyboardType=UIKeyboardTypeNumberPad;
    [self.view addSubview:phone];
    [phone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(phonelabel.mas_bottom);
        make.left.equalTo(phonelabel.mas_right).offset(10);
    }];
    
    UILabel *codelabel=[[UILabel alloc]init];
    codelabel.text=@"验证码:";
    codelabel.textColor=[UIColor blackColor];
    codelabel.font=[UIFont systemFontOfSize:19];
    [self.view addSubview:codelabel];
    [codelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgView.mas_left).offset(20);
        make.bottom.equalTo(bgView.mas_bottom).offset(-15);
    }];
    yzButton=[[UIButton alloc]init];
    yzButton.layer.cornerRadius=3.0f;
    [yzButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    [yzButton setTitleColor:[ UIColor colorWithRed:32/255.0 green:170/255.0 blue:238/255.0 alpha:1] forState:UIControlStateNormal];
    yzButton.titleLabel.font=[UIFont systemFontOfSize:18];
    [yzButton addTarget:self action:@selector(getValidCode:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:yzButton];
  
    [yzButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(bgView.mas_bottom).offset(-10);
        make.right.equalTo(bgView.mas_right).offset(-10);
    }];
    code=[[UITextField alloc]init];
    code.placeholder=@"4位验证码";
    code.font=[UIFont systemFontOfSize:16];
    code.clearButtonMode = UITextFieldViewModeWhileEditing;
    //code.text=@"mojun1992225";
    //密文样式
    code.secureTextEntry=YES;
    code.keyboardType=UIKeyboardTypeNumberPad;
    [self.view addSubview:code];
    [code mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(codelabel.mas_bottom);
        make.left.equalTo(codelabel.mas_right).offset(10);
        make.right.equalTo(yzButton.mas_left);
    }];
    UIImageView *line=[[UIImageView alloc]init];
    line.backgroundColor=[UIColor colorWithRed:180/255.0f green:180/255.0f blue:180/255.0f alpha:1];
    [self.view addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(bgView.mas_centerX);
        make.centerY.equalTo(bgView.mas_centerY);
        make.left.equalTo(bgView.mas_left);
        make.right.equalTo(bgView.mas_right);
        make.height.equalTo(@1);
    }];
    UIButton *nextStep=[[UIButton alloc]init];
    [nextStep.layer setMasksToBounds:YES];
    [nextStep.layer setCornerRadius:5.0];
    [nextStep setTitle:@"下一步" forState:UIControlStateNormal];
    [nextStep setTitleColor:[UIColor colorWithRed:116/255.0 green:125/255.0 blue:135/255.0 alpha:1] forState:UIControlStateNormal];
    [nextStep setBackgroundColor:[UIColor colorWithRed:32/255.0 green:170/255.0 blue:238/255.0 alpha:0.75]];
    [nextStep addTarget:self action:@selector(backPw:) forControlEvents:UIControlEventTouchUpInside];//点击登录所传的事件
    [self.view addSubview:nextStep];
    [nextStep mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgView.mas_bottom).offset(50);
        make.left.equalTo(self.view.mas_left).offset(20);
        make.right.equalTo(self.view.mas_right).offset(-20);
    }];
}
- (void)getValidCode:(UIButton *)sender
{
    if ([_phone.text isEqualToString:@""])
    {
        //[SVProgressHUD showInfoWithStatus:@"亲,请输入手机号码"];
        return;
    }
    else if (_phone.text.length <11)
    {
        //[SVProgressHUD showInfoWithStatus:@"您输入的手机号码格式不正确"];
        return;
    }
    _oUserPhoneNum =_phone.text;
    sender.userInteractionEnabled = NO;
    self.timeCount = 60;
    //__weak ForgetPasswordViewController *weakSelf = self;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(reduceTime:) userInfo:sender repeats:YES];
    
}

- (void)reduceTime:(NSTimer *)codeTimer {
    self.timeCount--;
    if (self.timeCount == 0) {
        [yzButton setTitle:@"重新获取验证码" forState:UIControlStateNormal];
        [yzButton setTitleColor:[UIColor colorWithRed:248/255.0f green:144/255.0f blue:34/255.0f alpha:1] forState:UIControlStateNormal];
        UIButton *info = codeTimer.userInfo;
        info.enabled = YES;
        yzButton.userInteractionEnabled = YES;
        [self.timer invalidate];
    } else {
        NSString *str = [NSString stringWithFormat:@"%lu秒后重新获取", self.timeCount];
        [yzButton setTitle:str forState:UIControlStateNormal];
        yzButton.userInteractionEnabled = NO;
        
    }
}
-(void)backPw:(UIButton*)button
{
    //    if ([phone.text isEqualToString:@""])
    //    {
    //        //[SVProgressHUD showInfoWithStatus:@"亲,请输入注册手机号码"];
    //        return;
    //    }
    //    else if (phone.text.length <11)
    //    {
    //        ///[SVProgressHUD showInfoWithStatus:@"您输入的手机号码格式不正确"];
    //        return;
    //    }
    //    else if ([code.text isEqualToString:@""])
    //    {
    //        //[SVProgressHUD showInfoWithStatus:@"亲,请输入验证码"];
    //        return;
    //    }
    //    else if (self.smsId.length == 0)
    //    {
    //        //[SVProgressHUD showInfoWithStatus:@"验证码错误"];
    //        return;
    //   }
    ForgetPasswordTwoViewController *pushView2=[[ForgetPasswordTwoViewController alloc]init];
    [self.navigationController pushViewController:pushView2 animated:YES];
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
