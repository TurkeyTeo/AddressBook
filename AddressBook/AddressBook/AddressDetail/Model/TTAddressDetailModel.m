//
//  TTAddressDetailModel.m
//  AddressBook
//
//  Created by Teo on 2017/6/23.
//  Copyright © 2017年 Teo. All rights reserved.
//

#import "TTAddressDetailModel.h"

@implementation TTAddressDetailModel

- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

@end
