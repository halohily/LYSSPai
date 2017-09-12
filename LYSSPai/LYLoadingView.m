//
//  LYLoadingView.m
//  LYSSPai
//
//  Created by 刘毅 on 2017/9/12.
//  Copyright © 2017年 halohily.com. All rights reserved.
//

#import "LYLoadingView.h"

@implementation LYLoadingView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (BOOL)hideLoadingViewFromView:(UIView *)view
{
    NSEnumerator *subviewsEnum = [view.subviews reverseObjectEnumerator];
    for (UIView *subview in subviewsEnum)
    {
        if([subview isKindOfClass:self])
        {
            [subview removeFromSuperview];
            return YES;
        }
    }
    return NO;
}

+ (BOOL)showLoadingViewToView:(UIView *)view WithFrame:(CGRect)frame
{
    LYLoadingView *loadingView = [[LYLoadingView alloc] initWithFrame:frame];
    loadingView.backgroundColor = [UIColor whiteColor];
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    indicator.center = CGPointMake(frame.size.width/2, frame.size.height/2 - 100);
    [indicator startAnimating];
    [loadingView addSubview:indicator];
    [view addSubview:loadingView];
    return YES;
}
@end
