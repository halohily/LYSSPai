//
//  NewsModel.m
//  LYSSPai
//
//  Created by 刘毅 on 2017/8/13.
//  Copyright © 2017年 halohily.com. All rights reserved.
//

#import "NewsModel.h"

@implementation NewsModel

+ (instancetype)NewsModelWithDic:(NSDictionary *)dic
{
    NewsModel *model = [[self alloc] init];
    model.title = dic[@"title"];
    model.avator = dic[@"avator"];
    model.nickname = dic[@"nickname"];
    model.banner = dic[@"banner"];
    model.summary = dic[@"summary"];
    model.like_total = dic[@"like_total"];
    model.comment_total = dic[@"comment_total"];
    model.released_at = dic[@"released_at"];
    return model;
}
@end
