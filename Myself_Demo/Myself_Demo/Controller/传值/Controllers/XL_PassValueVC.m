//
//  XL_PassValueVC.m
//  Myself_Demo
//
//  Created by 商帮 on 16/4/15.
//  Copyright (c) 2015年 北京蓝海互联有限公司. All rights reserved.
//

#import "XL_PassValueVC.h"

#import "XL_ShareHandle.h"
#import "XL_PassValueDetailVC.h"


@interface XL_PassValueVC ()<XL_PassValueDelegate>
{
    IBOutlet UILabel *valueLabel;
    IBOutlet UIButton *goBtn;
}

@end

@implementation XL_PassValueVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    goBtn.layer.cornerRadius = goBtn.frame.size.width / 2;
    goBtn.layer.masksToBounds = YES;
    [self createWithNotification];
}
//  创建通知
- (void)createWithNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationAction:) name:@"notificaton" object:nil];
}

- (void)notificationAction:(NSNotification *)note
{
    NSString *str = [note object];
    if (str != nil && str.length) {
        valueLabel.text = str;
    }
}
- (void)removeNotification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"notificaton" object:nil];
}

- (void)showDetailVC:(BlockReturn)blockReturn
{
    XL_PassValueDetailVC *passDetailVC = [[XL_PassValueDetailVC alloc] init];
    passDetailVC.blockReturn = blockReturn;
    [self.navigationController pushViewController:passDetailVC animated:YES];
}

- (IBAction)goDetailAction:(id)sender {
    XL_PassValueDetailVC *passDetailVC = [[XL_PassValueDetailVC alloc] init];
    switch ([XL_ShareHandle shareHandle].passValue_style) {
        case PassValue_delegate:
        {
            //  代理
            passDetailVC.delegate = self;
            [self.navigationController pushViewController:passDetailVC animated:YES];
        }
            break;
        case PassValue_block:
        {
            //  Block
            __block UILabel *lb = valueLabel;
            [self showDetailVC:^(NSString *str) {
                if (str != nil && str.length) {
                    lb.text = str;
                }
            }];
        }
            break;
        default:
        {
            //  通知
            [self.navigationController pushViewController:passDetailVC animated:YES];
        }
            break;
    }
    
    
}


#pragma mark - XL_PassValueDelegate -
- (void)passValueWithString:(NSString *)string
{
    if (string != nil && string.length) {
        valueLabel.text = string;
    }
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
- (void)dealloc
{
    //  移除通知
    [self removeNotification];
}
@end
