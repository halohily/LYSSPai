//
//  PaidNewsModel.m
//  LYSSPai
//
//  Created by 刘毅 on 2017/8/13.
//  Copyright © 2017年 halohily.com. All rights reserved.
//

#import "PaidNewsModel.h"

@implementation PaidNewsModel

+ (instancetype)PaidNewsModelWithArr:(NSArray *)arr
{
    PaidNewsModel *model = [[self alloc] init];
    model.PaidNewsData = arr;
    model.paidNewsFrame = [PaidNewsFrameModel PaidNewsFrameModelWithCount:arr.count];
    model.cellHeight = LYScreenWidth * 0.8 + 60;
    return model;
}
@end
