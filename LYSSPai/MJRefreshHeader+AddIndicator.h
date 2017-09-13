//
//  MJRefreshHeader+AddIndicator.h
//  LYSSPai
//
//  Created by 刘毅 on 2017/9/11.
//  Copyright © 2017年 halohily.com. All rights reserved.
//

#import <MJRefresh/MJRefresh.h>

@interface MJRefreshHeader (AddIndicator)
//简单自定义一个带有转动菊花的header
+ (instancetype)indicatorHeaderWithRefreshingTarget:(id)target refreshingAction:(SEL)action;

@end
