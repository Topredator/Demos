//
//  XL_GroupFriend.h
//  Myself_Demo
//
//  Created by 商帮 on 18/4/15.
//  Copyright (c) 2015年 北京蓝海互联有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
@class XL_Friend;
@interface XL_GroupFriend : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *online;
@property (nonatomic, strong) NSArray *friends;
@property (nonatomic, strong) XL_Friend *friendModel;
@property (nonatomic, assign) BOOL isOpen;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)groupWithDict:(NSDictionary *)dict;


@end
