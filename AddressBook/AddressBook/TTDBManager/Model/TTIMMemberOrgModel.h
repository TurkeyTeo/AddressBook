//
//  TTIMMemberTeamOrgModel.h
//  AddressBook
//
//  Created by Teo on 2017/6/21.
//  Copyright © 2017年 Teo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTIMMemberOrgModel : NSObject

@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *USERNAME;
@property (nonatomic, copy) NSString *TEAMCODE;
@property (nonatomic, copy) NSString *ORGCODE;
@property (nonatomic, copy) NSString *CREATED_BY;
@property (nonatomic, copy) NSString *CREATED_DATE;
@property (nonatomic, copy) NSString *MODIFIED_BY;
@property (nonatomic, copy) NSString *MODIFIED_DATE;

@property (nonatomic, copy) NSString *ORGNAME;
@property (nonatomic, copy) NSString *PARENTCODE;

@end
