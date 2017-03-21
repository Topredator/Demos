//
//  XL_CoreImageVC.m
//  Myself_Demo
//
//  Created by 商帮 on 22/5/15.
//  Copyright (c) 2015年 北京蓝海互联有限公司. All rights reserved.
//

#import "XL_CoreImageVC.h"

@interface XL_CoreImageVC ()

@end

@implementation XL_CoreImageVC

#pragma mark - CoreImage 模糊滤镜
- (void)coreImage{
    self.title = @"CIImage";
    //  原始图片
    UIImage *image = [UIImage imageNamed:@"huoying5"];
    
    /* -------------------coreImage部分-----------------------*/
    //  CIImage
    CIImage *ciImage = [[CIImage alloc] initWithImage:image];
    //  CIFilter
    CIFilter *blurFilter = [CIFilter filterWithName:@"CIGaussianBlur"];
    //  将图片输入滤镜中
    [blurFilter setValue:ciImage forKey:kCIInputImageKey];
    //  设置模糊程度
    [blurFilter setValue:@(5) forKey:@"inputRadius"];
    //  用来查询滤镜可以设置的参数以及一些相关的信息
    NSLog(@"%@", [blurFilter attributes]);
    //  将处理好的图片输出
    CIImage *outImage = [blurFilter valueForKey:kCIOutputImageKey];
    //  CIContext
    CIContext *context = [CIContext contextWithOptions:nil];
    //  获取CGImage句柄
    CGImageRef outCGImage = [context createCGImage:outImage fromRect:[outImage extent]];
    //  最终获取到图片
    UIImage *blurImage = [UIImage imageWithCGImage:outCGImage];
    //  释放CGImage句柄
    CGImageRelease(outCGImage);
    /* -------------------------------------------------------*/
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 146, 220)];
    imageView.image = blurImage;
    imageView.center = self.view.center;
    [self.view addSubview:imageView];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self coreImage];
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
