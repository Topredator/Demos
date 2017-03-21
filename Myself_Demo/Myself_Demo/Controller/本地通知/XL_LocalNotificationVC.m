//
//  XL_LocalNotificationVC.m
//  Myself_Demo
//
//  Created by 商帮 on 22/5/15.
//  Copyright (c) 2015年 北京蓝海互联有限公司. All rights reserved.
//

#import "XL_LocalNotificationVC.h"
#import "NSString+MD5.h"

@interface XL_LocalNotificationVC ()
{
    IBOutlet UITextField *notificationTF;
    IBOutlet UIDatePicker *dataPicker;
    
    IBOutlet UIButton *saveBtn;
}
@end

@implementation XL_LocalNotificationVC

- (void)loadInitNotification{
    self.title = @"本地通知";
    [self layerWithView:dataPicker isCornerRadius:NO];
    [self layerWithView:saveBtn isCornerRadius:YES];
    
}
//  对试图layer的修改
- (void)layerWithView:(UIView *)view isCornerRadius:(BOOL)isRadius{
    view.layer.borderColor = [UIColor lightGrayColor].CGColor;
    view.layer.borderWidth = .3f;
    if (isRadius) {
        view.layer.cornerRadius = 5.f;
    }
    view.layer.masksToBounds = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self loadInitNotification];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)saveAction:(id)sender {
    if ([notificationTF.text isEqualToString:@""]) {
        NSLog(@"输入");
        return;
    }
    NSDate *date = [dataPicker date];
//    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:10];
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    notification.fireDate = date;
    notification.alertBody = notificationTF.text;
    notification.alertAction = @"show me";
    notification.timeZone = [NSTimeZone defaultTimeZone];
    notification.repeatInterval = 0;
    
    NSDictionary *infoDic = [NSDictionary dictionaryWithObject:@"name" forKey:@"key"];
    notification.userInfo = infoDic;
    notification.applicationIconBadgeNumber = [[UIApplication sharedApplication] applicationIconBadgeNumber] + 1;
    notification.soundName = UILocalNotificationDefaultSoundName;
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
    //  返回
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [notificationTF resignFirstResponder];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSLog(@"md5 = %@", [NSString stringWithString:[NSString MD5:@"123"]]);
}
@end
