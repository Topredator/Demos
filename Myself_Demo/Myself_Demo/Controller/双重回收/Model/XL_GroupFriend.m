//
//  XL_GroupFriend.m
//  Myself_Demo
//
//  Created by 商帮 on 18/4/15.
//  Copyright (c) 2015年 北京蓝海互联有限公司. All rights reserved.
//

#import "XL_GroupFriend.h"
#import "XL_Friend.h"


@implementation XL_GroupFriend
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
        NSMutableArray *tempArr = [NSMutableArray array];
        for (NSDictionary *dic in self.friends) {
            XL_Friend *friendModel = [XL_Friend friendWithDict:dic];
            [tempArr addObject:friendModel];
        }
        self.friends = [tempArr copy];
    }
    return self;
}
+ (instancetype)groupWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}
@end
