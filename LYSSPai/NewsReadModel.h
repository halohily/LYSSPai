//
//  NewsReadModel.h
//  LYSSPai
//
//  Created by 刘毅 on 2017/8/15.
//  Copyright © 2017年 halohily.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsReadModel : NSObject

@property (nonatomic, copy) NSString *like_total;
@property (nonatomic, copy) NSString *comment_total;
@property (nonatomic, copy) NSString *newsURL;
@property (nonatomic, copy) NSString *newsID;

+ (instancetype)NewsReadModelWithDic:(NSDictionary *)dic;

@end
