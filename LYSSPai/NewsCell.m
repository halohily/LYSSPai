//
//  NewsCell.m
//  LYSSPai
//
//  Created by 刘毅 on 2017/8/13.
//  Copyright © 2017年 halohily.com. All rights reserved.
//

#import "NewsCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface NewsCell() <UIGestureRecognizerDelegate>

@property (nonatomic, weak) UIImageView *avator;
@property (nonatomic, weak) UILabel *nickname;
@property (nonatomic, weak) UIButton *menu;
@property (nonatomic, weak) UIImageView *banner;
@property (nonatomic, weak) UILabel *articleTitle;
@property (nonatomic, weak) UILabel *rmdDescription;
@property (nonatomic, weak) UIImageView *likeIcon;
@property (nonatomic, weak) UILabel *likeAndComment;
@property (nonatomic, weak) UILabel *postTime;

@end

@implementation NewsCell

+ (instancetype)cellWithTableView:(UITableView *)tableview NewsModel:(NewsModel *)model
{
    static NSString *identifier = @"newsCell";
    NewsCell *cell = [tableview dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil)
    {
        cell = [[NewsCell alloc] init];
        [cell setupUI];
    }
    cell.model = model;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)setupUI
{
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    UIImageView *avator = [[UIImageView alloc] init];
    [self.contentView addSubview:avator];
    [avator mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.mas_equalTo(self.contentView.mas_left).with.offset(25.0);
        make.top.mas_equalTo(self.contentView.mas_top).with.offset(15.0);
        make.width.mas_equalTo(30.0);
        make.height.mas_equalTo(30.0);
    }];
    avator.layer.cornerRadius = 15.0;
    avator.layer.masksToBounds = YES;
    self.avator = avator;
    
    UILabel *nickname = [[UILabel alloc] init];
    [self.contentView addSubview:nickname];
    [nickname mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.avator.mas_right).with.offset(10.0);
        make.top.mas_equalTo(self.contentView.mas_top).with.offset(22.5);
        make.width.mas_equalTo(150.0);
    }];
    nickname.textAlignment = NSTextAlignmentLeft;
    nickname.font = [UIFont systemFontOfSize:14.0];
    nickname.textColor = UIColor(102, 102, 102);
    self.nickname = nickname;
    
    UIButton *menu = [[UIButton alloc] init];
    [self.contentView addSubview:menu];
    [menu setImage:[UIImage imageNamed:@"more_18x4_"] forState:UIControlStateNormal];
    [menu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top).with.offset(17.5);
        make.right.mas_equalTo(self.contentView.mas_right).with.offset(-25.0);
        make.width.mas_equalTo(25.0);
        make.height.mas_equalTo(25.0);
    }];
    [menu addTarget:self action:@selector(menuClicked) forControlEvents:UIControlEventTouchUpInside];
    self.menu = menu;
    
    UIImageView *banner = [[UIImageView alloc] init];
    [self.contentView addSubview:banner];
    [banner mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).with.offset(25.0);
        make.top.mas_equalTo(self.avator.mas_bottom).with.offset(10.0);
        make.right.mas_equalTo(self.contentView.mas_right).with.offset(-25.0);
        make.height.mas_equalTo(banner.mas_width).multipliedBy(0.3331);
    }];
    banner.layer.cornerRadius = 5.0;
    banner.layer.masksToBounds = YES;
    self.banner = banner;
    
    UILabel *title = [[UILabel alloc] init];
    [self.contentView addSubview:title];
    title.textAlignment = NSTextAlignmentLeft;
    title.font = [UIFont boldSystemFontOfSize:20.0];
//    title.font = [UIFont systemFontOfSize:18.0];
    title.textColor = [UIColor blackColor];
//    设置行数自适应，无需写masonry中的高度
    title.preferredMaxLayoutWidth = (LYScreenWidth - 50.0);
    [title setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    title.numberOfLines = 0;
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).with.offset(25.0);
        make.top.mas_equalTo(self.banner.mas_bottom).with.offset(15.0);
        make.right.mas_equalTo(self.contentView.mas_right).with.offset(-25.0);
    }];
    self.articleTitle = title;
    
    UILabel *articleDes = [[UILabel alloc] init];
    [self.contentView addSubview:articleDes];
    articleDes.preferredMaxLayoutWidth = (LYScreenWidth - 50.0);
    [articleDes setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    articleDes.numberOfLines = 0;
    [articleDes mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).with.offset(25.0);
        make.top.mas_equalTo(self.articleTitle.mas_bottom).with.offset(10.0);
        make.right.mas_equalTo(self.contentView.mas_right).with.offset(-25.0);
    }];
    articleDes.textAlignment = NSTextAlignmentLeft;
    articleDes.font = [UIFont systemFontOfSize:14.0];
    articleDes.textColor = UIColor(170, 170, 170);
    self.rmdDescription = articleDes;
    
    UIImageView *like = [[UIImageView alloc] init];
    [self.contentView addSubview:like];
    [like setImage:[UIImage imageNamed:@"like_20x17_"]];
    [like mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).with.offset(25.0);
        make.top.mas_equalTo(self.rmdDescription.mas_bottom).with.offset(12.0);
        make.width.mas_equalTo(14.0);
        make.height.mas_equalTo(11.9);
    }];
    self.likeIcon = like;
    
    UILabel *comments = [[UILabel alloc] init];
    [self.contentView addSubview:comments];
    [comments mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.likeIcon.mas_right).with.offset(8.0);
        make.top.mas_equalTo(self.rmdDescription.mas_bottom).with.offset(10.0);
        make.width.mas_equalTo(150.0);
        make.height.mas_equalTo(14.0);
    }];
    comments.textAlignment = NSTextAlignmentLeft;
    comments.font = [UIFont systemFontOfSize:12.0];
    comments.textColor = UIColor(107, 107, 107);
    self.likeAndComment = comments;
    
    UILabel *timeLabel = [[UILabel alloc] init];
    [self.contentView addSubview:timeLabel];
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.rmdDescription.mas_bottom).with.offset(10.0);
        make.right.mas_equalTo(self.contentView.mas_right).with.offset(-25.0);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(14.0);
    }];
    timeLabel.textAlignment = NSTextAlignmentRight;
    timeLabel.font = [UIFont systemFontOfSize:12.0];
    timeLabel.textColor = UIColor(208, 208, 208);
    self.postTime = timeLabel;
    
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeLeft)];
    swipe.delegate = self;
    swipe.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.contentView addGestureRecognizer:swipe];
}
- (void)setModel:(NewsModel *)model
{
    _model = model;
    [self.avator sd_setImageWithURL:[NSURL URLWithString:model.avator]];
    self.nickname.text = model.nickname;
    self.articleTitle.text = model.title;
    [self.banner sd_setImageWithURL:[NSURL URLWithString:model.banner]];
//    NSLog(@"screen width %f", LYScreenWidth);
//    NSLog(@"length::: %ld", model.summary.length);
    if((float)model.summary.length/LYScreenWidth > 0.11)
    {
        NSString *temStr = [model.summary substringToIndex:(int)(LYScreenWidth * 0.11)];
        model.summary = [temStr stringByAppendingString:@"…"];
    }
    self.rmdDescription.text = model.summary;
    self.likeAndComment.text = [NSString stringWithFormat:@"%@  · %@ 评论", model.like_total, model.comment_total];
    self.postTime.text = @"18 小时前";
}

- (void)menuClicked
{
    if([self.delegate respondsToSelector:@selector(menuButtonClickedWithID:)])
    {
        [self.delegate menuButtonClickedWithID:self.model.articleID];
    }
}

- (void)swipeLeft
{
    NSLog(@"swipe left");
    if([self.delegate respondsToSelector:@selector(swipeLeft)])
    {
        [self.delegate swipeLeft];
    }
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    return YES;
}
@end
