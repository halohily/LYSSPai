//
//  NewsCell.h
//  LYSSPai
//
//  Created by 刘毅 on 2017/8/13.
//  Copyright © 2017年 halohily.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsModel.h"

@interface NewsCell : UITableViewCell

@property (nonatomic, strong) NewsModel *model;

+ (instancetype)cellWithTableView:(UITableView *)tableview NewsModel:(NewsModel *)model;

@end
