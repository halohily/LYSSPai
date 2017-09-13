//
//  LYLoadingView.h
//  LYSSPai
//
//  Created by 刘毅 on 2017/9/12.
//  Copyright © 2017年 halohily.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LYLoadingView : UIView
//隐藏传入view中的loadingview
+ (BOOL)hideLoadingViewFromView:(UIView *)view;
//为传入view显示一个loadingview
+ (BOOL)showLoadingViewToView:(UIView *)view WithFrame:(CGRect)frame;

@end

NS_ASSUME_NONNULL_END
