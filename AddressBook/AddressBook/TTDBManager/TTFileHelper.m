//
//  TTFileHelper.m
//  AddressBook
//
//  Created by Teo on 2017/6/16.
//  Copyright © 2017年 Teo. All rights reserved.
//

#import "TTFileHelper.h"

@implementation TTFileHelper


/**
*  @brief  沙盒路径
*
*  @return 沙盒路径
*/
+(NSString *)documentDirectory
{
    NSString *url = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    url = [url stringByAppendingPathComponent:[NSString stringWithFormat:@"/TL_Contact/%@",[[TTMemberManager shareInstance] getLoginUsername]]];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir = NO;
    
    BOOL existed = [fileManager fileExistsAtPath:url isDirectory:&isDir];
    if ( !(isDir == YES && existed == YES) )
    {
        NSError *error;
        [fileManager createDirectoryAtPath:url withIntermediateDirectories:YES attributes:nil error:&error];
        if (error)
        {
            return nil;
        }
    }
    return url;
}


/**
 *
 *  @brief  文件是否存在
 *
 *  @param fileUrl fileUrl
 *
 *  @return BOOL
 */
+(BOOL)fileIsExist:(NSString *)fileUrl
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isExists = [fileManager fileExistsAtPath:fileUrl];
    if (!isExists)
    {
        [self creatDir:fileUrl];
    }
    return isExists;
}


/**
 *  @Author lpm, 15-11-03 17:11:29
 *
 *  @brief  创建目录
 *
 *  @param dirUrl url
 */
+(BOOL)creatDir:(NSString *)dirUrl
{
    //创建文件夹
    BOOL isDir = NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSMutableArray *arr = [NSMutableArray arrayWithArray:[dirUrl componentsSeparatedByString:@"/"]];
    
    if (arr && arr.count >0)
    {
        [arr removeLastObject];
        NSString *dirUrl = [arr componentsJoinedByString:@"/"];
        BOOL existed = [fileManager fileExistsAtPath:dirUrl isDirectory:&isDir];
        if ( !(isDir == YES && existed == YES) )
        {
            NSError *error;
            [fileManager createDirectoryAtPath:dirUrl withIntermediateDirectories:YES attributes:nil error:&error];
            if (error)
            {
                return NO;
            }
        }
    }
    return YES;
}

@end
