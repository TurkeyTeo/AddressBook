//
//  TTContactModel.h
//  AddressBook
//
//  Created by Teo on 2017/6/8.
//  Copyright © 2017年 Teo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTContactModel : NSObject


@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *imageName;

@property (nonatomic, assign)BOOL isTeam;
@property (nonatomic, assign)BOOL isTeamOnwer;
@property (nonatomic, copy) NSString *TEAMCODE;
@property (nonatomic, copy) NSString *PARENTCODE;
@property (nonatomic, copy) NSString *ORGCODE;

@property (nonatomic, assign) BOOL canExpend;
@property (nonatomic, assign) BOOL isExpend;
@property (nonatomic, strong) NSMutableArray *contentArray;

@end
