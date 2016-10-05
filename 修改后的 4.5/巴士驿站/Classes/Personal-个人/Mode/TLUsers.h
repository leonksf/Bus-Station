//
//  TLUsers.h
//  巴士驿站
//
//  Created by Edge on 16/7/17.
//  Copyright © 2016年 Edge. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Coding.h"
@interface TLUsers : Coding

//  名字
@property(nonatomic,copy)NSString *name;
//  昵称
@property(nonatomic,copy)NSString *nickName;

//  乘客名字
@property(nonatomic,copy)NSString *passName;
//  身份证号
@property(nonatomic,copy)NSString *passID;
//  乘客证件类型
@property(nonatomic,copy)NSString *pPaper;
//  乘客手机号
@property(nonatomic,copy)NSString *pNumber;

//@property BOOL selectClick;
//@property (assign, readwrite) BOOL selectClick;

@end
