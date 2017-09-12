//
//  LYSelectView.m
//  LYSSPai
//
//  Created by 刘毅 on 2017/8/15.
//  Copyright © 2017年 halohily.com. All rights reserved.
//

#import "LYSelectView.h"

@interface LYSelectView()

@property (nonatomic, weak) UIButton *Notification;
@property (nonatomic, weak) UIButton *Mail;
@property (nonatomic, weak) UIButton *SelectedBtn;
@property (nonatomic, weak) UIView *SliderLine;

@end
@implementation LYSelectView

- (instancetype)init
{
    self = [super initWithFrame:CGRectMake(0, 130, LYScreenWidth, 64)];
    [self setupUI];
    self.SelectedBtn = self.Notification;
    return self;
}

- (void)setupUI
{
    self.backgroundColor = [UIColor whiteColor];
//    通知按钮

    UIButton *notification = [[UIButton alloc] init];
    [self addSubview:notification];
    [notification mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).with.offset(0);
        make.bottom.mas_equalTo(self.mas_bottom).with.offset(-10);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(LYScreenWidth * 0.5);
    }];
    [notification setTitle:@"通知" forState:UIControlStateNormal];
    [notification setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    notification.titleLabel.font = [UIFont systemFontOfSize:18.0];
    notification.titleLabel.textAlignment = NSTextAlignmentCenter;
    [notification addTarget:self action:@selector(SelectBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    notification.tag = 0;
    self.Notification = notification;
    
//    消息按钮
    UIButton *mail = [[UIButton alloc] init];
    [self addSubview:mail];
    [mail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(LYScreenWidth * 0.5);
        make.bottom.mas_equalTo(self.mas_bottom).with.offset(-10);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(LYScreenWidth * 0.5);
    }];
    [mail setTitle:@"私信" forState:UIControlStateNormal];
    [mail setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    mail.titleLabel.font = [UIFont systemFontOfSize:18.0];
    mail.titleLabel.textAlignment = NSTextAlignmentCenter;
    [mail addTarget:self action:@selector(SelectBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    mail.tag = 1;
    self.Mail = mail;
//    底部细线
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = LYLineGray;
    [self addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left);
        make.width.mas_equalTo(LYScreenWidth);
        make.bottom.mas_equalTo(self.mas_bottom);
        make.height.mas_equalTo(SINGLE_LINE_WIDTH);
    }];
//    选中标识的小横条
    UIView *sliderLine = [[UIView alloc] init];
    sliderLine.backgroundColor = [UIColor blackColor];
    [self addSubview:sliderLine];
    [sliderLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).with.offset(0.25 * LYScreenWidth - 40);
        make.width.mas_equalTo(80);
        make.bottom.mas_equalTo(self.mas_bottom).with.offset(-1.5);
        make.height.mas_equalTo(2);
    }];
    self.SliderLine = sliderLine;
}
//选中按钮的点击事件
- (void)SelectBtnClicked:(UIButton *)sender
{
    if (sender == self.SelectedBtn)
    {
        return;
    }
    else
    {
        switch (sender.tag) {
            case 0:
                self.SelectedBtn = self.Notification;
                break;
                
            default:
                self.SelectedBtn = self.Mail;
                break;
        }
    }
//    通知代理
    if ([self.delegate respondsToSelector:@selector(ButtonClickedWithTag:)])
    {
        [self.delegate ButtonClickedWithTag:sender.tag];
    }
//    进行小横条的移动
    [self SliderLineMove];
}
//选中按钮变换至
- (void)selectBtnChangedTo:(NSUInteger)tag
{
    if (tag != self.SelectedBtn.tag)
    {
        switch (tag) {
            case 0:
                self.SelectedBtn = self.Notification;
                break;
            default:
                self.SelectedBtn = self.Mail;
                break;
        }

    }
//    进行小横条移动
    [self SliderLineMove];
}

- (void)SliderLineMove
{
    CGRect frame = self.SliderLine.frame;
    frame.origin.x = self.SelectedBtn.frame.origin.x + LYScreenWidth * 0.25 - 40;
    [UIView animateWithDuration:0.3 animations:^{
        self.SliderLine.frame = frame;
    }];
}
- (void)viewScrolledByY:(CGFloat)Y
{
    if (Y < -40)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.frame = CGRectMake(0, -40 - Y, LYScreenWidth, 64);
        });
    }
    if (Y >= -40)
    {
        self.frame = CGRectMake(0, 0, LYScreenWidth, 64);
    }
}
@end
