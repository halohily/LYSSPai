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

+ (BOOL)hideLoadingViewFromView:(UIView *)view;

+ (BOOL)showLoadingViewToView:(UIView *)view WithFrame:(CGRect)frame;

@end

NS_ASSUME_NONNULL_END
