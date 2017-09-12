//
//  MJRefreshHeader+AddIndicator.m
//  LYSSPai
//
//  Created by 刘毅 on 2017/9/11.
//  Copyright © 2017年 halohily.com. All rights reserved.
//

#import "MJRefreshHeader+AddIndicator.h"

@implementation MJRefreshHeader (AddIndicator)

+ (instancetype)indicatorHeaderWithRefreshingTarget:(id)target refreshingAction:(SEL)action
{
    MJRefreshHeader *header =  [MJRefreshHeader headerWithRefreshingTarget:target refreshingAction:action];
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    indicator.center = CGPointMake(LYScreenWidth/2, 40);
    [indicator startAnimating];
    [header addSubview:indicator];
    return header;
}
@end
