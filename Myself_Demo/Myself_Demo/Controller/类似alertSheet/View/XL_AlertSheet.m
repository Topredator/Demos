//
//  XL_AlertSheet.m
//  Myself_Demo
//
//  Created by 商帮 on 5/5/15.
//  Copyright (c) 2015年 北京蓝海互联有限公司. All rights reserved.
//

#import "XL_AlertSheet.h"
#import "Public_Class.h"

#define Btn_height  49.f

@interface XL_AlertSheet ()
{
    NSArray *_btnsArr;
    UIView *_backView;
    UIView *_bottomView;
}
@end

@implementation XL_AlertSheet

- (instancetype)initWithTitle:(NSString *)title titlesArr:(NSArray *)titlesArr buttonIndex:(NSInteger)btnIndex delegate:(id<XL_AlertSheetDelegate>)delegate
{
    if (self = [super init]) {
        _delegate = delegate;
        //  背景view
        UIView *backView = [[UIView alloc] init];
        backView.userInteractionEnabled = YES;
        backView.alpha = 0;
        backView.backgroundColor = RGB(49, 49, 50, 0.4);
        backView.frame = (CGRect){0, 0, ScreenFrame.size};
        [self addSubview:backView];
        _backView = backView;
        
        //  添加手势
        UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissView:)];
        tapGR.numberOfTapsRequired = 1;
        [backView addGestureRecognizer:tapGR];
        
        //  底部按钮的view
        UIView *bottomView = [[UIView alloc] init];
        bottomView.backgroundColor = RGB(214, 214, 222, 1);
        [self addSubview:bottomView];
        _bottomView = bottomView;
        
        //  判断title
        if (title) {
            //  标题
            UILabel *label = [[UILabel alloc] init];
            label.text = title;
            label.font = KFont(13);
            label.textColor = RGB(111, 111, 111, 1);
            label.backgroundColor = [UIColor whiteColor];
            label.textAlignment = NSTextAlignmentCenter;
            label.frame = (CGRect){0, 0, ScreenFrame_width, Btn_height};
            [bottomView addSubview:label];
        }
        
        //  判断按钮数组
        if (titlesArr.count) {
            _btnsArr = titlesArr;
            for (int i = 0; i < titlesArr.count; i++) {
                UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                btn.tag = i;
                btn.backgroundColor = [UIColor whiteColor];
                btn.titleLabel.font = KFont(16);
                [btn setTitle:titlesArr[i] forState:UIControlStateNormal];
                UIColor *titleColor = nil;
                if (i == btnIndex) {
                    titleColor = RGB(255, 10, 10, 1);
                } else {
                    titleColor = [UIColor blackColor];
                }
                [btn setTitleColor:titleColor forState:UIControlStateNormal];
                [btn setBackgroundImage:[UIImage imageNamed:@"bgImage_HL"] forState:UIControlStateHighlighted];
                [btn addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
                //  btn 的 y 坐标
                CGFloat btnY = Btn_height * (i + (title ? 1 : 0));
                btn.frame = (CGRect){0, btnY, ScreenFrame_width, Btn_height};
                [bottomView addSubview:btn];
            }
        }
        
        //  btn之间的线条
        for (int i = 0; i < titlesArr.count; i++) {
            UIImageView *lineImage = [[UIImageView alloc] init];
            lineImage.image = [UIImage imageNamed:@"cellLine"];
            lineImage.contentMode = UIViewContentModeScaleAspectFit;
            //  线条的 y 坐标
            CGFloat lineY = Btn_height * (i + (title ? 1 : 0));
            lineImage.frame = (CGRect){0, lineY, ScreenFrame_width, 1.f};
            [bottomView addSubview:lineImage];
        }
        
        //  取消按钮
        UIButton *cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        cancleBtn.backgroundColor = [UIColor whiteColor];
        [cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
        [cancleBtn setBackgroundImage:[UIImage imageNamed:@"bgImage_HL"] forState:UIControlStateHighlighted];
        [cancleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [cancleBtn addTarget:self action:@selector(cancleAction:) forControlEvents:UIControlEventTouchUpInside];
        cancleBtn.titleLabel.font = KFont(16);
        cancleBtn.tag = titlesArr.count;
        CGFloat cancleY = Btn_height * (titlesArr.count + (title ? 1 : 0)) + 5.f;
        cancleBtn.frame = (CGRect){0, cancleY, ScreenFrame_width, Btn_height};
        [bottomView addSubview:cancleBtn];

        //  bottomView 的 高
        CGFloat bottomH = (title ? Btn_height : 0)  + (titlesArr.count + 1) * Btn_height + 5.f;
        bottomView.frame = (CGRect){0, ScreenFrame_height, ScreenFrame_width, bottomH};
        
        self.frame = (CGRect){0, 0, ScreenFrame.size};
        [[UIApplication sharedApplication].keyWindow addSubview:self];
    }
    return self;
}
//  回收视图
- (void)dismissView:(UITapGestureRecognizer *)tap
{
    [UIView animateWithDuration:.3f delay:0 options:UIViewAnimationOptionCurveEaseOut
    animations:^{
        _backView.alpha = 0;
        _backView.userInteractionEnabled = NO;
        
        CGRect frame = _bottomView.frame;
        frame.origin.y += frame.size.height;
        _bottomView.frame = frame;
        
    } completion:^(BOOL finished) {
        //  移除视图
        [self removeFromSuperview];
    }];
}
//  点击按钮
- (void)clickAction:(UIButton *)btn{
    [self dismissView:nil];
    if ([self.delegate respondsToSelector:@selector(alertSheet:didSelectIndex:)]) {
        [self.delegate alertSheet:self didSelectIndex:btn.tag];
    }
}
//  取消按钮
- (void)cancleAction:(UIButton *)btn {
    [UIView animateWithDuration:.3f delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        _backView.alpha = 0;
        _backView.userInteractionEnabled = NO;
        
        CGRect frame = _bottomView.frame;
        frame.origin.y += frame.size.height;
        _bottomView.frame = frame;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
//  展示
- (void)show{
    [UIView animateWithDuration:.3f delay:0 options:UIViewAnimationOptionCurveEaseOut
    animations:^{
        _backView.alpha = .4f;
        _backView.userInteractionEnabled = YES;
        
        CGRect frame = _bottomView.frame;
        frame.origin.y -= frame.size.height;
        _bottomView.frame = frame;
    } completion:nil];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
