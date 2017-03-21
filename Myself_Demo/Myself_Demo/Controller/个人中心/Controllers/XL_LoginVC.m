//
//  XL_LoginVC.m
//  Myself_Demo
//
//  Created by 商帮 on 21/4/15.
//  Copyright (c) 2015年 北京蓝海互联有限公司. All rights reserved.
//

#import "XL_LoginVC.h"
#import "XL_ShareHandle.h"


@interface XL_LoginVC ()<UITableViewDataSource, UITableViewDelegate>
{
    IBOutlet UITableView *_loginTableView;
    NSArray *_loginDataArr;
}
@end

@implementation XL_LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _loginDataArr = @[@"山顶巨人", @"敌法师", @"白牛", @"恶魔巫师", @"半人马酋长", @"潮汐猎人", @"巨牙海民", @"哈斯卡", @"奈文摩尔", @"地精伐木机"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - datasource -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _loginDataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"loginCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (nil == cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    cell.textLabel.text = _loginDataArr[indexPath.row];
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
    if (self.returnBlock) {
        self.returnBlock(_loginDataArr[indexPath.row]);
    }
    [XL_ShareHandle shareHandle].isLogin = YES;
    [self.navigationController popViewControllerAnimated:YES];
    
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
