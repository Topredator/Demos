//
//  XL_MoreVC.m
//  Myself_Demo
//
//  Created by 商帮 on 22/5/15.
//  Copyright (c) 2015年 北京蓝海互联有限公司. All rights reserved.
//

#import "XL_MoreVC.h"

#import "XL_CoreImageVC.h"
#import "XL_ImageEffectVC.h"
#import "XL_DataVC.h"
#import "XL_TimeoutIntervalVC.h"


@interface XL_MoreVC ()<UITableViewDataSource, UITableViewDelegate>
{
    IBOutlet UITableView *_moreTableview;
    NSArray *_moreArr;
}
@end

@implementation XL_MoreVC

- (void)loadInitMore{
    self.title = @"更多功能";
    _moreArr = @[@"CoreImage", @"ImageEffects", @"数据读取", @"网络连接超时"];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self loadInitMore];
}


#pragma mark - datasource -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _moreArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"moreCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (nil == cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.textLabel.text = _moreArr[indexPath.row];
    return cell;
}
#pragma mark - delegate -
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIViewController *vc;
    switch (indexPath.row) {
        case 0:
        {
            vc = [[XL_CoreImageVC alloc] init];
        }
            break;
        case 1:
        {
            vc = [[XL_ImageEffectVC alloc] init];
        }
            break;
        case 2:
        {
            vc = [[XL_DataVC alloc] init];
        }
            break;
        case 3:
        {
            vc = [[XL_TimeoutIntervalVC alloc] init];
        }
            break;
        default:
            break;
    }
    [self.navigationController pushViewController:vc animated:YES];
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
