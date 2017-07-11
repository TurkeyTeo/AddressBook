//
//  TTBaseDB.m
//  AddressBook
//
//  Created by Teo on 2017/6/15.
//  Copyright © 2017年 Teo. All rights reserved.
//

#import "TTBaseDB.h"
#import "TTDBManager.h"

@implementation TTBaseDB

- (instancetype)init
{
    self = [super init];
    if (self)
    {
//        self.dbQueue = [FMDatabaseQueue databaseQueueWithPath:self.dbPath];
    }
    return self;
}

-(NSString *)dbPath
{
    NSArray *searchPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory , NSUserDomainMask, YES);
    NSString *doc = [searchPaths objectAtIndex:0];
    NSString *dbFilePath = [doc stringByAppendingPathComponent:@"Contact.db"];

    // 复制本地数据到沙盒中
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:dbFilePath]) {
        // 获得数据库文件在工程中的路径——源路径。
        NSString *sourcesPath = [[NSBundle mainBundle] pathForResource:@"Contact"ofType:@"db"];
        
        NSError *error ;
        if ([fileManager copyItemAtPath:sourcesPath toPath:dbFilePath error:&error]) {
            NSLog(@"数据库移动成功");
        } else {
            NSLog(@"数据库移动失败");
        }
    }
    
    return dbFilePath;
}


-(FMDatabaseQueue *)dbQueue
{
    if (!_dbQueue)
    {
        _dbQueue = [FMDatabaseQueue databaseQueueWithPath:self.dbPath];
    }
    return _dbQueue;
}


@end
