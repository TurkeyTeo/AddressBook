//
//  TTHeadTitleView.h
//  AddressBook
//
//  Created by Teo on 2017/6/14.
//  Copyright © 2017年 Teo. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TitleClickBlock)(NSInteger index);

@interface TTHeadTitleView : UIView


/**
 初始化头部滚动视图

 @param frame frame
 @param dataArray 数据源
 @param tcBlock block
 @return self
 */
- (instancetype)initWithFrame:(CGRect)frame dataArray:(NSArray *)dataArray titleClickBlock:(TitleClickBlock)tcBlock;

@end
