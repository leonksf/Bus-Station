//
//  TLPayView.m
//  巴士驿站
//
//  Created by 胡潇炜 on 16/7/14.
//  Copyright © 2016年 Edge. All rights reserved.
//

#import "TLPayView.h"

@implementation TLPayView

/**
 *  自定义支付tabBar
 *
 */
-(id)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithRed:113/225.0 green:193/225.0 blue:237/225.0 alpha:1];
        
        self.name = [self creatLabel:self.name str:@"代付款:¥" textAlignment:NSTextAlignmentLeft];
        self.number = [self creatLabel:self.number str:@"263.5" textAlignment:NSTextAlignmentLeft];
        self.payButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.payButton.backgroundColor = [UIColor orangeColor];
        [self.payButton setTitle:@"去支付" forState:UIControlStateNormal];
        [self.payButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self addSubview:self.payButton];
        
        [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).with.offset(10);
            make.top.equalTo(self.mas_top).with.offset(10);
            make.bottom.equalTo(self.mas_bottom).with.offset(-10);
            make.width.equalTo(@80);
        }];
        
        [self.number mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.name.mas_right);
            make.top.equalTo(self.mas_top).with.offset(10);
            make.bottom.equalTo(self.mas_bottom).with.offset(-10);
            make.width.equalTo(@80);
        }];
        
        [self.payButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).with.offset(-10);
            make.top.equalTo(self.mas_top).with.offset(10);
            make.bottom.equalTo(self.mas_bottom).with.offset(-10);
            make.width.equalTo(@150);
        }];
        
    }
    return self;
}

-(UILabel *)creatLabel:(UILabel *)label str:(NSString *)str textAlignment:(NSTextAlignment)textAlignment
{
    label = [[UILabel alloc] init];
    label.text = str;
    label.textAlignment = textAlignment;
    label.textColor = [UIColor whiteColor];
    [self addSubview:label];
    return label;
}


@end
