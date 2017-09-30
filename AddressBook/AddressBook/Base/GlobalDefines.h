//
//  GlobalDefines.h
//  AddressBook
//
//  Created by Teo on 2017/6/6.
//  Copyright © 2017年 Teo. All rights reserved.
//

#ifndef GlobalDefines_h
#define GlobalDefines_h

#define TTColor(r, g, b, a)  [UIColor colorWithRed:(r / 255.0) green:(g / 255.0) blue:(b / 255.0) alpha:a]

#define Global_tintColor [UIColor colorWithRed:0 green:(190 / 255.0) blue:(12 / 255.0) alpha:1]

#define Global_mainBackgroundColor TTColor(248, 248, 248, 1)

#define TimeLineCellHighlightedColor [UIColor colorWithRed:92/255.0 green:140/255.0 blue:193/255.0 alpha:1.0]


#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)


#define dispatch_im_main_async_safe(block)\
if ([NSThread isMainThread]) {\
block();\
} else {\
dispatch_async(dispatch_get_main_queue(), block);\
}


#ifdef DEBUG
#define DDNSLog(...) NSLog(__VA_ARGS__)
#define debugMethod() NSLog(@"%s", __func__)
#else
#define NSLog(...)
#define debugMethod()
#endif


#import "TTIMMemberModel.h"
#import "TTMemberManager.h"
#import "TTFileHelper.h"
#import "TTDBManager.h"
#import "TTMemberManager.h"
#import "TTIMMemberTeamModel.h"
#import "TTIMMemberOrgModel.h"
#import "TTIMOrgModel.h"

#endif /* GlobalDefines_h */
