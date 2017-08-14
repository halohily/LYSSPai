//
//  PaidNewsModel.h
//  LYSSPai
//
//  Created by 刘毅 on 2017/8/13.
//  Copyright © 2017年 halohily.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PaidNewsModel : NSObject

@property (nonatomic, strong) NSArray *PaidNewsData;

+ (instancetype)PaidNewsModelWithArr:(NSArray *)arr;

@end
