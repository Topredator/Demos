//
//  XL_WriteAndReadingData.m
//  Myself_Demo
//
//  Created by 商帮 on 26/5/15.
//  Copyright (c) 2015年 北京蓝海互联有限公司. All rights reserved.
//

#import "XL_WriteAndReadingData.h"

@interface XL_WriteAndReadingData ()<UITableViewDataSource, UITableViewDelegate>
{
    IBOutlet UILabel *_contentLabel;
    
    IBOutlet UITableView *_dataTableView;
    NSMutableArray *_dataArr;
}
@end

@implementation XL_WriteAndReadingData

#pragma mark - 文件路径 -
- (NSString *)getFiledPath:(NSString *)fileName{
    NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *str = [filePath stringByAppendingPathComponent:fileName];
    return str;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _dataArr = [NSMutableArray array];
    self.title = @"本地储存";
}

- (IBAction)writeDataAction:(id)sender {
    NSDictionary *dataDic = @{@"data" : @[@"唐家三少", @"天蚕土豆", @"我吃西红柿", @"辰东", @"烽火戏诸侯", @"逆苍天", @"耳根", @"骷髅精灵", @"猫腻", @"忘语"]};
    NSString *plistPath = [self getFiledPath:@"xl.plist"];
    [dataDic writeToFile:plistPath atomically:YES];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL result = [fileManager fileExistsAtPath:plistPath];
    if (result) {
        _contentLabel.text = @"数据写入成功！！！";
        _contentLabel.textColor = [UIColor blueColor];
    } else {
        _contentLabel.text = @"数据写入失败！！！";
        _contentLabel.textColor = [UIColor redColor];
    }
}
- (IBAction)readDataAction:(id)sender {
    NSString *plistPaht = [self getFiledPath:@"xl.plist"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL result = [fileManager fileExistsAtPath:plistPaht];
    if (result) {
        //  存在
        NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:plistPaht];
        NSArray *arr = [dic valueForKey:@"data"];
        _dataArr = [arr mutableCopy];
    } else {
        //  存在
//        NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:plistPaht];
//        NSArray *arr = [dic valueForKey:@"data"];
//        _dataArr = [arr mutableCopy];
    }
    [_dataTableView reloadData];
}


#pragma mark - datasource -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count ? _dataArr.count : 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"dataCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (nil == cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.text = _dataArr.count ? _dataArr[indexPath.row] : @"无数据";
    return cell;
}
#pragma mark - delegate -
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
