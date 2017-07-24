//
//  TTFileHelper.h
//  AddressBook
//
//  Created by Teo on 2017/6/16.
//  Copyright © 2017年 Teo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTFileHelper : NSObject

/**
 *  @brief  沙盒路径
 *
 *  @return 沙盒路径
 */
+(NSString *)documentDirectory;


/**
 *
 *  @brief  文件是否存在
 *
 *  @param fileUrl fileUrl
 *
 *  @return BOOL
 */
+(BOOL)fileIsExist:(NSString *)fileUrl;


/**
 *  @Author lpm, 15-11-03 17:11:29
 *
 *  @brief  创建目录
 *
 *  @param dirUrl url
 */
+(BOOL)creatDir:(NSString *)dirUrl;


@end
