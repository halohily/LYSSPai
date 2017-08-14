//
//  AdsModel.m
//  LYSSPai
//
//  Created by 刘毅 on 2017/8/13.
//  Copyright © 2017年 halohily.com. All rights reserved.
//

#import "AdsModel.h"

@implementation AdsModel

+ (instancetype)AdsModelWithArr:(NSArray *)arr
{
    AdsModel *model = [[self alloc] init];
    model.AdsData = arr;
    return model;
}
@end
