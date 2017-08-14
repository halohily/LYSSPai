//
//  AdsCell.h
//  LYSSPai
//
//  Created by 刘毅 on 2017/8/13.
//  Copyright © 2017年 halohily.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AdsModel.h"

@interface AdsCell : UITableViewCell

@property (nonatomic, strong) AdsModel *model;

+ (instancetype)cellWithAdsModel:(AdsModel *)model;

@end
