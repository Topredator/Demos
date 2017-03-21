//
//  XL_AlertSheet.h
//  Myself_Demo
//
//  Created by 商帮 on 5/5/15.
//  Copyright (c) 2015年 北京蓝海互联有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XL_AlertSheet;
@protocol XL_AlertSheetDelegate <NSObject>
@optional
- (void)alertSheet:(XL_AlertSheet *)aletSheet didSelectIndex:(NSInteger)btnIndex;
@end

@interface XL_AlertSheet : UIView

@property (nonatomic, strong) id <XL_AlertSheetDelegate>delegate;


//  初始化
- (instancetype)initWithTitle:(NSString *)title titlesArr:(NSArray *)titlesArr buttonIndex:(NSInteger)btnIndex delegate:(id<XL_AlertSheetDelegate>)delegate;
//  展示
- (void)show;
@end
