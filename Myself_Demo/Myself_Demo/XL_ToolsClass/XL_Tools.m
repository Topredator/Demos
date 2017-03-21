//
//  XL_Tools.m
//  Myself_Demo
//
//  Created by 商帮 on 16/4/15.
//  Copyright (c) 2015年 北京蓝海互联有限公司. All rights reserved.
//

#import "XL_Tools.h"

@implementation XL_Tools

+ (UITableView *)createWithTableView:(id)delegate frame:(CGRect)frame
{
    UITableView *tableview = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    tableview.dataSource = delegate;
    tableview.delegate = delegate;
    return tableview;
}
+ (UIButton *)createWithBtn:(id)delegate frame:(CGRect)frame title:(NSString *)title font:(UIFont *)font bgColor:(UIColor *)bgColor isRound:(BOOL)isRound clickAction:(SEL)clickAction
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.font = font;
    btn.frame = frame;
    btn.backgroundColor = bgColor;
    [btn addTarget:delegate action:clickAction forControlEvents:UIControlEventTouchUpInside];
    if (isRound) {
        btn.layer.cornerRadius = btn.frame.size.width / 2;
        btn.layer.masksToBounds = YES;
    }
    return btn;
}
+ (UILabel *)createWithLabel:(CGRect)frame title:(NSString *)title titleColor:(UIColor *)titleColor bgColor:(UIColor *)bgColor font:(UIFont *)font
{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.text = title;
    label.textColor = titleColor;
    label.backgroundColor = bgColor;
    label.font = font;
    return label;
}

@end
