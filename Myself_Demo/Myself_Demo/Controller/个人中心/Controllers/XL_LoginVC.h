//
//  XL_LoginVC.h
//  Myself_Demo
//
//  Created by 商帮 on 21/4/15.
//  Copyright (c) 2015年 北京蓝海互联有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ReturnBlcok)(NSString *str);

@interface XL_LoginVC : UIViewController
@property (nonatomic, copy) ReturnBlcok returnBlock;
@end
