//
//  FindModel.m
//  LYSSPai
//
//  Created by 刘毅 on 2017/8/14.
//  Copyright © 2017年 halohily.com. All rights reserved.
//

#import "FindModel.h"

@implementation FindModel

+ (instancetype)FindModelWithDic:(NSDictionary *)dic
{
    FindModel *model = [[self alloc] init];
    model.title = dic[@"title"];
    model.banner = dic[@"banner"];
    return model;
}
@end
