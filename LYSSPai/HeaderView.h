//
//  HeaderView.h
//  LYSSPai
//
//  Created by 刘毅 on 2017/8/12.
//  Copyright © 2017年 halohily.com. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol HeaderViewDelegate <NSObject>

@optional
//导航右侧按钮的时间代理
- (void)BtnClicked;

@end

@interface HeaderView : UIView

@property (nonatomic, weak) id <HeaderViewDelegate> delegate;
//button参数可为空的初始化方法
- (instancetype)initWithTitle:(NSString *)title Button:(nullable NSString *)button;
//scrollview的offset Y值变化时，视图作相应变化
- (void)viewScrolledByY:(float)Y;
@end
