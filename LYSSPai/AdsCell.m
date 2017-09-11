//
//  AdsCell.m
//  LYSSPai
//
//  Created by 刘毅 on 2017/8/13.
//  Copyright © 2017年 halohily.com. All rights reserved.
//

#import "AdsCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <UIImageView+YYWebImage.h>
#import <CALayer+YYWebImage.h>
#import <UIImage+YYWebImage.h>

@interface AdsCell()

@property (nonatomic, weak) UIScrollView *backScrollView;

@end

@implementation AdsCell
+ (instancetype)cellWithTableview:(UITableView *)tableview AdsModel:(AdsModel *)model
{
    static NSString *identifier = @"AdsCell";
    AdsCell *cell = [tableview dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil)
    {
        cell = [[AdsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        //    设置model后再进行UI布局
        cell.model = model;
        [cell setupUI];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
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
        shadowView.userInteractionEnabled = YES;
        shadowView.tag = i;
        CALayer *AdsView = [[CALayer alloc] init];
        AdsView.frame = CGRectMake(0, 0, LYScreenWidth - 50, (LYScreenWidth - 50) * 0.53125);
        
        [AdsView yy_setImageWithURL:[NSURL URLWithString:self.model.AdsData[i][@"image"]] placeholder:nil options:kNilOptions progress:nil transform:^UIImage * _Nullable(UIImage * _Nonnull image, NSURL * _Nonnull url) {
            image = [image yy_imageByRoundCornerRadius:5.0];
            return image;
        } completion:nil];
        
        [shadowView.layer addSublayer:AdsView];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(AdsViewDidSelect:)];
        [shadowView addGestureRecognizer:tap];
        
        [self.backScrollView addSubview:shadowView];
    }
}

- (void)setModel:(AdsModel *)model
{
    _model = model;
}

- (void)AdsViewDidSelect:(UITapGestureRecognizer *)sender
{
    NSLog(@"adsView tapper: %ld",sender.view.tag);
    if ([self.delegate respondsToSelector:@selector(adsCellTappedByTag:)])
    {
        [self.delegate adsCellTappedByTag:sender.view.tag];
    }
}
@end
