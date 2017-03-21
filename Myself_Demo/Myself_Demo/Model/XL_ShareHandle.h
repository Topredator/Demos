//
//  XL_ShareHandle.h
//  Myself_Demo
//
//  Created by 商帮 on 16/4/15.
//  Copyright (c) 2015年 北京蓝海互联有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"


//  传值的种类
typedef enum {
    PassValue_delegate = 0,
    PassValue_block = 1,
    PassValue_notification = 2,
}PassValue_style;

@class Person;
@interface XL_ShareHandle : NSObject

@property (nonatomic, assign) PassValue_style passValue_style;

@property (nonatomic, assign) BOOL isLogin;

@property (nonatomic, strong) NSMutableArray *datasArr;

@property (nonatomic, strong) FMDatabase *db;

+ (XL_ShareHandle *)shareHandle;
- (void)loadData:(NSString *)db_Name tableName:(NSString *)tableName;

+ (void)insertDataWith:(NSString *)db_Name table_Name:(NSString *)tableName personDic:(NSDictionary *)personDic;


@end
