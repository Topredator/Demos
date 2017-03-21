//
//  XL_Tools.h
//  Myself_Demo
//
//  Created by 商帮 on 16/4/15.
//  Copyright (c) 2015年 北京蓝海互联有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface XL_Tools : NSObject
//  tableview
+ (UITableView *)createWithTableView:(id)delegate frame:(CGRect)frame;
//  btn
+ (UIButton *)createWithBtn:(id)delegate frame:(CGRect)frame title:(NSString *)title font:(UIFont *)font bgColor:(UIColor *)bgColor isRound:(BOOL)isRound clickAction:(SEL)clickAction;
//  label
+ (UILabel *)createWithLabel:(CGRect)frame title:(NSString *)title titleColor:(UIColor *)titleColor bgColor:(UIColor *)bgColor font:(UIFont *)font;
//  textField
@end
