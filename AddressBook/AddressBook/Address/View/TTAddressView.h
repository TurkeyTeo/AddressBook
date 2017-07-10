//
//  TTAddressView.h
//  AddressBook
//
//  Created by Teo on 2017/6/7.
//  Copyright © 2017年 Teo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTContactModel.h"

@protocol TTAddressViewDelegate <NSObject>

- (void)toNormalOperation:(TTContactModel *)model;              //section=0的相关跳转操作
- (void)toManageTeam:(TTContactModel *)model;                   //管理团队(或邀请)
- (void)toOrganizationOperation:(TTContactModel *)model detailModel:(TTContactModel *)detailModel;                                              //组织架构相关联系人等相关操作
- (void)toCreateTeam:(TTContactModel *)model;                   //创建团队
- (void)toContact:(TTContactModel *)model;                      //常用联系人

@end


@interface TTAddressView : UIView

@property (nonatomic, strong) NSMutableArray *sectionArray;      //数据源
@property (nonatomic, weak) id<TTAddressViewDelegate> delegate;

/**
 初始化

 @param frame frame
 @param delegate delegate
 */
-(instancetype)initWithFrame:(CGRect)frame widthDelegate:(id)delegate;


/**
 刷新

 @param dataSource 数据源
 */
- (void)reloadData:(NSMutableArray *)dataSource;

@end



