//
//  TTAddressDetailVC.h
//  AddressBook
//
//  Created by Teo on 2017/6/14.
//  Copyright © 2017年 Teo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTContactModel.h"


@interface TTAddressDetailVC : UITableViewController

@property (nonatomic, strong) TTContactModel *transModel;
@property (nonatomic, strong) NSMutableArray *headTitleArray;
@property (nonatomic, assign) BOOL isTeam;              //是team或者org

@end
