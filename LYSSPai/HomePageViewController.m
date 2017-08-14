//
//  HomePageViewController.m
//  LYSSPai
//
//  Created by 刘毅 on 2017/8/12.
//  Copyright © 2017年 halohily.com. All rights reserved.
//

#import "HomePageViewController.h"
#import "HeaderView.h"
#import "NewsCell.h"
#import "NewsModel.h"
#import "AdsCell.h"
#import "AdsModel.h"
#import "PaidNewsCell.h"
#import "PaidNewsModel.h"

@interface HomePageViewController ()<UIScrollViewDelegate, HeaderViewDelegate, UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) HeaderView *headerView;
@property (nonatomic, strong) UITableView *newsTableView;
@property (nonatomic, strong) NSArray *newsData;
@property (nonatomic, strong) NSArray *adsData;
@property (nonatomic, strong) NSArray *paidNewsData;
@end

@implementation HomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
    
    // Do any additional setup after loading the view.
}

- (void)setupView
{
    self.automaticallyAdjustsScrollViewInsets = NO;
//    初始化首页内容tableview
    UITableView *news = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    news.delegate = self;
    news.dataSource = self;
    news.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:news];
//    为头部导航栏留出位置
    news.contentInset = UIEdgeInsetsMake(130, 0, 0, 0);
    news.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.newsTableView = news;
    
    //    初始化头部导航栏
    HeaderView *header = [[HeaderView alloc] initWithTitle:@"首页" Button:@"catalog_22x21_"];
    [self.view addSubview:header];
    header.delegate = self;
    self.headerView = header;
}

- (NSArray *)newsData
{
    if(_newsData == nil)
    {
        NSData *JSONData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"newsData" ofType:@"json"]];
        
        NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingAllowFragments error:nil];
        
        NSMutableArray *newsArray = [dataDic objectForKey:@"data"];
        NSMutableArray *newsdata = [NSMutableArray array];
        for (NSDictionary *dict in newsArray) {
            NewsModel *model = [NewsModel NewsModelWithDic:dict];
            [newsdata addObject:model];
        }
        _newsData = newsdata;
    }
    return _newsData;
}

- (NSArray *)adsData
{
    if (_adsData == nil)
    {
        NSData *JSONData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"adsData" ofType:@"json"]];
        
        NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingAllowFragments error:nil];
        NSMutableArray *adsArray = dataDic[@"data"];
        AdsModel *model = [AdsModel AdsModelWithArr:adsArray];
        NSMutableArray *adsdata = [NSMutableArray arrayWithObject:model];
        _adsData = adsdata;
    }
    return _adsData;
}

- (NSArray *)paidNewsData
{
    if (_paidNewsData == nil)
    {
        NSData *JSONData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"paidNewsData" ofType:@"json"]];
        
        NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingAllowFragments error:nil];
        NSMutableArray *paidNewsArray = dataDic[@"data"];
        PaidNewsModel *model = [PaidNewsModel PaidNewsModelWithArr:paidNewsArray];
        NSMutableArray *paidnews = [NSMutableArray arrayWithObject:model];
        _paidNewsData = paidnews;
    }
    return _paidNewsData;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark scrollView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"scroll::%f",scrollView.contentOffset.y);
    [self.headerView viewScrolledByY:scrollView.contentOffset.y];
}

#pragma mark tableview delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        return (LYScreenWidth - 50) * 0.53125 + 40;
    }
    if (indexPath.row == 2)
    {
        return LYScreenWidth * 0.8 + 60;
    }
    return 400;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.newsData.count + 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        AdsModel *model = [self.adsData objectAtIndex:0];
        AdsCell *cell = [AdsCell cellWithAdsModel:model];
        return cell;
    }
    if (indexPath.row == 2)
    {
        PaidNewsModel *model = [self.paidNewsData objectAtIndex:0];
        PaidNewsCell *cell = [PaidNewsCell cellWithPaidNewsModel:model];
        return cell;
    }
    if (indexPath.row == 1)
    {
        NewsModel *model = [self.newsData objectAtIndex:indexPath.row - 1];
        NewsCell *cell = [NewsCell cellWithTableView:tableView NewsModel:model];
        return cell;
    }
    NewsModel *model = [self.newsData objectAtIndex:indexPath.row - 2];
    NewsCell *cell = [NewsCell cellWithTableView:tableView NewsModel:model];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
@end
