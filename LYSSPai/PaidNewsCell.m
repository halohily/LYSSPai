//
//  PaidNewsCell.m
//  LYSSPai
//
//  Created by 刘毅 on 2017/8/13.
//  Copyright © 2017年 halohily.com. All rights reserved.
//

#import "PaidNewsCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

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
        make.height.mas_equalTo(LYScreenWidth * 0.7);
    }];
    backScrollView.backgroundColor = [UIColor whiteColor];
    backScrollView.showsHorizontalScrollIndicator = NO;
    backScrollView.contentSize = CGSizeMake(35 + self.model.PaidNewsData.count * (LYScreenWidth * 0.55 + 15), LYScreenWidth * 0.7);
    
    for (int i = 0; i < self.model.PaidNewsData.count; i++)
    {
        UIImageView *paidNewsView = [[UIImageView alloc] initWithFrame:CGRectMake(25 + (LYScreenWidth * 0.55 + 15) * i, 0, LYScreenWidth * 0.55, LYScreenWidth * 0.7)];
        paidNewsView.layer.cornerRadius = 5.0;
        paidNewsView.layer.masksToBounds = YES;
        paidNewsView.tag = i;
        [paidNewsView sd_setImageWithURL:[NSURL URLWithString:self.model.PaidNewsData[i][@"banner"]]];
        
        UILabel *paidTitle = [[UILabel alloc] init];
        [paidNewsView addSubview:paidTitle];
        paidTitle.preferredMaxLayoutWidth = (LYScreenWidth * 0.55 - 30.0);
        [paidTitle setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
        paidTitle.numberOfLines = 0;
        [paidTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(paidNewsView.mas_left).with.offset(15.0);
            make.right.mas_equalTo(paidNewsView.mas_right).with.offset(-15.0);
            make.top.mas_equalTo(paidNewsView.mas_top).with.offset(50.0);
        }];
        paidTitle.textAlignment = NSTextAlignmentLeft;
        paidTitle.font = [UIFont boldSystemFontOfSize:20.0];
        paidTitle.textColor = [UIColor whiteColor];
        paidTitle.text = self.model.PaidNewsData[i][@"title"];
        
        UIImageView *avator = [[UIImageView alloc] init];
        [paidNewsView addSubview:avator];
        [avator mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(paidNewsView.mas_left).with.offset(15.0);
            make.top.mas_equalTo(paidNewsView.mas_bottom).with.offset(- 90);
            make.width.mas_equalTo(20.0);
            make.height.mas_equalTo(20.0);
        }];
        avator.layer.cornerRadius = 10;
        avator.layer.masksToBounds = YES;
        [avator sd_setImageWithURL:[NSURL URLWithString:self.model.PaidNewsData[i][@"avatar"]]];
        
        UILabel *nickname = [[UILabel alloc] init];
        [paidNewsView addSubview:nickname];
        [nickname mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(avator.mas_right).with.offset(10);
            make.top.mas_equalTo(paidNewsView.mas_bottom).with.offset(-85);
            make.right.mas_equalTo(paidNewsView.mas_right).with.offset(-30);
            make.height.mas_equalTo(12);
        }];
        nickname.textAlignment = NSTextAlignmentLeft;
        nickname.font = [UIFont boldSystemFontOfSize:12.0];
        nickname.textColor = [UIColor whiteColor];
        nickname.text = self.model.PaidNewsData[i][@"nickname"];
        
        UILabel *updateInfo = [[UILabel alloc] init];
        [paidNewsView addSubview:updateInfo];
        [updateInfo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(paidNewsView.mas_left).with.offset(15.0);
            make.top.mas_equalTo(paidNewsView.mas_bottom).with.offset(-50);
            make.right.mas_equalTo(paidNewsView.mas_right).with.offset(-15.0);
            make.height.mas_equalTo(12.0);
        }];
        updateInfo.font = [UIFont systemFontOfSize:12.0];
        updateInfo.textColor = [UIColor whiteColor];
        updateInfo.textAlignment = NSTextAlignmentLeft;
        
        NSString *update_total = self.model.PaidNewsData[i][@"update_total"];
        NSString *article_total = self.model.PaidNewsData[i][@"article_total"];
        if (update_total.integerValue >= article_total.integerValue)
        {
            updateInfo.text = [NSString stringWithFormat:@"已完结，共%@期", article_total];
        }
        else
        {
            updateInfo.text = [NSString stringWithFormat:@"已经更新至第%@期", update_total];
        }
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
