//
//  XL_RootVC.m
//  Myself_Demo
//
//  Created by 商帮 on 16/4/15.
//  Copyright (c) 2015年 北京蓝海互联有限公司. All rights reserved.
//

#import "XL_RootVC.h"

#import "XL_FirstVC.h"
#import "XL_ScanPicVC.h"
#import "XL_ListVC.h"
#import "XL_SelectCellVC.h"
#import "XL_ShopCartVC.h"
#import "XL_CenterVC.h"
#import "XL_BannerVC.h"
#import "XL_SheetVC.h"
#import "XL_WaterFall.h"
#import "XL_LocalNotificationVC.h"

#import "XL_MoreVC.h"

@interface XL_RootVC ()<UITableViewDataSource, UITableViewDelegate>
{
    IBOutlet UITableView *_myTableView;
    NSArray *_dataArr;
}
@end

@implementation XL_RootVC

// 覆盖tablview 多余的线
- (void)coverLinesWithTableview:(UITableView *)tableview
{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor whiteColor];
    tableview.tableFooterView = view;
}
- (void)initWithXL
{
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
    self.title = @"我的demo";
    _dataArr = @[@"传值", @"查看图片", @"双重回收", @"选中Cell", @"购物车", @"个人中心", @"轮播图", @"类alertSheet", @"瀑布流", @"本地通知", @"更多"];
    [self coverLinesWithTableview:_myTableView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initWithXL];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - datasource -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"rootCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (nil == cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.textLabel.text = _dataArr[indexPath.row];
    return cell;
}
#pragma mark - delegate -
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UIViewController *vc;
    switch (indexPath.row) {
        case 0:
        {
            vc = [[XL_FirstVC alloc] init];
        }
            break;
        case 1:
        {
            XL_ScanPicVC *scanPicVC = [[XL_ScanPicVC alloc] init];
            [self.navigationController pushViewController:scanPicVC animated:YES];
        }
            break;
        case 2:
        {
            vc = [[XL_ListVC alloc] init];
        }
            break;
        case 3:
        {
            vc = [[XL_SelectCellVC alloc] init];
        }
            break;
        case 4:
        {
            vc = [[XL_ShopCartVC alloc] init];
        }
            break;
        case 5:
        {
            vc = [[XL_CenterVC alloc] init];
        }
            break;
        case 6:
        {
            vc = [[XL_BannerVC alloc] init];
        }
            break;
        case 7:
        {
            vc = [[XL_SheetVC alloc] init];
        }
            break;
        case 8:
        {
            vc = [[XL_WaterFall alloc] init];
        }
            break;
        case 9:
        {
            vc = [[XL_LocalNotificationVC alloc] initWithNibName:@"XL_LocalNotificationVC" bundle:nil];
        }
            break;
        default:
        {
            vc = [[XL_MoreVC alloc] initWithNibName:@"XL_MoreVC" bundle:nil];
        }
            break;
    }
    [self.navigationController pushViewController:vc animated:YES];
    return;
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
