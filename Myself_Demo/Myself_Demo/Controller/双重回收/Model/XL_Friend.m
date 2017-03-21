//
//  XL_Friend.m
//  Myself_Demo
//
//  Created by 商帮 on 18/4/15.
//  Copyright (c) 2015年 北京蓝海互联有限公司. All rights reserved.
//

#import "XL_Friend.h"

@implementation XL_Friend
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
+ (instancetype)friendWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}
@end
