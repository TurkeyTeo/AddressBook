//
//  TTMemberManager.m
//  AddressBook
//
//  Created by Teo on 2017/6/16.
//  Copyright © 2017年 Teo. All rights reserved.
//

#import "TTMemberManager.h"

@implementation TTMemberManager
{
    dispatch_queue_t userQueue;
    NSString *userName;
}

/**
 *  @brief  单例
 *
 *  @return TTMemberManager
 */
+(TTMemberManager *)shareInstance{
    static TTMemberManager *shareInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[self alloc] init];
    });
    return shareInstance;
}


- (instancetype)init{
    self = [super init];
    if (self) {
        userQueue = dispatch_queue_create("TTMemberManagerQueue", nil);
        //初始化Url缓存
        [self initUrlCache];
    }
    return self;
}


/**
 *  @Author lpm, 15-12-17 11:12:25
 *
 *  @brief  初始url缓存
 */
-(void)initUrlCache
{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        /**
         *底下的这些是用于请求保持会话的，不写的话会导致请求接口报未登录
         **/
        NSHTTPCookieStorage* cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
        
        [cookieStorage setCookieAcceptPolicy:NSHTTPCookieAcceptPolicyAlways];
        
        int cacheSizeMemory = 8 * 1024 * 1024; // 8MB
        int cacheSizeDisk = 32 * 1024 * 1024; // 32MB
        
        NSURLCache* sharedCache = [[NSURLCache alloc]
                                   initWithMemoryCapacity:
                                   cacheSizeMemory
                                   diskCapacity:cacheSizeDisk
                                   diskPath:@"TTURLCACHE"];
        [NSURLCache setSharedURLCache:sharedCache];
    });
}


/**
 *  @brief  获得登录用户名
 *
 *  @return username
 */
- (NSString *)getLoginUsername{
    return userName;
}


/**
 *  @Author lpm, 16-03-02 15:03:58
 *
 *  @brief  设置登录用户名
 */
- (void)setLoginUserName:(NSString *)username
{
    userName = username;
}

 


@end
