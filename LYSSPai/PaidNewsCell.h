//
//  PaidNewsCell.h
//  LYSSPai
//
//  Created by 刘毅 on 2017/8/13.
//  Copyright © 2017年 halohily.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PaidNewsModel.h"

@protocol PaidNewsCellDelegate <NSObject>

@optional
- (void)moreClicked;
- (void)paidNewsTappedByTag:(NSInteger)tag;

@end
@interface PaidNewsCell : UITableViewCell

@property (nonatomic, weak) id <PaidNewsCellDelegate> delegate;
@property (nonatomic, strong) PaidNewsModel *model;

+ (instancetype)cellWithPaidNewsModel:(PaidNewsModel *)model;

@end
