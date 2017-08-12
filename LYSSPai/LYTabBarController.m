//
//  LYTabBarController.m
//  LYSSPai
//
//  Created by 刘毅 on 2017/8/12.
//  Copyright © 2017年 halohily.com. All rights reserved.
//

#import "LYTabBarController.h"
#import "HomePageViewController.h"
#import "FoundViewController.h"
#import "MessageViewController.h"
#import "LoginPageViewController.h"
#import "LYNavController.h"

@interface LYTabBarController ()

@end

@implementation LYTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTabbar];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupTabbar
{
    self.tabBar.translucent = NO;
    HomePageViewController *homePage = [[HomePageViewController alloc] init];
    [self addChildViewController:homePage withImage:[UIImage imageNamed:@"home_26x23_"] selectedImage:[UIImage imageNamed:@"home_pressed_26x23_"]];
    
    FoundViewController *foundPage = [[FoundViewController alloc] init];
    [self addChildViewController:foundPage withImage:[UIImage imageNamed:@"discover_18x24_"] selectedImage:[UIImage imageNamed:@"discover_pressed_18x24_"]];
    
    MessageViewController *messagePage = [[MessageViewController alloc] init];
    [self addChildViewController:messagePage withImage:[UIImage imageNamed:@"notification_20x24_"] selectedImage:[UIImage imageNamed:@"notification_pressed_20x24_"]];
    
    LoginPageViewController *loginPage = [[LoginPageViewController alloc] init];
    [self addChildViewController:loginPage withImage:[UIImage imageNamed:@"user_20x24_"] selectedImage:[UIImage imageNamed:@"user_pressed_20x24_"]];
}

- (void)addChildViewController:(UIViewController *)controller withImage:(UIImage *)image selectedImage:(UIImage *)selectImage
{
    LYNavController *nav = [[LYNavController alloc] initWithRootViewController:controller];
    [nav.tabBarItem setImage:image];
    [nav.tabBarItem setSelectedImage:selectImage];
    nav.tabBarItem.imageInsets = UIEdgeInsetsMake(5, 0,-5, 0);
    
    [self addChildViewController:nav];
    
}

@end
