//
//  FoundViewController.m
//  LYSSPai
//
//  Created by 刘毅 on 2017/8/12.
//  Copyright © 2017年 halohily.com. All rights reserved.
//

#import "FoundViewController.h"
#import "HeaderView.h"
#import "FindCell.h"
#import "FindModel.h"
#import "MJRefreshHeader+AddIndicator.h"

@interface FoundViewController ()<UITableViewDelegate, UITableViewDataSource, HeaderViewDelegate>

@property (nonatomic, strong) HeaderView *headerView;
//页面容器scrollview
@property (nonatomic, strong) UIScrollView *backgroundScrollView;
@property (nonatomic, strong) UITableView *subjectsTableView;
@property (nonatomic, strong) NSArray *findData;
@end

@implementation FoundViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSArray *)findData
{
    if (_findData == nil)
    {
        NSData *JSONData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"find" ofType:@"json"]];
        
        NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingAllowFragments error:nil];
        NSMutableArray *findArr = dataDic[@"data"];
        NSMutableArray *findData = [NSMutableArray array];
        for (NSMutableDictionary *dic in findArr)
        {
            FindModel *model = [FindModel FindModelWithDic:dic];
            [findData addObject:model];
        }
        _findData = findData;
    }
    return _findData;
}
- (void)setupView
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //    初始化背景scrollview
    UIScrollView *backScrollView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.view addSubview:backScrollView];
    self.backgroundScrollView = backScrollView;
    
    //    初始化首页内容tableview
    UITableView *subjects = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    subjects.delegate = self;
    subjects.dataSource = self;
    subjects.backgroundColor = [UIColor whiteColor];
    [self.backgroundScrollView addSubview:subjects];
    //    为头部导航栏留出位置
    subjects.contentInset = UIEdgeInsetsMake(130, 0, 0, 0);
    subjects.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.subjectsTableView = subjects;
    
    //    初始化头部导航栏
    HeaderView *header = [[HeaderView alloc] initWithTitle:@"发现" Button:@"nav_but_search_20x20_"];
    [self.backgroundScrollView addSubview:header];
    header.delegate = self;
    self.headerView = header;

    MJRefreshHeader *refreshHeader = [MJRefreshHeader indicatorHeaderWithRefreshingTarget:self refreshingAction:@selector(dropDownToRefresh)];
    self.backgroundScrollView.mj_header = refreshHeader;
}

#pragma mark scrollView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    NSLog(@"scroll::%f",scrollView.contentOffset.y);
    [self.headerView viewScrolledByY:scrollView.contentOffset.y];
}

#pragma mark tableview delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.findData.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return LYScreenWidth * 0.5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FindModel *model = self.findData[indexPath.row];
    FindCell *cell = [FindCell FindCellWithTableView:tableView FindModel:model];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    view.frame = CGRectMake(0, 0, LYScreenWidth, 100);
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 100.0;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - private methods
//下拉刷新
- (void)dropDownToRefresh
{
    [self.subjectsTableView reloadData];
    [self.backgroundScrollView.mj_header endRefreshing];
}
//上拉加载
- (void)pullToAdd
{
    [self.backgroundScrollView.mj_footer endRefreshing];
}

@end
