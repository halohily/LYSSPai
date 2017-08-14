//
//  FindCell.h
//  LYSSPai
//
//  Created by 刘毅 on 2017/8/14.
//  Copyright © 2017年 halohily.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FindModel.h"
@interface FindCell : UITableViewCell

@property (nonatomic, strong) FindModel *model;

+ (instancetype)FindCellWithTableView:(UITableView *)tableview FindModel:(FindModel *)model;

@end
