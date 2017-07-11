//
//  TTDBManager.m
//  AddressBook
//
//  Created by Teo on 2017/6/15.
//  Copyright © 2017年 Teo. All rights reserved.
//

#import "TTDBManager.h"
#import "TTContactDB.h"

@interface TTDBManager ()

//通讯录数据库
@property (nonatomic, strong) TTContactDB *contactDB;
//缓存线程
@property(nonatomic,strong) dispatch_queue_t queue;


@end

@implementation TTDBManager


+(TTDBManager *)shareInstance{
    static TTDBManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
        
    });
    return instance;
}
 

- (instancetype)init{
    self = [super init];
    if (self) {
        self.contactDB = [[TTContactDB alloc] init];
        self.queue = dispatch_queue_create("TTDBManagerQueue", NULL);
    }
    return self;
}



/**
 *
 *  @brief  方法快速转发
 *
 *  @param aSelector aSelector
 *
 *  @return id
 */
-(id)forwardingTargetForSelector:(SEL)aSelector
{
    if ([self respondsToSelector:aSelector])
    {
        return [super forwardingTargetForSelector:aSelector];
    }
    else
    {
        if ([_contactDB respondsToSelector:aSelector]){
            return _contactDB;
        }
    }
    return nil;
}


@end
