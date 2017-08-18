//
//  SFSafariViewController+TabbarSetting.m
//  LYSSPai
//
//  Created by 刘毅 on 2017/8/18.
//  Copyright © 2017年 halohily.com. All rights reserved.
//

#import "SFSafariViewController+TabbarSetting.h"

@implementation SFSafariViewController (TabbarSetting)

- (instancetype)initSFWithURL:(NSURL *)URL
{
    self = [self initWithURL:URL];
    self.hidesBottomBarWhenPushed = YES;
    return self;
}
@end
