//
//  TTHeadTableViewCell.h
//  AddressBook
//
//  Created by Teo on 2017/6/23.
//  Copyright © 2017年 Teo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTAddressDetailModel.h"

@protocol TTHeadTableViewClickDelegate <NSObject>

- (void)headViewClickWhichIndex:(NSInteger)index;

@end

@interface TTHeadTableViewCell : UITableViewCell

@property (nonatomic, weak) id<TTHeadTableViewClickDelegate> delegate;
@property (nonatomic, strong) TTAddressDetailModel *model;

@end
