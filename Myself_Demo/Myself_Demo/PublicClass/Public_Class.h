//
//  Public_Class.h
//  Myself_Demo
//
//  Created by 商帮 on 16/4/15.
//  Copyright (c) 2015年 北京蓝海互联有限公司. All rights reserved.
//

#ifndef Myself_Demo_Public_Class_h
#define Myself_Demo_Public_Class_h

#define ScreenFrame   [[UIScreen mainScreen] bounds]
#define ScreenFrame_width ScreenFrame.size.width
#define ScreenFrame_height  ScreenFrame.size.height

//  字体大小
#define KFont(i)  [UIFont systemFontOfSize:i]
//  颜色
#define RGB(x, y, z, alp)  [UIColor colorWithRed:x / 255.0 green:y / 255.0 blue:z / 255.0 alpha:alp]

#define KUrl  @"http://aft.sc/app/index.php"


#endif
