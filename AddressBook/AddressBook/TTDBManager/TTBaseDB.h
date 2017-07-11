//
//  TTBaseDB.h
//  AddressBook
//
//  Created by Teo on 2017/6/15.
//  Copyright © 2017年 Teo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"

@interface TTBaseDB : NSObject

@property(nonatomic,copy) NSString *dbPath;//数据库路径
@property(nonatomic,strong) FMDatabaseQueue *dbQueue;

@end
