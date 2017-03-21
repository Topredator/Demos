//
//  XL_PassValueDetailVC.h
//  Myself_Demo
//
//  Created by 商帮 on 16/4/15.
//  Copyright (c) 2015年 北京蓝海互联有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XL_PassValueDelegate <NSObject>
@optional
- (void)passValueWithString:(NSString *)string;
@end

typedef void (^BlockReturn)(NSString *str);

@interface XL_PassValueDetailVC : UIViewController

@property (nonatomic, copy)BlockReturn blockReturn;

@property (nonatomic, weak) id<XL_PassValueDelegate>delegate;

@end
