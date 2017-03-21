//
//  XL_ScanCell.m
//  Myself_Demo
//
//  Created by 商帮 on 16/4/15.
//  Copyright (c) 2015年 北京蓝海互联有限公司. All rights reserved.
//

#import "XL_ScanCell.h"
#import "Public_Class.h"



const CGFloat btnWidth = 90;
const CGFloat btnHeight = 60;
@implementation XL_ScanCell
- (void)setFrame:(UIView *)view value:(CGFloat)value style:(NSInteger)style
{
    CGRect frame = view.frame;
    if (style == 1) frame.origin.x = value;
    else if (style == 2) frame.origin.y = value;
    else if (style == 3) frame.size.width = value;
    else if (style == 4) frame.size.height = value;
    view.frame = frame;
}

- (void)awakeFromNib {
    // Initialization code
    _bigView.layer.cornerRadius = 5;
    _bigView.layer.borderWidth = .5f;
    _bigView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _bigView.layer.masksToBounds = YES;
    
    _headerImage.layer.cornerRadius = _headerImage.frame.size.width / 2;
    _headerImage.layer.masksToBounds = YES;
//    [self setFrame:_headerImage value:50 style:2];
//    [self setFrame:_headerImage value:50 style:4];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}
//  根据文字获取label的高
- (CGFloat)heightForString:(NSString *)str view:(UIView *)view
{
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:13], NSFontAttributeName, nil];
    CGFloat height = [str boundingRectWithSize:CGSizeMake(CGRectGetWidth(view.frame), 1000) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size.height;
    return height;
}

- (void)customWithCell:(NSDictionary *)dict delegate:(id)delegate
{
    _delegate = delegate;
    _contentLabel.hidden = YES;
    for (UIImageView *image in _picView.subviews) {
        [image removeFromSuperview];
    }
    _picView.hidden = YES;
    _time.hidden = YES;
    
    CGFloat high = 65;

    
    name.text = dict[@"name"];
    status.text = [NSString stringWithFormat:@"状态：%@", dict[@"status"]];
    
    //  判断文字
    NSString *content = dict[@"content"];
    if (content != nil && content.length) {
        _contentLabel.hidden = NO;
        _contentLabel.text = content;
        [self setFrame:_contentLabel value:ScreenFrame_width - 20 style:3];
        CGFloat height = [self heightForString:content view:_contentLabel];
        [self setFrame:_contentLabel value:height style:4];
        high += height + 5;
    }
    //  判断图片
    _picsArr = dict[@"images"];
    NSArray *imagesArr = dict[@"images"];
    if (imagesArr != nil && imagesArr.count) {
        _picView.hidden = NO;
        CGFloat x = 0, y = 0, width = 90, height = 60;
        for (int i = 0; i < imagesArr.count; i++) {
            if(i > 0) x += 90 + 5;
            if(i % 3 == 0 && i > 0) x = 0, y += 60 + 5;
            UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, width, height)];
            image.backgroundColor = [UIColor purpleColor];
            image.userInteractionEnabled = YES;
            image.tag = 1000 + i;
            UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickPic:)];
            tapGR.numberOfTapsRequired = 1;
            tapGR.numberOfTouchesRequired = 1;
            [image addGestureRecognizer:tapGR];
            [_picView addSubview:image];
        }
        //  高
        [self setFrame:_picView value:y + height style:4];
        //  y
        [self setFrame:_picView value:high style:2];
        //  宽
        [self setFrame:_picView value:280 style:3];
        high += y + height + 5;
    }
    
    //  判断时间
    NSString *timeStr = dict[@"time"];
    if (timeStr != nil && timeStr.length) {
        _time.hidden = NO;
        _time.text = timeStr;
        //  高
        [self setFrame:_time value:20 style:4];
        //  y
        [self setFrame:_time value:high style:2];
        high += 20 + 5;
    }
    
    [self setFrame:_bigView value:high style:4];
    [self setFrame:_bigView value:ScreenFrame_width style:3];
    
    CGRect rect = self.frame;
    rect.size.height = high + 10;
    [self setFrame:rect];
}

//  点击图片
- (void)clickPic:(UITapGestureRecognizer *)tap
{
    UIViewController *vc = _delegate;
    CGRect rect = [vc.navigationController.view convertRect:tap.view.frame fromView:tap.view.superview];
    _bgView = [[UIView alloc] initWithFrame:rect];
    _bgView.backgroundColor = [UIColor blackColor];
    
    //  获得当前点击图片的下标
    UIImageView *imageView = (UIImageView *)tap.view;
    NSArray *imagesArr = imageView.superview.subviews;
    NSUInteger index = [imagesArr indexOfObject:imageView];
    
    //  动画 放大到整屏
    [UIView animateWithDuration:.5 animations:^{
        _bgView.frame = CGRectMake(0, 0, ScreenFrame_width, ScreenFrame_height);
        _imageScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, _bgView.frame.size.width, _bgView.frame.size.height)];
        _imageScroll.contentOffset = CGPointMake(_bgView.frame.size.width *index, 0);
        _imageScroll.contentSize = CGSizeMake(_bgView.frame.size.width *_picsArr.count, _bgView.frame.size.height);
        _imageScroll.delegate = _delegate;
        _imageScroll.pagingEnabled = YES;
        _imageScroll.showsHorizontalScrollIndicator = NO;
        
        [_bgView addSubview:_imageScroll];
        [vc.navigationController.view addSubview:_bgView];
    } completion:^(BOOL finished) {
        //  在scroll上面添加图片跟标签
        for (int i = 0; i < _picsArr.count; i++) {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(_imageScroll.frame.size.width * i, 0, ScreenFrame_width, ScreenFrame_height - 80)];
            imageView.tag = 100 + i;
            imageView.userInteractionEnabled = YES;
            imageView.backgroundColor = [UIColor purpleColor];
            imageView.contentMode = UIViewContentModeScaleAspectFit;
            [_imageScroll addSubview:imageView];
            UITapGestureRecognizer *tapOne = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOneAction:)];
            tapOne.numberOfTapsRequired = 1;
            [imageView addGestureRecognizer:tapOne];
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(_imageScroll.frame.size.width / 2 - 50 + _imageScroll.frame.size.width * i, _imageScroll.frame.size.height - 60, 100, 30)];
            label.text = [NSString stringWithFormat:@"%d / %ld", i + 1, _picsArr.count];
            label.textAlignment = NSTextAlignmentCenter;
            label.tag = 200 + i;
            label.textColor = [UIColor whiteColor];
            [_imageScroll addSubview:label];
        }
    }];
    
}

//  点击图片让其缩放
- (void)tapOneAction:(UITapGestureRecognizer *)tap
{
    UIViewController *vc = _delegate;
    CGRect rect = [vc.navigationController.view convertRect:((UIImageView *)[_picView viewWithTag:tap.view.tag - 100 + 1000]).frame fromView:_picView];
    [UIView animateWithDuration:2 animations:^{
        _bgView.frame = rect;
        for (int i = 0; i < _picsArr.count; i++) {
            UIImageView *imageView = (UIImageView *)[_imageScroll viewWithTag:100 + i];
            UILabel *label = (UILabel *)[_imageScroll viewWithTag:200 + i];
            [imageView removeFromSuperview];
            [label removeFromSuperview];
        }
    } completion:^(BOOL finished) {
        [_bgView removeFromSuperview];
    }];
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
