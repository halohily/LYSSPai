//
//  PaidNewsModel.h
//  LYSSPai
//
//  Created by 刘毅 on 2017/8/13.
//  Copyright © 2017年 halohily.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PaidNewsFrameModel.h"

@interface PaidNewsModel : NSObject

@property (nonatomic, strong) NSArray *PaidNewsData;
@property (nonatomic, strong) PaidNewsFrameModel *paidNewsFrame;
@property (nonatomic, assign) CGFloat cellHeight;

+ (instancetype)PaidNewsModelWithArr:(NSArray *)arr;

@end
