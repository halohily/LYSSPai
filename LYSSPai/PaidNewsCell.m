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

+ (instancetype)cellWithTableView:(UITableView *)tableview PaidNewsModel:(PaidNewsModel *)model
{
    static NSString *identifier = @"paidCell";
    PaidNewsCell *cell = [tableview dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil)
    {
        cell = [[PaidNewsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.model = model;
        [cell setupUI];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (void)setupUI
{
    float cellWidth = LYScreenWidth * 0.55;
    float cellHeight = LYScreenWidth * 0.7;
    UILabel *cellTitle = [[UILabel alloc] init];
    [self.contentView addSubview:cellTitle];
    cellTitle.frame = CGRectMake(25, 10, 100, 18);
    cellTitle.font = [UIFont boldSystemFontOfSize:16.0];
    cellTitle.textAlignment = NSTextAlignmentLeft;
    cellTitle.text = @"付费栏目";
    
    UIButton *more = [[UIButton alloc] init];
    [self.contentView addSubview:more];
    more.frame = CGRectMake(LYScreenWidth - 65, 11, 40, 16);
    [more setTitle:@"更多" forState:UIControlStateNormal];
    [more setTitleColor:UIColor(170, 170, 170) forState:UIControlStateNormal];
    more.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [more addTarget:self action:@selector(moreBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    
    UIScrollView *backScrollView = [[UIScrollView alloc] init];
    [self.contentView addSubview:backScrollView];
    backScrollView.frame = CGRectMake(0, 43, LYScreenWidth, cellHeight);
    backScrollView.backgroundColor = [UIColor whiteColor];
    backScrollView.showsHorizontalScrollIndicator = NO;
    backScrollView.contentSize = CGSizeMake(35 + self.model.PaidNewsData.count * (cellWidth + 15), cellHeight);
    
    for (int i = 0; i < self.model.PaidNewsData.count; i++)
    {
        UIImageView *paidNewsView = [[UIImageView alloc] initWithFrame:CGRectMake(25 + (cellWidth + 15) * i, 0, cellWidth, cellHeight)];
        paidNewsView.layer.cornerRadius = 5.0;
        paidNewsView.layer.masksToBounds = YES;
        paidNewsView.tag = i;
        [paidNewsView sd_setImageWithURL:[NSURL URLWithString:self.model.PaidNewsData[i][@"banner"]]];
        
        UILabel *paidTitle = [[UILabel alloc] init];
        [paidNewsView addSubview:paidTitle];
        paidTitle.text = self.model.PaidNewsData[i][@"title"];
        paidTitle.numberOfLines = 0;
        NSDictionary *attribute = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:20]};
        CGSize labelSize = [paidTitle.text boundingRectWithSize:CGSizeMake(cellWidth - 30, 50) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
        paidTitle.textAlignment = NSTextAlignmentLeft;
        paidTitle.font = [UIFont boldSystemFontOfSize:20.0];
        paidTitle.frame = CGRectMake(15, 50, cellWidth - 30, labelSize.height);
        paidTitle.textColor = [UIColor whiteColor];
        
        UIImageView *avator = [[UIImageView alloc] init];
        [paidNewsView addSubview:avator];
        avator.frame = CGRectMake(15, cellHeight - 90, 20, 20);
        avator.layer.cornerRadius = 10;
        avator.layer.masksToBounds = YES;
        [avator sd_setImageWithURL:[NSURL URLWithString:self.model.PaidNewsData[i][@"avatar"]]];
        
        UILabel *nickname = [[UILabel alloc] init];
        [paidNewsView addSubview:nickname];
        nickname.frame = CGRectMake(45, cellHeight - 85, cellWidth - 75, 12);
        nickname.textAlignment = NSTextAlignmentLeft;
        nickname.font = [UIFont boldSystemFontOfSize:12.0];
        nickname.textColor = [UIColor whiteColor];
        nickname.text = self.model.PaidNewsData[i][@"nickname"];
        
        UILabel *updateInfo = [[UILabel alloc] init];
        [paidNewsView addSubview:updateInfo];
        updateInfo.frame = CGRectMake(15, cellHeight - 50, cellWidth - 30, 12);
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
        paidNewsView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(paidViewDidSelect:)];
        [paidNewsView addGestureRecognizer:tap];
    }
}

- (void)setModel:(PaidNewsModel *)model
{
    _model = model;
}

- (void)moreBtnClicked
{
    if ([self.delegate respondsToSelector:@selector(moreClicked)])
    {
        [self.delegate moreClicked];
    }
}

- (void)paidViewDidSelect:(UITapGestureRecognizer *)sender
{
    NSLog(@"adsView tapper: %ld", sender.view.tag);
    if ([self.delegate respondsToSelector:@selector(paidNewsTappedByTag:)])
    {
        [self.delegate paidNewsTappedByTag:sender.view.tag];
    }
}

@end
