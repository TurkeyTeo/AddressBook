//
//  TTContactsTableViewCell.h
//  AddressBook
//
//  Created by Teo on 2017/6/8.
//  Copyright © 2017年 Teo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTContactModel.h"

typedef void(^ManageBtnClickBlock)(TTContactModel *model);

@interface TTContactsTableViewCell : UITableViewCell

@property (nonatomic, strong) TTContactModel *model;
@property (nonatomic, strong) ManageBtnClickBlock manageBlock;

+ (CGFloat)fixedHeight;

@end
