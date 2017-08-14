//
//  AdsModel.h
//  LYSSPai
//
//  Created by 刘毅 on 2017/8/13.
//  Copyright © 2017年 halohily.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AdsModel : NSObject

@property (nonatomic, strong) NSArray *AdsData;

+ (instancetype)AdsModelWithArr:(NSArray *)arr;

@end
