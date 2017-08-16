//
//  LYSelectView.h
//  LYSSPai
//
//  Created by 刘毅 on 2017/8/15.
//  Copyright © 2017年 halohily.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LYSelectViewDelegate <NSObject>

@optional
//按钮点击事件的代理
- (void)ButtonClickedWithTag:(NSInteger )tag;

@end

@interface LYSelectView : UIView

@property (nonatomic, weak) id <LYSelectViewDelegate> delegate;
//变更选中按钮至
- (void)selectBtnChangedTo:(NSUInteger )tag;
//页面滑动的Y值
- (void)viewScrolledByY:(CGFloat )Y;
@end
