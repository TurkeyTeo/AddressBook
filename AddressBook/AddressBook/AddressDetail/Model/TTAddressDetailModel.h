//
//  TTAddressDetailModel.h
//  AddressBook
//
//  Created by Teo on 2017/6/23.
//  Copyright © 2017年 Teo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTAddressDetailModel : NSObject

@property (nonatomic, assign) BOOL isTitle;
@property (nonatomic, assign) BOOL isOrg;
@property (nonatomic, assign) BOOL isMember;
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, strong) NSMutableArray *dataSource;   //模型数组


@end
