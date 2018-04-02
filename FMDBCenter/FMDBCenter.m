
//
//  FMDBCenter.m
//  FMDBCenter
//
//  Created by k12 on 2018/4/2.
//  Copyright © 2018年 k12. All rights reserved.
//

#import "FMDBCenter.h"
#import <FMDB.h>
#import "DBModel.h"
@implementation FMDBCenter
static FMDBCenter *manager = nil;

+ (instancetype)instance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[[self class] alloc] init];
    });
    return manager;
}

- (instancetype)init {
    if (self = [super init]) {
        [self createDB];
    }
    return self;
}
- (NSString *)dbPath{
    // 创建SQLite
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"test.sqlite"];
    NSLog(@"%@",path);
    return path;
}

- (void)createDB {
    
    FMDatabase *db= [FMDatabase databaseWithPath:[self dbPath]] ;
    if (![db open]) {
        NSLog(@"Could not open db.");
        return ;
    }
    
    [db executeUpdate:@"CREATE TABLE IF NOT EXISTS TEST (ID INTEGER PRIMARY KEY AUTOINCREMENT, userId TEXT,  name TEXT, sex BOOL)"];
    
    //更新一个字段
    if (![db columnExists:@"age" inTableWithName:@"TEST"]){
        NSString *alertStr = [NSString stringWithFormat:@"ALTER TABLE %@ ADD %@ INTEGER",@"TEST",@"age"];
        if([db executeUpdate:alertStr]) {
            NSLog(@"表更新成功~");
        } else {
            NSLog(@"表更新失败~");
        }
    } else {
        NSLog(@"不需要更新表");
    }
    
    [db close];
    
}

- (void)instertDataModel:(DBModel*)model{
    FMDatabase *db= [FMDatabase databaseWithPath:[self dbPath]] ;
    if (![db open]) {
        NSLog(@"保存的时候没有打开数据库.");
        return ;
    }
    NSString *sql = [NSString stringWithFormat:@"INSERT INTO TEST (userId , name , sex , age ) VALUES ('%@', '%@', '%@', '%ld')", model.userID, model.name, model.sex, model.age];
    BOOL flag =  [db executeUpdate:sql];
    
    if (flag) {
        NSLog(@"success");
    }else{
        NSLog(@"falied");
    }
    [db close];
}

- (void)deleteDataWithUserId:(NSString*)userID{
    FMDatabase *db= [FMDatabase databaseWithPath:[self dbPath]] ;
    if (![db open]) {
        NSLog(@"删除的时候没有打开数据库.");
        return ;
    }
    
    [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM TEST WHERE userID = '%@' ",userID]];
    [db close];
}

- (NSArray<DBModel *> *)fetchDBModelsWithUserID:(NSString*)userID
{
    FMDatabase *db= [FMDatabase databaseWithPath:[self dbPath]] ;
    if (![db open]) {
        return nil;
    }
    
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM TEST where userId = '%@'",userID];
    NSMutableArray *datas = [NSMutableArray new];
    FMResultSet *rs=[db executeQuery:sql];
    while ([rs next]){
        DBModel *model = [DBModel new];
        model.userID = [[rs stringForColumn:@"userId"] isEqualToString:@"(null)"]?nil:[rs stringForColumn:@"userId"];
        model.name = [[rs stringForColumn:@"name"] isEqualToString:@"(null)"]?nil:[rs stringForColumn:@"name"];
        model.sex = [[rs stringForColumn:@"sex"] isEqualToString:@"(null)"]?nil:[rs stringForColumn:@"sex"];
        model.age = [rs intForColumn:@"age"];
        [datas addObject:model];
        model = nil;
    }
    
    [rs close];
    [db close];
    return datas;
}
- (NSArray<DBModel *> *)fetchDBModelsAll{
    FMDatabase *db= [FMDatabase databaseWithPath:[self dbPath]] ;
    if (![db open]) {
        return nil;
    }
    
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM TEST"];
    NSMutableArray *datas = [NSMutableArray new];
    FMResultSet *rs=[db executeQuery:sql];
    while ([rs next]){
        DBModel *model = [DBModel new];
        model.userID = [[rs stringForColumn:@"userId"] isEqualToString:@"(null)"]?nil:[rs stringForColumn:@"userId"];
        model.name = [[rs stringForColumn:@"name"] isEqualToString:@"(null)"]?nil:[rs stringForColumn:@"name"];
        model.sex = [[rs stringForColumn:@"sex"] isEqualToString:@"(null)"]?nil:[rs stringForColumn:@"sex"];
        model.age = [rs intForColumn:@"age"];
        [datas addObject:model];
        model = nil;
    }
    
    [rs close];
    [db close];
    return datas;
}

- (void)updateDBModelName:(NSString*)name userID:(NSString*)userID{
    FMDatabase *db= [FMDatabase databaseWithPath:[self dbPath]] ;
    if (![db open]) {
        NSLog(@"error");
    }
    
    [db executeUpdate:@"UPDATE TEST SET name = ? WHERE userID = ?;", name, userID];
    [db close];
    
}


@end
