//
//  AdsCell.m
//  LYSSPai
//
//  Created by 刘毅 on 2017/8/13.
//  Copyright © 2017年 halohily.com. All rights reserved.
//

#import "AdsCell.h"

@interface AdsCell()

@property (nonatomic, weak) UIScrollView *backScrollView;

@end
@implementation AdsCell
+ (instancetype)cellWithAdsModel:(AdsModel *)model
{
    AdsCell *cell = [[AdsCell alloc] init];
//    设置model后再进行UI布局
    cell.model = model;
    [cell setupUI];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)setupUI
{
    UIScrollView *backScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, LYScreenWidth, (LYScreenWidth - 50) * 0.53125 + 40)];
    backScrollView.backgroundColor = [UIColor whiteColor];
    backScrollView.contentSize = CGSizeMake(self.model.AdsData.count * (LYScreenWidth - 40) + 40, 170);
    backScrollView.showsHorizontalScrollIndicator = NO;
    [self.contentView addSubview:backScrollView];
    self.backScrollView = backScrollView;
    for (int i = 0; i < self.model.AdsData.count; i++)
    {
        UIView *shadowView = [[UIView alloc] init];
        shadowView.frame = CGRectMake(25 + (LYScreenWidth - 40) * i, 15, LYScreenWidth - 50, (LYScreenWidth - 50) * 0.53125);
        shadowView.layer.shadowColor = [UIColor blackColor].CGColor;
        shadowView.layer.shadowRadius = 5.0;
        shadowView.layer.shadowOpacity = 0.3;
        shadowView.layer.shadowOffset = CGSizeMake(-4, 4);
        UIImageView *AdsView = [[UIImageView alloc] init];
        AdsView.frame = CGRectMake(0, 0, LYScreenWidth - 50, (LYScreenWidth - 50) * 0.53125);
        AdsView.layer.cornerRadius = 5.0;
        AdsView.layer.masksToBounds = YES;
        [AdsView setImage:[UIImage imageNamed:[self.model.AdsData objectAtIndex:i][@"image"]]];
        AdsView.tag = i;
        [shadowView addSubview:AdsView];
        [self.backScrollView addSubview:shadowView];
    }
}

- (void)setModel:(AdsModel *)model
{
    _model = model;
}

- (void)AdsViewDidSelect:(UIButton *)button
{
    
}
@end
