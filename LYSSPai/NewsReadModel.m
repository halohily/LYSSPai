//
//  NewsReadModel.m
//  LYSSPai
//
//  Created by 刘毅 on 2017/8/15.
//  Copyright © 2017年 halohily.com. All rights reserved.
//

#import "NewsReadModel.h"

@implementation NewsReadModel

+ (instancetype)NewsReadModelWithDic:(NSDictionary *)dic
{
    NewsReadModel *model = [[self alloc] init];
    model.like_total = dic[@"like_total"];
    model.comment_total = dic[@"comment_total"];
    model.newsURL = dic[@"newsURL"];
    model.newsID = dic[@"newsID"];
    return model;
}
@end
