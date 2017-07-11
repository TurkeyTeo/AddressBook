//
//  TTDBManager.h
//  AddressBook
//
//  Created by Teo on 2017/6/15.
//  Copyright © 2017年 Teo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TTIMDBManagerProtocol.h"
#import "TTIMMemberDBProtocol.h"

@interface TTDBManager : NSObject<TTIMDBManagerProtocol>

+(TTDBManager *)shareInstance;

@end
