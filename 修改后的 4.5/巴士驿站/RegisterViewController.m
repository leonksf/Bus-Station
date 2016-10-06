//
//  RegisterViewController.m
//  LUIViewController
//
//  Created by Maominghui on 16/9/20.
//  Copyright © 2016年 Oran Wu. All rights reserved.
//

#import "RegisterViewController.h"
#import "Masonry.h"
//#import "FMDB.h"
//#import "IQKeyboardReturnKeyHandler.h"

@interface RegisterViewController ()<UITextFieldDelegate/*这里引入UITextField 需要的委托*/,UITextViewDelegate/*这里引入UITextView 需要的委托*/>
//
@property (nonatomic,strong) UITextField *numField;       //用户名
//@property (nonatomic,strong) UITextField *identifyField;  //验证码
@property (nonatomic,strong) UITextField *passwordField;  //密码
@property (nonatomic,strong) UITextField *confirmField;   //确认密码
//@property (nonatomic,strong) UIButton *gainButton;      //获取验证码
@property (nonatomic,strong) UIButton *registerButton;   //注册


@end

@implementation RegisterViewController

/*
 -(void)tapGainButton:(UIButton *)sender
 {
 //获取验证码倒计时
 __block int timeout=30; //倒计时时间
 dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
 dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
 dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
 dispatch_source_set_event_handler(_timer, ^{
 if(timeout<=0){ //倒计时结束，关闭
 dispatch_source_cancel(_timer);
 dispatch_async(dispatch_get_main_queue(), ^{
 //设置界面的按钮显示 根据自己需求设置
 _gainButton.titleLabel.font = [UIFont systemFontOfSize:22];
 [_gainButton setTitle:@"获取验证码" forState:UIControlStateNormal];
 _gainButton.userInteractionEnabled = YES;
 });
 }else{
 int seconds = timeout % 60;
 NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
 dispatch_async(dispatch_get_main_queue(), ^{
 //设置界面的按钮显示 根据自己需求设置
 [UIView beginAnimations:nil context:nil];
 [UIView setAnimationDuration:1];
 _gainButton.titleLabel.font = [UIFont systemFontOfSize:18];
 [_gainButton setTitle:[NSString stringWithFormat:@"%@秒后重新发送",strTime] forState:UIControlStateNormal];
 [UIView commitAnimations];
 //按钮不可按
 _gainButton.userInteractionEnabled = NO;
 });
 timeout--;
 }
 });
 dispatch_resume(_timer);
 }*/
-(void)tapRegisterButton:(UIButton *)sender
{
    //  NSString *num = _numField.text;
    //   NSString *identify = _identifyField.text;
    NSString *password = _passwordField.text;
    NSString *confirm = _confirmField.text;
    if (![password isEqualToString:confirm]) {
        UIAlertView *alert2 = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请确认密码一致" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert2 show];
    }else{
        
        //FMDB
        //        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        //        NSString *documentDirectory=[paths objectAtIndex:0];
        //        NSString *dbPath=[documentDirectory stringByAppendingPathComponent:@"UserDatabase.db"];
        //
        //        FMDatabase *db = [FMDatabase databaseWithPath:dbPath];
        //        if (![db open]) {
        //            NSLog(@"Could not open db");
        //        }
        //        [db executeUpdate:@"create table PersonList(phone text,password text)"];
        //        [db executeUpdate:@"insert into PersonList(phone,password)values(?,?)",num,password];
        UIAlertController *alter = [UIAlertController alertControllerWithTitle:@"提示" message:@"注册成功" preferredStyle:UIAlertControllerStyleAlert];
        [alter addAction: [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
           // 点击OK返回上一界面
              [self.navigationController popViewControllerAnimated:YES];
        }] ];
        [self presentViewController:alter animated:YES completion:nil];
    }
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //防止键盘挡住输入框
 //   IQKeyboardReturnKeyHandler *returnKeyHandler= [[IQKeyboardReturnKeyHandler alloc]init];
    
  //  returnKeyHandler.lastTextFieldReturnKeyType=UIReturnKeyNext;
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    imageView.image = [UIImage imageNamed:@"背景.jpg"];
    imageView.backgroundColor=[UIColor colorWithRed:145/255.0 green:143/255.0 blue:143/255.0 alpha:0.85];
    [self.view addSubview:imageView];
    
        _numField = [[UITextField alloc] init];
        _numField.textColor = [UIColor colorWithRed:112/255.0 green:108/255.0 blue:108/255.0 alpha:1.0];
        _numField.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.75];
        _numField.borderStyle = UITextBorderStyleNone;         //设置边框类型
        _numField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;//文字内容 垂直居中
        _numField.placeholder = @"用户名";//设置默认提示文字
        _numField.font = [UIFont systemFontOfSize:22];//30px转成磅为单位＝22磅＝二号
        [self.view addSubview:_numField];
    
    
    
      [_numField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view).with.offset(70);
            make.right.equalTo(self.view).with.offset(-70);
            make.top.equalTo(self.view).with.offset(160);
            make.height.mas_equalTo(35);
    
        }];
    //
    //    _identifyField = [[UITextField alloc] init];
    //    _identifyField.textColor = [UIColor colorWithRed:112/255.0 green:108/255.0 blue:108/255.0 alpha:1.0];
    //    _identifyField.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.75];
    //    _identifyField.borderStyle = UITextBorderStyleNone;         //设置边框类型
    //    _identifyField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;//文字内容 垂直居中，此为UIControl的属性
    //    _identifyField.placeholder = @"验证码";//设置默认提示文字
    //    _identifyField.font = [UIFont systemFontOfSize:22];//30px转成磅为单位＝22磅＝二号
    //    [self.view addSubview:_identifyField];
    //    [_identifyField mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.left.equalTo(_numField.mas_left);
    //        make.right.equalTo(self.view).with.offset(-164);
    //        make.top.equalTo(_numField.mas_bottom).with.offset(8);
    //        make.height.mas_equalTo(30);
    //
    //    }];
    
    _passwordField = [[UITextField alloc] init];
    _passwordField.textColor = [UIColor colorWithRed:112/255.0 green:108/255.0 blue:108/255.0 alpha:1.0];
    _passwordField.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.75];
    _passwordField.borderStyle = UITextBorderStyleNone;         //设置边框类型
    _passwordField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;//文字内容 垂直居中，此为UIControl的属性
    _passwordField.placeholder = @"密码";//设置默认提示文字
    _passwordField.font = [UIFont systemFontOfSize:22];//30px转成磅为单位＝22磅＝二号
    _passwordField.secureTextEntry = YES; //密码
    [self.view addSubview:_passwordField];
    [_passwordField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_numField.mas_left);
        make.right.equalTo(_numField.mas_right);
        make.top.equalTo(_numField.mas_bottom).with.offset(15);
        // make.top.equalTo(_identifyField.mas_bottom).with.offset(8);
        make.height.mas_equalTo(35);
        
    }];
    
    _confirmField = [[UITextField alloc] init];
    _confirmField.textColor = [UIColor colorWithRed:112/255.0 green:108/255.0 blue:108/255.0 alpha:1.0];
    _confirmField.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.75];
    _confirmField.borderStyle = UITextBorderStyleNone;         //设置边框类型
    _confirmField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;//文字内容 垂直居中，此为UIControl的属性
    _confirmField.placeholder = @"确认密码";//设置默认提示文字
    _confirmField.font = [UIFont systemFontOfSize:22];//30px转成磅为单位＝22磅＝二号
    _confirmField.secureTextEntry = YES; //密码
    [self.view addSubview:_confirmField];
    [_confirmField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_passwordField.mas_left);
        make.right.equalTo(_passwordField.mas_right);
        make.top.equalTo(_passwordField.mas_bottom).with.offset(15);
        // make.top.equalTo(_identifyField.mas_bottom).with.offset(8);
        make.height.mas_equalTo(35);
        
    }];
    
    //    _gainButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    //    [_gainButton setBackgroundColor:[UIColor colorWithRed:235/255.0 green:166/255.0 blue:33/255.0 alpha:1.0]];
    //    [_gainButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    //    [_gainButton setTitleColor:[UIColor colorWithRed:112/255.0 green:108/255.0 blue:108/255.0 alpha:1.0] forState:UIControlStateNormal];
    //    _gainButton.titleLabel.font = [UIFont systemFontOfSize:22];
    //    [self.view addSubview:_gainButton];
    //    [_gainButton mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.left.equalTo(_identifyField.mas_right).with.offset(5);
    //        make.right.equalTo(self.view).with.offset(-20);
    //        make.top.equalTo(_numField.mas_bottom).with.offset(8);
    //        make.height.mas_equalTo(30);
    //    }];
    //
    //    //设置按钮的监听，即点击按钮时去执行的方法 监听方法只能接UIbutton这一个参数
    //    [_gainButton addTarget:self action:@selector(tapGainButton:) forControlEvents:UIControlEventTouchUpInside];
    
    _registerButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_registerButton setBackgroundColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.75]];
    [_registerButton setTitle:@"注册" forState:UIControlStateNormal];
    [_registerButton setTitleColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5] forState:UIControlStateNormal];
    _registerButton.titleLabel.font = [UIFont systemFontOfSize:27];
    [self.view addSubview:_registerButton];
    
    [_registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).with.offset(110);
        make.right.equalTo(self.view).with.offset(-110);
        make.top.equalTo(_confirmField.mas_bottom).with.offset(110);
        make.height.mas_equalTo(40);
        
    }];
    
    
    
    
    //文本框的输入状态获取
        [_numField addTarget:self action:@selector(textChange) forControlEvents:UIControlEventEditingChanged];
    //    [_identifyField addTarget:self action:@selector(textChange) forControlEvents:(UIControlEventEditingChanged)];
    [_passwordField addTarget:self action:@selector(textChange) forControlEvents:(UIControlEventEditingChanged)];
    [_confirmField addTarget:self action:@selector(textChange) forControlEvents:(UIControlEventEditingChanged)];
    //注册按钮设置为不能按的状态
    _registerButton.enabled = NO;
    
    
}

-(void)textChange
{
    //  当四个输入框都不为空才能点击按钮；进行提交
    if(_numField.text.length!=0&&/* _identifyField.text.length!=0&&*/_passwordField.text.length!=0&&_confirmField.text.length!=0)
    {
        _registerButton.enabled = YES ;  //  按钮可点击
        
        [_registerButton setTitleColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:1.0] forState:UIControlStateNormal];
        //确认添加按钮的点击事件
        //设置按钮的监听，即点击按钮时去执行的方法 监听方法只能接UIbutton这一个参数
        [_registerButton addTarget:self action:@selector(tapRegisterButton:) forControlEvents:UIControlEventTouchUpInside];
    }
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
