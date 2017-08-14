//
//  PaidNewsCell.m
//  LYSSPai
//
//  Created by 刘毅 on 2017/8/13.
//  Copyright © 2017年 halohily.com. All rights reserved.
//

#import "PaidNewsCell.h"

@implementation PaidNewsCell

+ (instancetype)cellWithPaidNewsModel:(PaidNewsModel *)model
{
    PaidNewsCell *cell = [[PaidNewsCell alloc] init];
    cell.model = model;
    [cell setupUI];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)setupUI
{
    UILabel *cellTitle = [[UILabel alloc] init];
    [self.contentView addSubview:cellTitle];
    [cellTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).with.offset(25.0);
        make.top.mas_equalTo(self.contentView.mas_top).with.offset(10.0);
        make.width.mas_equalTo(100.0);
        make.height.mas_equalTo(18.0);
    }];
    cellTitle.font = [UIFont boldSystemFontOfSize:16.0];
    cellTitle.textAlignment = NSTextAlignmentLeft;
    cellTitle.text = @"付费栏目";
    
    UIButton *more = [[UIButton alloc] init];
    [self.contentView addSubview:more];
    [more mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top).with.offset(11.0);
        make.right.mas_equalTo(self.contentView.mas_right).with.offset(-25.0);
        make.width.mas_equalTo(40.0);
        make.height.mas_equalTo(16.0);
    }];
    [more setTitle:@"更多" forState:UIControlStateNormal];
    [more setTitleColor:UIColor(170, 170, 170) forState:UIControlStateNormal];
    more.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [more addTarget:self action:@selector(moreBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    
    UIScrollView *backScrollView = [[UIScrollView alloc] init];
    [self.contentView addSubview:backScrollView];
    [backScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).with.offset(0);
        make.top.mas_equalTo(cellTitle.mas_bottom).with.offset(15.0);
        make.right.mas_equalTo(self.contentView.mas_right).with.offset(0);
        make.height.mas_equalTo(LYScreenWidth * 0.8);
    }];
    backScrollView.backgroundColor = [UIColor whiteColor];
    backScrollView.showsHorizontalScrollIndicator = NO;
    backScrollView.contentSize = CGSizeMake(35 + self.model.PaidNewsData.count * (LYScreenWidth * 0.55 + 15), LYScreenWidth * 0.8);
    
    for (int i = 0; i < self.model.PaidNewsData.count; i++)
    {
        UIImageView *paidNewsView = [[UIImageView alloc] initWithFrame:CGRectMake(25 + (LYScreenWidth * 0.55 + 15) * i, 0, LYScreenWidth * 0.55, LYScreenWidth * 0.8)];
        paidNewsView.layer.cornerRadius = 5.0;
        paidNewsView.layer.masksToBounds = YES;
        paidNewsView.tag = i;
        [paidNewsView setImage:[UIImage imageNamed:[self.model.PaidNewsData objectAtIndex:i][@"image"]]];
        [backScrollView addSubview:paidNewsView];
    }
}

- (void)setModel:(PaidNewsModel *)model
{
    _model = model;
}

- (void)moreBtnClicked
{
    
}

@end
