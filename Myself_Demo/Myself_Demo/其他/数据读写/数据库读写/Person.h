//
//  Person.h
//  Myself_Demo
//
//  Created by 商帮 on 3/6/15.
//  Copyright (c) 2015年 北京蓝海互联有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject
@property (nonatomic) NSInteger pID;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *sex;
@property (nonatomic) NSInteger age;
@property (nonatomic, copy) NSString *address;

- (instancetype)initWithDic:(NSDictionary *)dict;
- (instancetype)initWithId:(NSInteger)pID name:(NSString *)pName sex:(NSString *)pSex age:(NSInteger)pAge address:(NSString *)pAddress;
@end
