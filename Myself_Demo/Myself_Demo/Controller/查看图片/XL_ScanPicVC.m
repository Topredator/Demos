//
//  XL_ScanPicVC.m
//  Myself_Demo
//
//  Created by 商帮 on 16/4/15.
//  Copyright (c) 2015年 北京蓝海互联有限公司. All rights reserved.
//

#import "XL_ScanPicVC.h"
#import "XL_ScanCell.h"

@interface XL_ScanPicVC ()<UITableViewDataSource, UITableViewDelegate>
{
    IBOutlet UITableView *_scanTableView;
    NSArray *_scanDataArr;
}
@end

@implementation XL_ScanPicVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"查看图片";
    _scanTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    NSString *content = @"姐姐十八九岁。由于奔跑和焦急，圆圆的脸上渗出了汗珠儿，仿佛一个沾着露水的熟透的苹果。她的两只眼睛像黑宝石一样，亮晶晶的，闪耀着聪敏、慧巧、活泼和刚毅的光芒；秀长的睫毛，好像清清的湖水旁边的密密的树林，给人一种深邃而又神秘的感觉。乌黑的长发，即柔软又纤细，随着河风在脑后飘拂着。";
    _scanDataArr = @[@{@"name":@"炼金术师", @"status":@"高兴", @"content":[content substringToIndex:arc4random() % content.length], @"images":@[], @"time":@"1小时前"},
                                @{@"name":@"敌法师", @"status":@"高兴", @"content":@"", @"images":@[@"", @"", @"", @"", @"", @"", @"", @"", @""], @"time":@"1小时前"},
                                @{@"name":@"山顶巨人", @"status":@"高兴", @"content":[content substringToIndex:arc4random() % content.length], @"images":@[@"", @"", @""], @"time":@"1小时前"},
                                @{@"name":@"恶魔巫师", @"status":@"高兴", @"content":[content substringToIndex:arc4random() % content.length], @"images":@[], @"time":@"1小时前"},
                                @{@"name":@"哈斯卡", @"status":@"高兴", @"content":[content substringToIndex:arc4random() % content.length], @"images":@[@"", @"", @""], @"time":@"1小时前"}, ];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - datasource -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _scanDataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"scanCell";
    XL_ScanCell *cell = (XL_ScanCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    if (nil == cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"XL_ScanCell" owner:self options:nil][0];
    }
    [cell customWithCell:_scanDataArr[indexPath.row] delegate:self];
    return cell;
}
#pragma mark - delegate -
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
