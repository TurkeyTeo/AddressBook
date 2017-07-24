//
//  TTMemberManager.h
//  AddressBook
//
//  Created by Teo on 2017/6/16.
//  Copyright © 2017年 Teo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTMemberManager : NSObject

@property (nonatomic, strong) TTIMMemberModel *loginUser;

/**
 *  @brief  单例
 *
 *  @return TTMemberManager
 */
+ (TTMemberManager *)shareInstance;


/**
 *  @brief  获得登录用户名
 *
 *  @return username
 */
- (NSString *)getLoginUsername;


/**
 *  @brief  设置登录用户名
 *
 */
- (void)setLoginUserName:(NSString *)username;


@end
