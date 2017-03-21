//
//  XL_Friend.h
//  Myself_Demo
//
//  Created by 商帮 on 18/4/15.
//  Copyright (c) 2015年 北京蓝海互联有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XL_Friend : NSObject
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *intro;
@property (nonatomic, assign) BOOL isVip;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)friendWithDict:(NSDictionary *)dict;

@end
