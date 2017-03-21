//
//  XL_SelectCellVC.m
//  Myself_Demo
//
//  Created by 商帮 on 20/4/15.
//  Copyright (c) 2015年 北京蓝海互联有限公司. All rights reserved.
//

#import "XL_SelectCellVC.h"
#import "Public_Class.h"


@interface XL_SelectCellVC ()<UITableViewDataSource, UITableViewDelegate>
{
    IBOutlet UITableView *_selectTableView;
    NSMutableArray *_selectDataArr;
    NSMutableArray *_checkArr;
}
@end

@implementation XL_SelectCellVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"选中Cell";
    
    NSArray *arr = @[@"山顶巨人", @"敌法师", @"白牛", @"恶魔巫师", @"半人马酋长", @"潮汐猎人", @"巨牙海民", @"哈斯卡", @"奈文摩尔", @"地精伐木机"];
    
    _selectDataArr = [NSMutableArray array];
    
    for (int i = 0; i < arr.count; i++) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setValue:@"N" forKey:@"isCheck"];
        [dic setValue:arr[i] forKey:@"name"];
        if (i == 0) {
            [dic setValue:@"Y" forKey:@"isCheck"];
        }
        [_selectDataArr addObject:dic];
    }
    
    _selectTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - datasource -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _selectDataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"selectCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (nil == cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.backgroundColor = RGB(235, 235, 235, 1);
    }
    NSMutableDictionary *dic = _selectDataArr[indexPath.row];
    cell.textLabel.text = dic[@"name"];
    if ([dic[@"isCheck"] isEqualToString:@"Y"]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}
#pragma mark - delegate -
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    for (NSMutableDictionary *dic in _selectDataArr) {
        [dic setValue:@"N" forKey:@"isCheck"];
    }
    NSMutableDictionary *dict = _selectDataArr[indexPath.row];
    [dict setValue:@"Y" forKey:@"isCheck"];
    [tableView reloadData];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
