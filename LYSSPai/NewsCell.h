//
//  NewsCell.h
//  LYSSPai
//
//  Created by 刘毅 on 2017/8/13.
//  Copyright © 2017年 halohily.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsModel.h"

@protocol NewsCellDelegate <NSObject>

@optional
- (void)menuButtonClickedWithID:(NSString *)articleID;
- (void)swipeLeft;

@end
@interface NewsCell : UITableViewCell

@property (nonatomic, strong) NewsModel *model;
@property (nonatomic, weak) id<NewsCellDelegate> delegate;

+ (instancetype)cellWithTableView:(UITableView *)tableview NewsModel:(NewsModel *)model;

@end
