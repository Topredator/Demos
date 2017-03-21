//
//  XL_PassValueDetailVC.m
//  Myself_Demo
//
//  Created by 商帮 on 16/4/15.
//  Copyright (c) 2015年 北京蓝海互联有限公司. All rights reserved.
//

#import "XL_PassValueDetailVC.h"

#import "XL_ShareHandle.h"

@interface XL_PassValueDetailVC ()<UITableViewDataSource, UITableViewDelegate>
{
    IBOutlet UITableView *_passTableView;
    NSArray *_passDataArr;
}
@end

@implementation XL_PassValueDetailVC

- (void)loadInitXL
{
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
    self.title = @"what you  want";
    _passDataArr = @[@"你好吊啊", @"是你吗", @"大坏蛋", @"傻子才笨", @"逼我呢不是", @"擦，还没完了", @"你说的真好", @"妈呀，吓死我了", @"呵呵", @"。。。"];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self loadInitXL];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - datasource -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _passDataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"passCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (nil == cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = _passDataArr[indexPath.row];
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
    switch ([XL_ShareHandle shareHandle].passValue_style) {
        case PassValue_delegate:
        {
            NSString *str = _passDataArr[indexPath.row];
            //  代理传值
            if ([self.delegate respondsToSelector:@selector(passValueWithString:)]) {
                [self.delegate passValueWithString:str];
            }
        }
            break;
        case PassValue_block:
        {
            //  block 传值
            _blockReturn(_passDataArr[indexPath.row]);
        }
            break;
        default:
        {
            //  post通知
            [[NSNotificationCenter defaultCenter] postNotificationName:@"notificaton" object:_passDataArr[indexPath.row]];
        }
            break;
    }
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
