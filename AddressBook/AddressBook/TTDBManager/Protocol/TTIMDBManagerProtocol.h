//
//  TTIMDBManagerProtocol.h
//  AddressBook
//
//  Created by Teo on 2017/6/16.
//  Copyright © 2017年 Teo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TTIMMemberDBProtocol.h"
#import "TTIMTeamDBProtocol.h"
#import "TTIMOrgDBProtocol.h"

@protocol TTIMDBManagerProtocol <NSObject,TTIMMemberDBProtocol,TTIMTeamDBProtocol,TTIMOrgDBProtocol>

@end
