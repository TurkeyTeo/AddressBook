//
//  TTIMTeamModel.h
//  AddressBook
//
//  Created by Teo on 2017/6/19.
//  Copyright © 2017年 Teo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTIMMemberTeamModel : NSObject

@property (nonatomic, copy) NSString *TEAMCODE;
@property (nonatomic, copy) NSString *USERNAME;
@property (nonatomic, copy) NSString *JOBNO;                //工号
@property (nonatomic, assign) BOOL isPRIMARY_TEAM;          //是否主团队
@property (nonatomic, assign) BOOL isPRIMARY_ADMIN;         //是否主管理员
@property (nonatomic, assign) BOOL isASSISTANT_ADMIN;       //是否副管理员
@property (nonatomic, copy) NSString *CREATED_BY;
@property (nonatomic, copy) NSString *CREATED_DATE;
@property (nonatomic, copy) NSString *MODIFIED_BY;
@property (nonatomic, copy) NSString *MODIFIED_DATE;

@property (nonatomic, copy) NSString *TEAMNAME;
@property (nonatomic, copy) NSString *PARENTCODE;
@property (nonatomic, copy) NSString *STATUS;
@property (nonatomic, copy) NSString *DESCRIPTION;
@property (nonatomic, copy) NSString *LOGO;

@end
