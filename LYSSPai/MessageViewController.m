//
//  MessageViewController.m
//  LYSSPai
//
//  Created by 刘毅 on 2017/8/12.
//  Copyright © 2017年 halohily.com. All rights reserved.
//

#import "MessageViewController.h"
#import "HeaderView.h"
#import "LYSelectView.h"
#import "MJRefreshHeader+AddIndicator.h"

@interface MessageViewController ()<UIScrollViewDelegate, LYSelectViewDelegate>

@property (nonatomic, strong) HeaderView *headerView;

@property (nonatomic, strong) UIScrollView *contentView;
@property (nonatomic, strong) UIScrollView *backView;
//用户记录此时选中的按钮
@property (nonatomic, assign) NSInteger selectedTag;

@property (nonatomic, strong) LYSelectView *selectView;
@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupUI
{
    self.selectedTag = 0;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
//    底部scrollview，用于竖向滑动
    UIScrollView *backScrollView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    backScrollView.showsVerticalScrollIndicator = NO;
    backScrollView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backScrollView];

    backScrollView.delegate = self;
    self.backView = backScrollView;
    MJRefreshHeader *refreshHeader = [MJRefreshHeader indicatorHeaderWithRefreshingTarget:self refreshingAction:@selector(dropDownToRefresh)];
    self.backView.mj_header = refreshHeader;
    
//    初始化内容scrollview，用于横向滑动
    UIScrollView *content = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    content.contentInset = UIEdgeInsetsMake(194, 0, 0, 0);
    content.contentSize = CGSizeMake(LYScreenWidth * 2,0);
    content.backgroundColor = [UIColor whiteColor];
    content.showsHorizontalScrollIndicator = NO;
    content.bounces = NO;
    content.delegate = self;
    self.contentView = content;
    [self.backView addSubview:content];
    
    UILabel *notice = [[UILabel alloc] initWithFrame:CGRectMake(0, 144, LYScreenWidth, 20)];
    [content addSubview:notice];
    notice.textAlignment = NSTextAlignmentCenter;
    notice.textColor = UIColor(170, 170, 170);
    notice.font = [UIFont systemFontOfSize:16.0];
    notice.text = @"请登录以查看消息";
    
    UILabel *notice2 = [[UILabel alloc] initWithFrame:CGRectMake(LYScreenWidth, 144, LYScreenWidth, 20)];
    [content addSubview:notice2];
    notice2.textAlignment = NSTextAlignmentCenter;
    notice2.textColor = UIColor(170, 170, 170);
    notice2.font = [UIFont systemFontOfSize:16.0];
    notice2.text = @"请登录以查看消息";
    
    //    初始化头部导航栏
    HeaderView *header = [[HeaderView alloc] initWithTitle:@"消息" Button:NULL];
    [self.backView addSubview:header];
    self.headerView = header;
    
    //    初始化selectview
    LYSelectView *selectView = [[LYSelectView alloc] init];
    self.selectView = selectView;
    selectView.delegate = self;
    [self.backView addSubview:selectView];
    
}

#pragma mark - scrollView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    如果是底部scrollview，则作竖向滑动的效果处理
    if (scrollView == self.backView)
    {
        CGFloat Y = scrollView.contentOffset.y;
        NSLog(@"scroll %f",Y);
        if (Y < 0)
        {
            [self.headerView messageViewScrollBySmallY:Y - 130];
        }
        else
        {
            [self.headerView viewScrolledByY:Y - 130];
        }
        return;
    }
    if (scrollView == self.contentView)
    {
        NSLog(@"scroll %f",scrollView.contentOffset.x);
    }
}
//停止拖拽时的代理
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
//    如果是内容页的横向滑动
    if (scrollView == self.contentView)
    {
        NSLog(@"slowing?? %@",decelerate ? @"YES" : @"NO");
        CGFloat scrollX = scrollView.contentOffset.x;
//        如果带有惯性（快速滑动），则内容页必然进行对应的移动
        if (decelerate)
        {
            if (self.selectedTag == 0 && scrollView.contentOffset.x > 0)
            {
                self.selectedTag = 1;
            }
            else if (self.selectedTag == 1 && scrollView.contentOffset.x < LYScreenWidth)
            {
                self.selectedTag = 0;
            }
        }
//        如果无惯性（慢速拖拽），此时需要满足拖动的范围才会进行移动
        else
        {
            if (self.selectedTag == 0 && scrollX >= 0.5 * LYScreenWidth)
            {
                self.selectedTag = 1;
            }
            else if (self.selectedTag == 1 && scrollX <= 0.5 * LYScreenWidth){
                self.selectedTag = 0;
            }
        }
        [self contentViewScrollAnimation];
    }
}

//内容页进行移动的封装
- (void)contentViewScrollAnimation
{
    //根据此时选中的按钮计算出contentView的偏移量
    CGFloat offsetX = self.selectedTag * LYScreenWidth;
    CGPoint scrPoint = self.contentView.contentOffset;
    scrPoint.x = offsetX;
    //默认滚动速度有点慢 加速了下
    [UIView animateWithDuration:0.3 animations:^{
        [self.contentView setContentOffset:scrPoint];
    }];
//    通知选择器，进行小横条的移动
    [self.selectView selectBtnChangedTo:self.selectedTag];
}

#pragma mark - selectView delegate
//选择器按钮事件的代理
- (void)ButtonClickedWithTag:(NSInteger)tag
{
    self.selectedTag = tag;
    [self contentViewScrollAnimation];
}

#pragma mark - private methods
//下拉刷新
- (void)dropDownToRefresh
{
    [self.backView.mj_header endRefreshing];
}
//上拉加载
- (void)pullToAdd
{
    [self.backView.mj_footer endRefreshing];
}

@end
