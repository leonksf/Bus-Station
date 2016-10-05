//
//  TLProvinces.m
//  巴士驿站
//
//  Created by Edge on 16/9/20.
//  Copyright © 2016年 Edge. All rights reserved.
//

#import "TLProvinces.h"

@implementation TLProvinces
-(instancetype)initWithDict:(NSDictionary *)dict{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dict];
          // NSLog(@"dict_______________________________________%@",dict);
    }
    return self;
}

+(instancetype)ProvincesWithDict:(NSDictionary *)dict{
    
    return [[self alloc]initWithDict:dict];
   // NSLog(@"%@",dict);
}
@end
