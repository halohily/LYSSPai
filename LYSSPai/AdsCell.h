//
//  AdsCell.h
//  LYSSPai
//
//  Created by 刘毅 on 2017/8/13.
//  Copyright © 2017年 halohily.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AdsModel.h"

@protocol AdsCellDelegate <NSObject>

@optional
- (void)adsCellTappedByTag:(NSInteger)tag;

@end

@interface AdsCell : UITableViewCell

@property (nonatomic, weak) id <AdsCellDelegate> delegate;
@property (nonatomic, strong) AdsModel *model;

+ (instancetype)cellWithAdsModel:(AdsModel *)model;

@end
