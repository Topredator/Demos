//
//  XL_WaterFallCell.m
//  Myself_Demo
//
//  Created by 商帮 on 12/5/15.
//  Copyright (c) 2015年 北京蓝海互联有限公司. All rights reserved.
//

#import "XL_WaterFallCell.h"
#import "Public_Class.h"


@implementation XL_WaterFallCell
- (void)setImage:(UIImage *)image{
    if (_image != image) {
        _image = image;
    }
    [self setNeedsDisplay];
}
- (void)drawRect:(CGRect)rect{
    float newHeight = _image.size.height / _image.size.width * (ScreenFrame_width - 20) / 3;
    [_image drawInRect:CGRectMake(0, 0, (ScreenFrame_width - 20) / 3, newHeight)];
}

@end
