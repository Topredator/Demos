//
//  XL_ListVC.m
//  Myself_Demo
//
//  Created by 商帮 on 18/4/15.
//  Copyright (c) 2015年 北京蓝海互联有限公司. All rights reserved.
//

#import "XL_ListVC.h"

#import "XL_Friend.h"
#import "XL_GroupFriend.h"
#import "XL_HeaderView.h"


@interface XL_ListVC ()<UITableViewDataSource, UITableViewDelegate, HeaderViewDelegate>
{
    IBOutlet UITableView *_listTableView;
}
@property (nonatomic, strong) NSMutableArray *listDataArr;
@end

@implementation XL_ListVC
//  懒加载
- (NSMutableArray *)listDataArr
{
    if (!_listDataArr) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"friends.plist" ofType:nil];
        NSArray *arr = [NSArray arrayWithContentsOfFile:path];
        NSMutableArray *tempArr = [NSMutableArray arrayWithCapacity:arr.count];
        for (NSDictionary *dict in arr) {
            XL_GroupFriend *groupModel = [XL_GroupFriend groupWithDict:dict];
            [tempArr addObject:groupModel];
        }
        _listDataArr = [tempArr copy];
    }
    return _listDataArr;
}

// 去掉多余的线
- (void)removeLines:(UITableView *)tableView
{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor whiteColor];
    tableView.tableFooterView = view;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"二级列表";
    _listTableView.sectionHeaderHeight = 40;
    [self removeLines:_listTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - datasource -
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.listDataArr.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    XL_GroupFriend *groupModel = self.listDataArr[section];
    NSInteger count = groupModel.isOpen ? groupModel.friends.count : 0;
    return count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"friendCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (nil == cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    XL_GroupFriend *groupModel = self.listDataArr[indexPath.section];
    XL_Friend *friendModel = groupModel.friends[indexPath.row];
    cell.imageView.image = [UIImage imageNamed:friendModel.icon];
    cell.textLabel.text = friendModel.name;
    cell.detailTextLabel.text = friendModel.intro;
    return cell;
}
#pragma mark - delegate -
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    XL_HeaderView *headerView = [XL_HeaderView headerView:tableView];
    headerView.delegate = self;
    headerView.groupModel = self.listDataArr[section];
    return headerView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    return;
}

#pragma mark - HeaderViewDelegate -
- (void)clickHeaderView
{
    [_listTableView reloadData];
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
