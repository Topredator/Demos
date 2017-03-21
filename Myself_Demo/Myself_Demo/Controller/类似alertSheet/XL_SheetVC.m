//
//  XL_SheetVC.m
//  Myself_Demo
//
//  Created by 商帮 on 5/5/15.
//  Copyright (c) 2015年 北京蓝海互联有限公司. All rights reserved.
//

#import "XL_SheetVC.h"

#import "XL_AlertSheet.h"

@interface XL_SheetVC ()<XL_AlertSheetDelegate>

@end

@implementation XL_SheetVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"类alertSheet";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//  退出登录
- (IBAction)outAction:(id)sender {
    XL_AlertSheet *sheet = [[XL_AlertSheet alloc] initWithTitle:@"你要退出登录吗？"
                                                                                titlesArr:@[@"确定"]
                                                                                buttonIndex:0
                                                                                delegate:self];
    [sheet show];
}
//  更换头像
- (IBAction)changeHeader:(id)sender {
    XL_AlertSheet *sheet = [[XL_AlertSheet alloc] initWithTitle:nil
                                                                                titlesArr:@[@"拍照", @"从相册选取"]
                                                                                buttonIndex:-1
                                                                                delegate:self];
    [sheet show];
}
#pragma mark - XL_AlertSheetDelegate -
- (void)alertSheet:(XL_AlertSheet *)aletSheet didSelectIndex:(NSInteger)btnIndex
{
    NSLog(@"btnIndex = %ld", btnIndex);
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
