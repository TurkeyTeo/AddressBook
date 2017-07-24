//
//  TTIMMemberModel.h
//  AddressBook
//
//  Created by Teo on 2017/6/15.
//  Copyright © 2017年 Teo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTIMMemberModel : NSObject

@property (nonatomic, copy) NSString *username;         //用户唯一标识
@property (nonatomic, copy) NSString *uid;              //工号
@property (nonatomic, copy) NSString *realName;
@property (nonatomic, copy) NSString *nikeName;
@property (nonatomic, copy) NSString *mobile;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSString *sex;
@property (nonatomic, copy) NSString *pyabbr;           //拼音简写
@property (nonatomic, copy) NSString *pyfull;           //拼音全写
@property (nonatomic, copy) NSString *thumbPic;
@property (nonatomic, copy) NSString *originalPic;
@property (nonatomic, copy) NSString *created_by;
@property (nonatomic, copy) NSString *created_date;
@property (nonatomic, copy) NSString *modified_by;
@property (nonatomic, copy) NSString *modified_date;


@end
