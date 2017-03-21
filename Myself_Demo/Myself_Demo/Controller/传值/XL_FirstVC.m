//
//  XL_FirstVC.m
//  Myself_Demo
//
//  Created by 商帮 on 16/4/15.
//  Copyright (c) 2015年 北京蓝海互联有限公司. All rights reserved.
//

#import "XL_FirstVC.h"
#import "XL_ShareHandle.h"

#import "XL_PassValueVC.h"

@interface XL_FirstVC ()
{
    IBOutlet UIButton *_delegateBtn;
    
    IBOutlet UIButton *_blockBtn;
    
    IBOutlet UIButton *_notificationBtn;
}
@end

@implementation XL_FirstVC

- (void)initWithCustom
{
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.title = @"传值";
    
    //  圆形
    _delegateBtn.layer.cornerRadius = _delegateBtn.frame.size.width / 2;
    _delegateBtn.layer.masksToBounds = YES;
    
    _blockBtn.layer.cornerRadius = _blockBtn.frame.size.width / 2;
    _blockBtn.layer.masksToBounds = YES;
    
    _notificationBtn.layer.cornerRadius = _notificationBtn.frame.size.width / 2;
    _notificationBtn.layer.masksToBounds = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initWithCustom];
}
- (IBAction)passAction:(id)sender {
    UIButton *btn = (UIButton *)sender;
    UIViewController *pushVC;
    
    if (btn.tag == 1000) [XL_ShareHandle shareHandle].passValue_style = PassValue_delegate;
    else if (btn.tag == 1001) [XL_ShareHandle shareHandle].passValue_style = PassValue_block;
    else if (btn.tag == 1002) [XL_ShareHandle shareHandle].passValue_style = PassValue_notification;
    
    pushVC = [[XL_PassValueVC alloc] init];
    [self.navigationController pushViewController:pushVC animated:YES];
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
