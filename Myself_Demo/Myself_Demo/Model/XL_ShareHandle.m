//
//  XL_ShareHandle.m
//  Myself_Demo
//
//  Created by 商帮 on 16/4/15.
//  Copyright (c) 2015年 北京蓝海互联有限公司. All rights reserved.
//

#import "XL_ShareHandle.h"

#import <sqlite3.h>
#import "Person.h"

static XL_ShareHandle *shareHandle = nil;

@interface XL_ShareHandle ()

@end

@implementation XL_ShareHandle
+ (XL_ShareHandle *)shareHandle
{
    @synchronized(self){
        if (!shareHandle) {
            shareHandle = [[XL_ShareHandle alloc] init];
            shareHandle.datasArr = [NSMutableArray array];
        }
    }
    return shareHandle;
}
//  第一个是数据库名   第二个为标明
- (void)loadData:(NSString *)db_Name tableName:(NSString *)tableName{
    //  创建数据库
    if (_db) {
        [_db open];
        [self getAllObjectFromTable:tableName];
        return;
    }
    _db = [self creatDataBaseWithName:db_Name];
    [_db open];

    //  为数据库设置缓存， 提高查询效率
    [_db setShouldCacheStatements:YES];
    if (! [_db tableExists:tableName]) {
        [_db executeUpdate:@"CREATE TABLE PERSON (pID INTEGER PRIMARY KEY AUTOINCREAMENT, name TEXT, sex TEXT, age INTEGER, address TEXT)"];
        NSLog(@"表创建成功");
        [self getAllObjectFromTable:tableName];
    } else {
        [self getAllObjectFromTable:tableName];
    }
    [_db close];
}
//  创建数据库
- (FMDatabase *)creatDataBaseWithName:(NSString *)db_Name{
    FMDatabase *dataBase = [FMDatabase databaseWithPath:[[XL_ShareHandle shareHandle] dataBaseFilePath:db_Name]];
    return dataBase;
}

//  查询
- (NSArray *)getAllObjectFromTable:(NSString *)tableName{
    [self.datasArr removeAllObjects];
//    if (!_db) {
//        [self creatDataBaseWithName:tableName];
//    }
//    if (![_db open]) {
//        return nil;
//    }
    FMResultSet *resultSet = [_db executeQuery:@"select * from person"];
    while ([resultSet next]) {
        Person *person = [[Person alloc] init];
        person.pID = [resultSet intForColumn:@"pID"];
        person.name = [resultSet stringForColumn:@"name"];
        person.sex = [resultSet stringForColumn:@"sex"];
        person.age = [resultSet intForColumn:@"age"];
        person.address = [resultSet stringForColumn:@"address"];
        [self.datasArr addObject:person];
    }
    return [_datasArr copy];
}

+ (void)insertDataWith:(NSString *)db_Name table_Name:(NSString *)tableName personDic:(NSDictionary *)personDic{
    Person *person = [[Person alloc] initWithDic:personDic];
//    if (![[XL_ShareHandle shareHandle] db]) {
//        [shareHandle creatDataBaseWithName:db_Name];
//    }
    [shareHandle.db open];
    [shareHandle.db setShouldCacheStatements:YES];
    
    //现在表中查询有没有相同的元素，如果有，做修改操作
    //  否则向数据库中插入一条数据
    FMResultSet *resultSet = [shareHandle.db executeQuery:@"select * from person where people_id = ?", [NSString stringWithFormat:@"%ld",person.pID]];
    if ([resultSet next]) {
        [shareHandle.db executeUpdate:@"updata person set name = ?, sex = ?, age = ?, address = ? where pID = 0", person.name, person.sex, person.age, person.address];
    } else {
        [shareHandle.db executeUpdate:@"INSERT INTO PERSON (name, sex, age, address) VALUES (?,?,?,?)",person.name, person.sex, [NSString stringWithFormat:@"%ld",person.age], person.address];
    }
    [shareHandle.db close];
}


- (NSString *)dataBaseFilePath:(NSString *)string{
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *dbPath = [documentPath stringByAppendingPathComponent:string];
    return dbPath;
}
@end
