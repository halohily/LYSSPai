//
//  FindModel.h
//  LYSSPai
//
//  Created by 刘毅 on 2017/8/14.
//  Copyright © 2017年 halohily.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FindModel : NSObject

@property (nonatomic ,copy) NSString *title;
@property (nonatomic, copy) NSString *banner;

+ (instancetype)FindModelWithDic:(NSDictionary *)dic;

@end
