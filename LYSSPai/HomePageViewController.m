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
#import "TBActionSheet.h"
#import "MJRefresh.h"
#import "MBProgressHUD.h"
#import "ClassedController.h"

@interface HomePageViewController ()
<UIScrollViewDelegate,
HeaderViewDelegate,
UITableViewDelegate,
UITableViewDataSource,
TBActionSheetDelegate,
NewsCellDelegate,
AdsCellDelegate,
PaidNewsCellDelegate>

@property (nonatomic, strong) HeaderView *headerView;
@property (nonatomic, strong) UITableView *newsTableView;
@property (nonatomic, strong) NSMutableArray *newsData;
@property (nonatomic, strong) NSMutableArray *adsData;
@property (nonatomic, strong) NSMutableArray *paidNewsData;
@property (nonatomic, strong) TBActionSheet *actionSheet;

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

- (NSMutableArray *)newsData
{
    if(_newsData == nil)
    {
        NSData *JSONData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"newsData" ofType:@"json"]];
        
        NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingAllowFragments error:nil];
        
        NSMutableArray *newsArray = [dataDic objectForKey:@"data"];
        NSMutableArray *newsdata = [[NSMutableArray alloc] init];
        for (NSDictionary *dict in newsArray) {
            NewsModel *model = [NewsModel NewsModelWithDic:dict];
            [newsdata addObject:model];
        }
        _newsData = newsdata;
    }
    return _newsData;
}

- (NSMutableArray *)adsData
{
    if (_adsData == nil)
    {
        NSData *JSONData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"adsData" ofType:@"json"]];
        
        NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingAllowFragments error:nil];
        NSMutableArray *adsArray = dataDic[@"data"];
        AdsModel *model = [AdsModel AdsModelWithArr:adsArray];
        NSMutableArray *adsdata = [NSMutableArray arrayWithObjects:model, nil];
        _adsData = adsdata;
    }
    return _adsData;
}

- (NSMutableArray *)paidNewsData
{
    if (_paidNewsData == nil)
    {
        NSData *JSONData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"paidNewsData" ofType:@"json"]];
        
        NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingAllowFragments error:nil];
        NSMutableArray *paidNewsArray = dataDic[@"data"];
        PaidNewsModel *model = [PaidNewsModel PaidNewsModelWithArr:paidNewsArray];
        NSMutableArray *paidnews = [NSMutableArray arrayWithObjects:model, nil];
        _paidNewsData = paidnews;
    }
    return _paidNewsData;
}

- (TBActionSheet *)actionSheet
{
    if (_actionSheet == nil)
    {
        TBActionSheet *actionSheet = [[TBActionSheet alloc] initWithTitle:NULL message:NULL delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:NULL otherButtonTitles:@"分享", @"收藏", @"举报", nil];
        _actionSheet = actionSheet;
    }
    return _actionSheet;
}

#pragma mark private methods
//下拉刷新
- (void)dropDownToRefresh
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.label.text = @"请稍候";
    [hud hideAnimated:YES afterDelay:0.6];
    
    NSMutableArray *nowNews = _newsData;
//    下拉刷新时，将refresh文件里的数据添加到目前数据的前面
    NSData *JSONData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"refresh" ofType:@"json"]];
    NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingAllowFragments error:nil];
    NSMutableArray *newsdata= [[NSMutableArray alloc] init];
    NSMutableArray *newsArray = [dataDic objectForKey:@"data"];
    for (NSDictionary *dict in newsArray) {
        NewsModel *model = [NewsModel NewsModelWithDic:dict];
        [newsdata addObject:model];
    }
    self.newsData = newsdata;
    for (NewsModel *model in nowNews)
    {
        [self.newsData addObject:model];
    }
    [self.newsTableView reloadData];
    
}
//上拉加载
- (void)pullToAdd
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.label.text = @"请稍候";
    [hud hideAnimated:YES afterDelay:0.6];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSData *JSONData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"refresh" ofType:@"json"]];
    NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingAllowFragments error:nil];
    NSMutableArray *newsArray = [dataDic objectForKey:@"data"];
    for (NSDictionary *dict in newsArray) {
        NewsModel *model = [NewsModel NewsModelWithDic:dict];
        [self.newsData addObject:model];
    }
    [self.newsTableView reloadData];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark scrollView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    输出scrollview的content offset Y值，调试时取消注释
//    NSLog(@"scroll::%f",scrollView.contentOffset.y);
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
    return 210 + LYScreenWidth * 0.3331;
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
        cell.delegate = self;
        return cell;
    }
    if (indexPath.row == 2)
    {
        PaidNewsModel *model = [self.paidNewsData objectAtIndex:0];
        PaidNewsCell *cell = [PaidNewsCell cellWithPaidNewsModel:model];
        cell.delegate = self;
        return cell;
    }
    if (indexPath.row == 1)
    {
        NewsModel *model = [self.newsData objectAtIndex:indexPath.row - 1];
        NewsCell *cell = [NewsCell cellWithTableView:tableView NewsModel:model];
        cell.delegate = self;
        return cell;
    }
    NewsModel *model = [self.newsData objectAtIndex:indexPath.row - 2];
    NewsCell *cell = [NewsCell cellWithTableView:tableView NewsModel:model];
    cell.delegate = self;
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    MJRefreshAutoFooter *refreshFooter = [MJRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(pullToAdd)];
//    refreshFooter.refreshingTitleHidden = YES;
    
    return refreshFooter;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 50;
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    MJRefreshHeader *refreshHeader = [MJRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(dropDownToRefresh)];
//    return refreshHeader;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 30;
//}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"第%ld个cell被点击",(long)indexPath.row);
}

#pragma mark NewsCell delegate
- (void)menuButtonClickedWithID:(NSString *)articleID
{
    NSLog(@"文章cell中的菜单按钮被点击，文章id为：%@", articleID);
    
    [self.actionSheet show];
}

- (void)swipeLeft
{
    ClassedController *classVC = [[ClassedController alloc] init];
    [self.navigationController pushViewController:classVC animated:YES];
}
#pragma mark AdsCell delegate
- (void)adsCellTappedByTag:(NSInteger)tag
{
    
}

#pragma mark PaidCell delegate
- (void)paidNewsTappedByTag:(NSInteger)tag
{
    
}

- (void)moreClicked
{
    
}

#pragma mark headview delgegate
- (void)BtnClicked
{
    ClassedController *classVC = [[ClassedController alloc] init];
    [self.navigationController pushViewController:classVC animated:YES];
}
@end
