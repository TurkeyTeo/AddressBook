//
//  TTIMMemberDBProtocol.h
//  AddressBook
//
//  Created by Teo on 2017/6/15.
//  Copyright © 2017年 Teo. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TTIMMemberDBProtocol <NSObject>

@optional
/**
 缓存一个用户

 @param member TTIMMemberModel
 */
- (void)insertMember:(TTIMMemberModel *)member;


/**
 *  @Author Teo
 *
 *  @brief  缓存多个用户会话
 */
- (void)insertMembers:(NSMutableArray *)members;


/**
 *  @Author Teo
 *
 *  @brief  缓存多个用户会话
 @param callBack callBack
 */
- (void)insertMembers:(NSMutableArray *)members callBack:(void(^)(NSMutableArray *array))callBack;


/**
 *  @Author Teo
 *
 *  @brief  删除一个用户
 *
 *  @param member member
 */
- (void)removeMember:(TTIMMemberModel *)member;


/**
 *  @Author Teo
 *
 *  @brief  更新一条用户数据
 *
 *  @param member member
 */
- (void)updateMember:(TTIMMemberModel *)member;


/**
 *  @Author Teo
 
 *
 *  @brief  更新多条用户数据
 *
 *  @param members members
 */
- (void)updateMembers:(NSMutableArray *)members;


/**
 根据username查询用户

 @param username 用户唯一标识
 */
- (TTIMMemberModel *)queryMemberByUsername:(NSString *)username;


/**
 查询所有用户
 
 */
- (NSMutableArray *)queryAllMember;



/**
 查询org下所有人员
 
 @param orgCode orgCode
 @param teamCode teamCode
 @return TTIMMemberModel数组
 */
- (NSMutableArray *)queryAllMemberInOrg:(NSString *)orgCode TeamCode:(NSString *)teamCode;


@end

