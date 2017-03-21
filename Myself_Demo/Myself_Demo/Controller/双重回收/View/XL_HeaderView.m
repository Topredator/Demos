//
//  XL_HeaderView.m
//  Myself_Demo
//
//  Created by 商帮 on 18/4/15.
//  Copyright (c) 2015年 北京蓝海互联有限公司. All rights reserved.
//

#import "XL_HeaderView.h"
#import "XL_GroupFriend.h"


@implementation XL_HeaderView
{
    UIButton *_arrowBtn;
    UILabel *_titleLabel;
}
+ (instancetype)headerView:(UITableView *)tableView
{
    static NSString *identifier = @"headerView";
    XL_HeaderView *headerView = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!headerView) {
        headerView = [[XL_HeaderView alloc] initWithReuseIdentifier:identifier];
    }
    return headerView;
}
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setBackgroundImage:[UIImage imageNamed:@"header_bg"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"header_bg_highlighted"] forState:UIControlStateHighlighted];
        [button setImage:[UIImage imageNamed:@"header_arrow"] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        button.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        button.imageView.contentMode = UIViewContentModeCenter;
        [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
        button.imageView.clipsToBounds = NO;
        _arrowBtn = button;
        [self addSubview:_arrowBtn];
        //  创建label， 显示总人数与上线人数
        UILabel *labelRight = [[UILabel alloc] init];
        labelRight.textAlignment = NSTextAlignmentCenter;
        _titleLabel = labelRight;
        [self addSubview:_titleLabel];
    }
    return self;
}
#pragma mark - 按钮点击事件 - 
- (void)buttonAction
{
    self.groupModel.isOpen = !self.groupModel.isOpen;
    if ([self.delegate respondsToSelector:@selector(clickHeaderView)]) {
        [self.delegate clickHeaderView];
    }
}

- (void)didMoveToSuperview{
    _arrowBtn.imageView.transform = self.groupModel.isOpen ? CGAffineTransformMakeRotation(M_PI_2) :CGAffineTransformMakeRotation(0);
}

//  布局
- (void)layoutSubviews
{
    [super layoutSubviews];
    _arrowBtn.frame = self.bounds;
    _titleLabel.frame = CGRectMake(self.frame.size.width - 70, 0, 60, self.frame.size.height);
}

//赋值
- (void)setGroupModel:(XL_GroupFriend *)groupModel{
    _groupModel = groupModel;
    [_arrowBtn setTitle:_groupModel.name forState:UIControlStateNormal];
    _titleLabel.text = [NSString stringWithFormat:@"%@/%lu",_groupModel.online,(unsigned long)_groupModel.friends.count];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
