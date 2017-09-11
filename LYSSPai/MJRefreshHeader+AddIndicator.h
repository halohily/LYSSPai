//
//  MJRefreshHeader+AddIndicator.h
//  LYSSPai
//
//  Created by 刘毅 on 2017/9/11.
//  Copyright © 2017年 halohily.com. All rights reserved.
//

#import <MJRefresh/MJRefresh.h>

@interface MJRefreshHeader (AddIndicator)

+ (instancetype)indicatorHeaderWithRefreshingTarget:(id)target refreshingAction:(SEL)action;

@end
