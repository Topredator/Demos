//
//  XL_BannerVC.m
//  Myself_Demo
//
//  Created by 商帮 on 28/4/15.
//  Copyright (c) 2015年 北京蓝海互联有限公司. All rights reserved.
//

#import "XL_BannerVC.h"
#import "Public_Class.h"

#import "CycleScrollView.h"


@interface XL_BannerVC ()
{
    CycleScrollView *_mainScroll;
    UIPageControl *_pageControl;
}
@end

const CGFloat pageControlWeith = 100;
const CGFloat pageControlHeight = 30;
@implementation XL_BannerVC

- (void)loadInitXL
{
    self.title = @"轮播图";
    
    NSMutableArray *viewsArr = [@[] mutableCopy];
    
    NSArray *colorsArr = @[[UIColor blueColor], [UIColor grayColor], [UIColor greenColor], [UIColor purpleColor], [UIColor blackColor]];
    //  imageview
    for (int i = 0; i < 5; i++) {
        UIImageView *scrollImage = [[UIImageView alloc] initWithFrame:CGRectMake(i * ScreenFrame_width, 0, ScreenFrame_width, 150)];
        scrollImage.backgroundColor = colorsArr[i];
        [viewsArr addObject:scrollImage];
    }
    //  创建view 给定frame  与  滚动时间
    _mainScroll = [[CycleScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenFrame_width, 150) animationDuration:2];
    //  获取 pageIndex 个位置的contentview
    _mainScroll.fetchContentViewAtIndex = ^UIView *(NSInteger pageIndex){
        return viewsArr[pageIndex];
    };
    //  获取总page个数
    _mainScroll.totalPagesCount = ^NSInteger(void){
        return viewsArr.count;
    };
    //  点击时间
    _mainScroll.TapActionBlock = ^(NSInteger pageIndex){
        NSLog(@"点击的时第%ld个元素", pageIndex);
    };
    [self.view addSubview:_mainScroll];
    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadInitXL];
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
