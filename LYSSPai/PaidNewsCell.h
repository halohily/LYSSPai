//
//  PaidNewsCell.h
//  LYSSPai
//
//  Created by 刘毅 on 2017/8/13.
//  Copyright © 2017年 halohily.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PaidNewsModel.h"

@interface PaidNewsCell : UITableViewCell

@property (nonatomic, strong) PaidNewsModel *model;

+ (instancetype)cellWithPaidNewsModel:(PaidNewsModel *)model;

@end
