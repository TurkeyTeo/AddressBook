//
//  TTIMTeamDBProtocol.h
//  AddressBook
//
//  Created by Teo on 2017/6/19.
//  Copyright © 2017年 Teo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TTIMMemberOrgModel.h"
#import "TTIMMemberTeamModel.h"

@protocol TTIMTeamDBProtocol <NSObject>

@optional

/**
 查询当前用户所在的team

 @return TTIMMemberTeamOrgModel
 */
- (NSMutableArray *)queryAllTeam:(NSString *)username;



@end
