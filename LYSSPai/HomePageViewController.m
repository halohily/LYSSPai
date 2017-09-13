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
#import "ClassedViewController.h"
#import "NewsReadModel.h"
#import "NewsReadController.h"
#import "MJRefreshHeader+AddIndicator.h"
#import "LYLoadingView.h"

#import "SFSafariViewController+TabbarSetting.h"

@interface HomePageViewController ()
<UIScrollViewDelegate,
HeaderViewDelegate,
UITableViewDelegate,
UITableViewDataSource,
TBActionSheetDelegate,
NewsCellDelegate,
AdsCellDelegate,
PaidNewsCellDelegate,
SFSafariViewControllerDelegate>
//顶部导航栏
@property (nonatomic, strong) HeaderView *headerView;
//页面内容table
@property (nonatomic, strong) UITableView *newsTableView;
//页面容器scrollview
@property (nonatomic, strong) UIScrollView *backgroundScrollView;
//新闻数据
@property (nonatomic, strong) NSMutableArray *newsData;
//广告数据
@property (nonatomic, strong) NSMutableArray *adsData;
//付费内容数据
@property (nonatomic, strong) NSMutableArray *paidNewsData;
//时间列表控件
@property (nonatomic, strong) TBActionSheet *actionSheet;

@end

@implementation HomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
    [self setupData];
    // Do any additional setup after loading the view.
}

- (void)setupData
{
//    为模拟网络获取数据时的延迟，这里手动设置延迟0.8s，否则loadingview一闪而过
    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8/*延迟执行时间*/ * NSEC_PER_SEC));
    dispatch_after(delayTime, dispatch_get_main_queue(), ^{
        NSData *JSONDataNews = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"newsData" ofType:@"json"]];
        
        NSDictionary *newsDataDic = [NSJSONSerialization JSONObjectWithData:JSONDataNews options:NSJSONReadingAllowFragments error:nil];
        
        NSMutableArray *newsArray = [newsDataDic objectForKey:@"data"];
        for (NSDictionary *dict in newsArray) {
            NewsModel *newsModel = [NewsModel NewsModelWithDic:dict];
            [self.newsData addObject:newsModel];
        }
        
        NSData *JSONDataAds = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"adsData" ofType:@"json"]];
        
        NSDictionary *adsDataDic = [NSJSONSerialization JSONObjectWithData:JSONDataAds options:NSJSONReadingAllowFragments error:nil];
        NSMutableArray *adsArray = adsDataDic[@"data"];
        AdsModel *adsModel = [AdsModel AdsModelWithArr:adsArray];
        [self.adsData addObject:adsModel];
        
        NSData *JSONDataPaid = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"paidNewsData" ofType:@"json"]];
        
        NSDictionary *paidDataDic = [NSJSONSerialization JSONObjectWithData:JSONDataPaid options:NSJSONReadingAllowFragments error:nil];
        NSMutableArray *paidNewsArray = paidDataDic[@"data"];
        PaidNewsModel *paidModel = [PaidNewsModel PaidNewsModelWithArr:paidNewsArray];
        [self.paidNewsData addObject:paidModel];
        [self.newsTableView reloadData];
//        隐藏loadingview
        [LYLoadingView hideLoadingViewFromView:self.view];
    });
}
- (void)setupView
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //    初始化loadingview
    CGRect loadingViewFrame = CGRectMake(0, 130, LYScreenWidth, LYScreenHeight - 130);
    [LYLoadingView showLoadingViewToView:self.view WithFrame:loadingViewFrame];
    
//    初始化背景scrollview
    UIScrollView *backScrollView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.view insertSubview:backScrollView atIndex:0];
    self.backgroundScrollView = backScrollView;
    
//    初始化首页内容tableview
    UITableView *news = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    news.delegate = self;
    news.dataSource = self;
    news.backgroundColor = [UIColor whiteColor];
    news.contentInset = UIEdgeInsetsMake(130, 0, 0, 0);
    [self.backgroundScrollView addSubview:news];
    news.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.newsTableView = news;
    
//    初始化下拉刷新header
    MJRefreshHeader *refreshHeader = [MJRefreshHeader indicatorHeaderWithRefreshingTarget:self refreshingAction:@selector(dropDownToRefresh)];
    self.backgroundScrollView.mj_header = refreshHeader;
    
//    初始化头部导航栏
    HeaderView *header = [[HeaderView alloc] initWithTitle:@"首页" Button:@"catalog_22x21_"];
    header.delegate = self;
    self.headerView = header;
    [self.backgroundScrollView addSubview:header];

}

- (NSMutableArray *)newsData
{
    if(_newsData == nil)
    {
        _newsData = [[NSMutableArray alloc] init];
    }
    return _newsData;
}

- (NSMutableArray *)adsData
{
    if (_adsData == nil)
    {
        _adsData = [[NSMutableArray alloc] init];
    }
    return _adsData;
}

- (NSMutableArray *)paidNewsData
{
    if (_paidNewsData == nil)
    {
        _paidNewsData = [[NSMutableArray alloc] init];
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

#pragma mark - private methods
//下拉刷新
- (void)dropDownToRefresh
{
    NSMutableArray *nowNews = self.newsData;
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
    [self.backgroundScrollView.mj_header endRefreshing];
}
//上拉加载
- (void)pullToAdd
{
    NSData *JSONData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"refresh" ofType:@"json"]];
    NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingAllowFragments error:nil];
    NSMutableArray *newsArray = [dataDic objectForKey:@"data"];
    for (NSDictionary *dict in newsArray) {
        NewsModel *model = [NewsModel NewsModelWithDic:dict];
        [self.newsData addObject:model];
    }
    [self.newsTableView reloadData];
    [self.newsTableView.mj_footer endRefreshing];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - scrollView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    输出scrollview的content offset Y值，调试时取消注释
    NSLog(@"scroll::%f",scrollView.contentOffset.y);
    [self.headerView viewScrolledByY:scrollView.contentOffset.y];
}

#pragma mark - tableview delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        AdsModel *model = self.adsData[0];
        return model.cellHeight;
    }
    if (indexPath.row == 2)
    {
        PaidNewsModel *model = self.paidNewsData[0];
        return model.cellHeight;
    }
    NewsModel *model = self.newsData[0];
    return model.cellHeight;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.newsData.count + self.adsData.count + self.paidNewsData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        AdsModel *model = [self.adsData objectAtIndex:0];
        AdsCell *cell = [AdsCell cellWithTableview:tableView AdsModel:model];
        cell.delegate = self;
        return cell;
    }
    if (indexPath.row == 2)
    {
        PaidNewsModel *model = [self.paidNewsData objectAtIndex:0];
        PaidNewsCell *cell = [PaidNewsCell cellWithTableView:tableView PaidNewsModel:model];
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"第%ld个cell被点击",(long)indexPath.row);
    NewsModel *newsModel = [[NewsModel alloc] init];
    if (indexPath.row == 1)
    {
        newsModel = self.newsData[0];
    }
    else
    {
        newsModel = self.newsData[indexPath.row - 2];
    }
    NSDictionary *dic = @{@"like_total":newsModel.like_total, @"comment_total": newsModel.comment_total, @"newsURL": @"https://sspai.com/post/40263", @"newsID": newsModel.articleID};
    NewsReadModel *model = [NewsReadModel NewsReadModelWithDic:dic];
    NewsReadController *readVC = [[NewsReadController alloc] initWithModel:model];
    [self.navigationController pushViewController:readVC animated:YES];
}

#pragma mark - NewsCell delegate
- (void)menuButtonClickedWithID:(NSString *)articleID
{
    NSLog(@"文章cell中的菜单按钮被点击，文章id为：%@", articleID);
    
    [self.actionSheet show];
}

//cell的左划手势方法：进入分类专题页面
- (void)swipeLeft
{
    ClassedViewController *classVC = [[ClassedViewController alloc] init];
    [self.navigationController pushViewController:classVC animated:YES];
}
#pragma mark - AdsCell delegate
- (void)adsCellTappedByTag:(NSInteger)tag
{
//    第一个和第二个模仿safariVC
    if (tag == 0 || tag == 1)
    {
        SFSafariViewController *safari = [[SFSafariViewController alloc] initSFWithURL:[NSURL URLWithString:@"https://www.apple.com/cn/"]];
        safari.delegate = self;
        [self.navigationController pushViewController:safari animated:YES];
    }
//    其余为普通文章页面
    else
    {
        NewsModel *newsModel = self.newsData[0];
        NSDictionary *dic = @{@"like_total":newsModel.like_total, @"comment_total": newsModel.comment_total, @"newsURL": @"https://sspai.com/post/40263", @"newsID": newsModel.articleID};
        NewsReadModel *model = [NewsReadModel NewsReadModelWithDic:dic];
        NewsReadController *readVC = [[NewsReadController alloc] initWithModel:model];
        [self.navigationController pushViewController:readVC animated:YES];
    }
}

#pragma mark - PaidCell delegate
- (void)paidNewsTappedByTag:(NSInteger)tag
{
    
}

- (void)moreClicked
{
    
}

#pragma mark - headview delgegate
- (void)BtnClicked
{
//    进入分类专题页面
    ClassedViewController *classVC = [[ClassedViewController alloc] init];
    [self.navigationController pushViewController:classVC animated:YES];
}

- (void)safariViewControllerDidFinish:(SFSafariViewController *)controller
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
