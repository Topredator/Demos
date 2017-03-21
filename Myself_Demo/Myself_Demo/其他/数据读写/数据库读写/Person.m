//
//  Person.m
//  Myself_Demo
//
//  Created by 商帮 on 3/6/15.
//  Copyright (c) 2015年 北京蓝海互联有限公司. All rights reserved.
//

#import "Person.h"

@implementation Person
- (instancetype)initWithDic:(NSDictionary *)dict{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
- (instancetype)initWithId:(NSInteger)pID name:(NSString *)pName sex:(NSString *)pSex age:(NSInteger)pAge address:(NSString *)pAddress{
    self = [super init];
    if (self) {
        self.pID = pID;
        self.name = pName;
        self.sex = pSex;
        self.age = pAge;
        self.address = pAddress;
    }
    return self;
}
@end
