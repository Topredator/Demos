//
//  XL_DataVC.m
//  Myself_Demo
//
//  Created by 商帮 on 1/6/15.
//  Copyright (c) 2015年 北京蓝海互联有限公司. All rights reserved.
//

#import "XL_DataVC.h"

#import "XL_WriteAndReadingData.h"
#import "XL_SQLiteVC.h"

@interface XL_DataVC ()<UITableViewDataSource, UITableViewDelegate>
{
    IBOutlet UITableView *_dataTableView;
    NSArray *_dataArr;
}
@end

@implementation XL_DataVC
- (void)loadInitDataVC{
    self.title = @"数据读写";
    _dataArr = @[@"文件读取", @"数据库读取"];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self loadInitDataVC];
}


#pragma mark - datasource -
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"dataCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (nil == cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = _dataArr[indexPath.row];
    return cell;
}
#pragma mark - delegate -
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIViewController *vc;
    switch (indexPath.row) {
        case 0:
        {
            vc = [[XL_WriteAndReadingData alloc] init];
        }
            break;
        case 1:
        {
            vc = [[XL_SQLiteVC alloc] init];
        }
            break;
        default:
            break;
    }
    [self.navigationController pushViewController:vc animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return section ? 10 : 1;
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
