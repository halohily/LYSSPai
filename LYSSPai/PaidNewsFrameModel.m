//
//  PaidNewsFrameModel.m
//  LYSSPai
//
//  Created by 刘毅 on 2017/9/8.
//  Copyright © 2017年 halohily.com. All rights reserved.
//

#import "PaidNewsFrameModel.h"

@implementation PaidNewsFrameModel

+(instancetype)PaidNewsFrameModelWithCount:(NSInteger)count
{
    PaidNewsFrameModel *model = [[self alloc] init];
    
    float cellWidth = LYScreenWidth * 0.55;
    float cellHeight = LYScreenWidth * 0.7;
    model.cellTitleFrame = CGRectMake(25, 10, 100, 18);
    model.moreFrame = CGRectMake(LYScreenWidth - 65, 11, 40, 16);
    model.backScrollViewFrame = CGRectMake(0, 43, LYScreenWidth, cellHeight);
    model.paidNewsViewFrames = [[NSMutableArray alloc] init];
    model.paidTitleFrames = [[NSMutableArray alloc] init];
    model.avatorFrames = [[NSMutableArray alloc] init];
    model.nicknameFrames = [[NSMutableArray alloc] init];
    model.updateInfoFrames = [[NSMutableArray alloc] init];

    for ( int i = 0; i < count; i++)
    {
        NSValue *paidNewsViewFrame = [NSValue valueWithCGRect:CGRectMake(25 + (cellWidth + 15) * i, 0, cellWidth, cellHeight)];
        [model.paidNewsViewFrames addObject:paidNewsViewFrame];
        NSValue *avatorFrame = [NSValue valueWithCGRect:CGRectMake(15, cellHeight - 90, 20, 20)];
        [model.avatorFrames addObject:avatorFrame];
        NSValue *nicknameFrame = [NSValue valueWithCGRect:CGRectMake(45, cellHeight - 85, cellWidth - 75, 12)];
        [model.nicknameFrames addObject:nicknameFrame];
        NSValue *updateInfoFrame = [NSValue valueWithCGRect:CGRectMake(15, cellHeight - 50, cellWidth - 30, 12)];
        [model.updateInfoFrames addObject:updateInfoFrame];
    }
    return model;
}

@end
