//
//  NewsModel.h
//  LYSSPai
//
//  Created by 刘毅 on 2017/8/13.
//  Copyright © 2017年 halohily.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsModel : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *summary;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *avator;
@property (nonatomic, copy) NSString *banner;
@property (nonatomic, copy) NSString *comment_total;
@property (nonatomic, copy) NSString *like_total;
@property (nonatomic, copy) NSString *released_at;
@property (nonatomic, copy) NSString *articleID;

+ (instancetype)NewsModelWithDic:(NSDictionary *)dic;

@end
