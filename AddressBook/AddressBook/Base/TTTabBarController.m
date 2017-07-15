//
//  TTTabBarController.m
//  AddressBook
//
//  Created by Teo on 2017/6/6.
//  Copyright © 2017年 Teo. All rights reserved.
//

#import "TTTabBarController.h"
#import "TTAddressBookViewController.h"
#import "TTNavViewController.h"


#define kClassKey   @"rootVCClassString"
#define kTitleKey   @"title"
#define kImgKey     @"imageName"
#define kSelImgKey  @"selectedImageName"

@interface TTTabBarController ()

@end

@implementation TTTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSArray *childItemsArray = @[
                                 @{kClassKey  : @"SDContactsTableViewController",
                                   kTitleKey  : @"通讯录",
                                   kImgKey    : @"tabbar_contacts",
                                   kSelImgKey : @"tabbar_contactsHL"}
                                 ];
    
    [childItemsArray enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL * _Nonnull stop) {
        TTAddressBookViewController *abVC = [TTAddressBookViewController new];
        TTNavViewController *nav = [[TTNavViewController alloc] initWithRootViewController:abVC];
        UITabBarItem *item = nav.tabBarItem;
        item.title = dict[kTitleKey];
//        item.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
        item.image = [UIImage imageNamed:dict[kImgKey]];
        item.selectedImage = [[UIImage imageNamed:dict[kSelImgKey]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [item setTitleTextAttributes:@{NSForegroundColorAttributeName : Global_tintColor} forState:UIControlStateSelected];
        [self addChildViewController:nav];
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
