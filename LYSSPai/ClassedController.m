//
//  ClassedController.m
//  LYSSPai
//
//  Created by 刘毅 on 2017/8/15.
//  Copyright © 2017年 halohily.com. All rights reserved.
//

#import "ClassedController.h"

@interface ClassedController ()
@property (nonatomic, strong) NSArray *datas;

@end

@implementation ClassedController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSArray *)datas
{
    if (_datas == nil)
    {
        NSArray *datas = @[@"效率工具", @"手机摄影", @"新玩意", @"生活方式", @"游戏", @"人物"];
        _datas = datas;
    }
    return _datas;
}

- (void)setupUI
{
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    self.view.backgroundColor = [UIColor whiteColor];
    [self setListBtnWithArr:self.datas];
    UIButton *back = [[UIButton alloc] init];
    [self.view addSubview:back];
    [back setImage:[UIImage imageNamed:@"back_dark_10x16_"] forState:UIControlStateNormal];
    [back mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).mas_offset(15);
        make.top.mas_equalTo(self.view.mas_top).mas_offset(30);
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(32);
    }];
    [back addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *matrix = [[UIButton alloc] initWithFrame:CGRectMake(LYScreenWidth/2 - 50, 480, 100, 30)];
    [self.view addSubview:matrix];
    [matrix setImage:[UIImage imageNamed:@"Matrix_icon_33x26_"] forState:UIControlStateNormal];
    [matrix setTitle:@"   Matrix" forState:UIControlStateNormal];
    [matrix setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    matrix.titleLabel.font = [UIFont systemFontOfSize:18.0];
    matrix.tag = 6;
    [matrix addTarget:self action:@selector(pushToClass:) forControlEvents:UIControlEventTouchUpInside];
    
}
- (void)setListBtnWithArr:(NSArray *)datas
{
    int i = 0;
    for(NSString *title in datas)
    {
        UIButton *button = [[UIButton alloc] init];
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.2] forState:UIControlStateSelected];
        button.titleLabel.font = [UIFont systemFontOfSize:18.0];
        button.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.view.mas_left).with.offset(130);
            make.right.mas_equalTo(self.view.mas_right).with.offset(-130);
            make.height.mas_equalTo(18.0);
            make.top.mas_equalTo(self.view.mas_top).with.offset(150 + i *50);
        }];
        button.tag = i;
        [button addTarget:self action:@selector(pushToClass:) forControlEvents:UIControlEventTouchUpInside];
        i++;
    }
}

- (void)goBack
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)pushToClass:(UIButton *)sender
{
    NSLog(@"tag::%ld",(long)sender.tag);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
