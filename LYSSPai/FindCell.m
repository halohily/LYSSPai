//
//  FindCell.m
//  LYSSPai
//
//  Created by 刘毅 on 2017/8/14.
//  Copyright © 2017年 halohily.com. All rights reserved.
//

#import "FindCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface FindCell()

@property (nonatomic, weak) UIImageView *banner;
@property (nonatomic, weak) UILabel *title;

@end
@implementation FindCell

+ (instancetype)FindCellWithTableView:(UITableView *)tableview FindModel:(FindModel *)model
{
    static NSString *identifier = @"findCell";
    FindCell *cell = [tableview dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil)
    {
        cell = [[FindCell alloc] init];
        [cell setupUI];
    }
    cell.model = model;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)setupUI
{
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    UIImageView *banner = [[UIImageView alloc] init];
    [self.contentView addSubview:banner];
    [banner mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).with.offset(25.0);
        make.right.mas_equalTo(self.contentView.mas_right).with.offset(-25.0);
        make.top.mas_equalTo(self.contentView.mas_top).with.offset(10.0);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-10.0);
    }];
    banner.layer.cornerRadius = 5.0;
    banner.layer.masksToBounds = YES;
    self.banner = banner;
    
    UILabel *title = [[UILabel alloc] init];
    [self.banner addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.banner.mas_left).with.offset(25.0);
        make.right.mas_equalTo(self.banner.mas_right).with.offset(-25.0);
        make.top.mas_equalTo(LYScreenWidth * 0.25 - 40);
        make.height.mas_equalTo(60.0);
    }];
    title.textColor = [UIColor whiteColor];
    title.textAlignment = NSTextAlignmentCenter;
    title.font = [UIFont boldSystemFontOfSize:22.0];
    title.preferredMaxLayoutWidth = (LYScreenWidth - 50.0);
    [title setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    title.numberOfLines = 0;
    self.title = title;
}

- (void)setModel:(FindModel *)model
{
    [self.banner sd_setImageWithURL:[NSURL URLWithString:model.banner]];
    self.title.text = model.title;
}
@end
