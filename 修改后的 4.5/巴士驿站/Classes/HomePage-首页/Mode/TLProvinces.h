//
//  TLProvinces.h
//  巴士驿站
//
//  Created by Edge on 16/9/20.
//  Copyright © 2016年 Edge. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TLProvinces : NSObject
@property(nonatomic,strong)NSArray *cities;
@property(nonatomic,strong)NSArray *peovince;
@property(nonatomic,strong)NSString *downs;
+(instancetype)ProvincesWithDict:(NSDictionary *)dict;
-(instancetype)initWithDict:(NSDictionary *)dict;
@end
