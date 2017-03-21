//
//  XL_TimeoutIntervalVC.m
//  Myself_Demo
//
//  Created by 商帮 on 27/5/15.
//  Copyright (c) 2015年 北京蓝海互联有限公司. All rights reserved.
//

#import "XL_TimeoutIntervalVC.h"

#import "Public_Class.h"
#import "NetWork.h"
#import "AFNetworking.h"
#import "MJRefresh.h"


@interface XL_TimeoutIntervalVC ()<UITableViewDataSource, UITableViewDelegate>
{
    IBOutlet UITableView *_timeTableView;
    NSMutableArray *_dataArr;
}
@end

@implementation XL_TimeoutIntervalVC

- (void)loadInitTimeout{
    self.title = @"网络连接超时";
    _dataArr = [NSMutableArray array];
    //  上拉加载
    __block UITableView *table = _timeTableView;
    __weak typeof(self) vc = self;
    [_timeTableView addLegendHeaderWithRefreshingBlock:^{
        [table.header beginRefreshing];
        [vc reloadDataWithTableview:table];
    }];
    [_timeTableView.header setTitle:@"下拉进入刷新" forState:MJRefreshHeaderStateIdle];
    [_timeTableView.header setTitle:@"松开马上刷新" forState:MJRefreshHeaderStatePulling];
    [_timeTableView.header setTitle:@"加载中..." forState:MJRefreshHeaderStateRefreshing];
}

//  刷新数据
- (void)reloadDataWithTableview:(UITableView *)tableview{
    NSDictionary *dict = @{@"act" : @"goods_class"};
    [NetWork getUrl:KUrl parameter:dict success:^(id responseObject) {
        [_dataArr removeAllObjects];
        NSArray *datas = [[responseObject valueForKey:@"datas"] valueForKey:@"class_list"];
        for (NSDictionary *dic in datas) {
            [_dataArr addObject:dic];
        }
        [tableview reloadData];
    } failed:^(NSError *error) {
        switch ([error code]) {
            case NSURLErrorTimedOut:
            {
                [self continueAfterTime:@"网络连接超时"];
            }
                break;
            case NSURLErrorNotConnectedToInternet:
            {
                [self continueAfterTime:@"请检查网络连接"];
            }
                break;
            default:
                break;
        }
        [tableview reloadData];
    }];
    
    [tableview.header endRefreshing];
}

- (void)continueAfterTime:(NSString *)str{
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 180, 30)];
    if (str) {
        titleLabel.text = str;
    }
    titleLabel.font = KFont(14);
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.backgroundColor = [UIColor blackColor];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.layer.cornerRadius = 5.f;
    titleLabel.layer.masksToBounds = YES;
    titleLabel.center = self.view.center;
    [self.view addSubview:titleLabel];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [titleLabel removeFromSuperview];
    });
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self loadInitTimeout];
}

#pragma mark - datasource -
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count ? _dataArr.count : 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"timeCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (nil == cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = _dataArr.count ? _dataArr[indexPath.row][@"gc_name"] : @"测试数据";
    cell.textLabel.font = KFont(15);
    return cell;
}
#pragma mark - delegate -
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 5;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
