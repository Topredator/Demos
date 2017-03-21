//
//  XL_SQLiteVC.m
//  Myself_Demo
//
//  Created by 商帮 on 1/6/15.
//  Copyright (c) 2015年 北京蓝海互联有限公司. All rights reserved.
//

#import "XL_SQLiteVC.h"

#import <sqlite3.h>

#import "XL_ShareHandle.h"

#import "Person.h"
#define kDB_NAME  @"person.sqlite"
#define kTable_NAME  @"person"
#import "FMDB.h"

@interface XL_SQLiteVC ()<UITableViewDataSource, UITableViewDelegate>
{
//    sqlite3 *db;
    FMDatabase *_db;
    IBOutlet UITableView *_sqlTableview;
    NSMutableArray *_datasArr;
}
@end

@implementation XL_SQLiteVC

- (void)loadInitSQL{
    self.title = @"SQL读取";
    _datasArr = [NSMutableArray array];
    NSString *path = [self dataBaseFilePath:kDB_NAME];
    _db = [FMDatabase databaseWithPath:path];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL exist = [fileManager fileExistsAtPath:path];
    
    if (!exist) {
        _db = [FMDatabase databaseWithPath:path];
        NSLog(@"数据库创建成功");
    } else {
        [_db open];
        [_db setShouldCacheStatements:YES];
        [self createTable:kTable_NAME dataBase:_db];
        [_db close];
    }
}
//  创建表
- (void)createTable:(NSString *)tableName dataBase:(FMDatabase *)db{
    if (![db tableExists:tableName]) {
        NSString *str = [NSString stringWithFormat:@"CREATE TABLE %@ (name TEXT, sex Text)", tableName];
        [db executeUpdate:str];
        NSLog(@"表创建成功");
    } else {
        NSLog(@"表已存在");
    }
}
//  查询数据
- (void)selectWithObjectFromDataBase:(FMDatabase *)db tableName:(NSString *)tableName{
    [_datasArr removeAllObjects];
    
    [db open];
    [db setShouldCacheStatements:YES];
    NSString *sql = [NSString stringWithFormat:@"select * from %@", tableName];
    FMResultSet *set = [db executeQuery:sql];
    while ([set next]) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setValue:[set stringForColumn:@"name"] forKey:@"name"];
        [dic setValue:[set stringForColumn:@"sex"] forKey:@"sex"];
        [_datasArr addObject:dic];
    }
    [set close];
    [db close];
}
//  插入数据
- (void)insertDataWithDic:(NSDictionary *)dict dataBase:(FMDatabase *)db tableName:(NSString *)tableName{
    if (db) {
        [db open];
        [db executeUpdate:@"insert into person (name, sex) values (?,?)", dict[@"name"], dict[@"sex"]];
        [db close];
    }
}

//  删除数据
- (void)deleteDataWithTable:(NSString *)tableName dataBase:(FMDatabase *)db indexPath:(NSIndexPath *)indexPath{
    if (db) {
        [db open];
//        NSString *delete = [NSString stringWithFormat:@"delete from %@ where name = ?",  tableName];
        [db executeUpdate:@"delete from person where name = ?", _datasArr[indexPath.row][@"name"]];
        NSLog(@"删除成功");
        [db close];
    }
}

#pragma mark - 插入数据 -
- (IBAction)insertAction:(id)sender {
    NSDictionary *dic = @{@"name":@"金浩", @"sex":@"男"};
    NSDictionary *dic1 = @{@"name":@"王帅", @"sex":@"男"};
    NSDictionary *dic2 = @{@"name":@"乐仁龙", @"sex":@"男"};
    NSDictionary *dic3 = @{@"name":@"明星", @"sex":@"男"};
    [self insertDataWithDic:dic3 dataBase:_db tableName:kTable_NAME];
}

#pragma mark - 读取数据 -
- (IBAction)readerAction:(id)sender {
    [self selectWithObjectFromDataBase:_db tableName:kTable_NAME];
    [_sqlTableview reloadData];
}


- (NSString *)dataBaseFilePath:(NSString *)string{
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *dbPath = [documentPath stringByAppendingPathComponent:string];
    return dbPath;
}

#pragma mark - datasource -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _datasArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"sqlCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (nil == cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    cell.textLabel.text = _datasArr[indexPath.row][@"name"];
    cell.detailTextLabel.text = _datasArr[indexPath.row][@"sex"];
    return cell;
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    //  从数据库中删除
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self deleteDataWithTable:kTable_NAME dataBase:_db indexPath:indexPath];
        [_datasArr removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
    }
    
}
#pragma mark - delegate -
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self loadInitSQL];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
