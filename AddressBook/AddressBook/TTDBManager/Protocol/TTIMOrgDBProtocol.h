//
//  TTIMOrgDBProtocol.h
//  AddressBook
//
//  Created by Teo on 2017/6/23.
//  Copyright © 2017年 Teo. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TTIMOrgDBProtocol <NSObject>

@optional

/**
 查询团队下所有机构

 @param teamCode teamCode
 @param parentCode parentCode
 @return TTIMOrgModel模型数组
 */
- (NSMutableArray *)queryOrgByTeamCode:(NSString *)teamCode ParentCode:(NSString *)parentCode;


/**
 查询机构下所有机构
 
 @param orgCode orgCode
 @param parentCode parentCode
 @return org模型数组
 */
- (NSMutableArray *)queryOrgByOrgCode:(NSString *)orgCode ParentCode:(NSString *)parentCode;


/**
 根据用户编号和团队编号查询机构
 
 @param username 用户编号
 @param teamCode 团队编号
 @return TTIMMemberTeamOrgModel
 */
- (TTIMMemberOrgModel *)queryOrgByUsername:(NSString *)username TeamCode:(NSString *)teamCode;



/**
 根据teamCode查询orgcode

 @param teamCode teamCode
 @param parentCode parentCode
 @return orgcode
 */
- (NSString *)queryOrgCodeByTeamCode:(NSString *)teamCode ParentCode:(NSString *)parentCode;

@end
