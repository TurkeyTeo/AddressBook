//
//  AddressBookViewController.m
//  AddressBook
//
//  Created by Teo on 2017/6/6.
//  Copyright © 2017年 Teo. All rights reserved.
//

#import "TTAddressBookViewController.h"
#import "TTAddressDetailVC.h"
#import "TTAddressView.h"


@interface TTAddressBookViewController ()<TTAddressViewDelegate>

@property (nonatomic, strong) TTAddressView *addressView;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation TTAddressBookViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [[TTMemberManager shareInstance] setLoginUserName:@"1"];
    self.navigationItem.title = @"联系人";
    
    self.addressView = [[TTAddressView alloc] initWithFrame:self.view.bounds widthDelegate:self];
    [self.view addSubview:self.addressView];
    [self contentData];
    
    [self getTeamDBData];
    
}
    


- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray arrayWithCapacity:10];
    }
    return _dataSource;
}

- (void)contentData{
    //    头视图
    NSMutableArray *operrationModels = [NSMutableArray new];
    NSArray *dicts = @[@{@"name" : @"新的朋友", @"imageName" : @"Cont_my_fd_icon1"},
                       @{@"name" : @"群聊", @"imageName" : @"Cont_my_fd_icon1"},
                       @{@"name" : @"标签", @"imageName" : @"Cont_my_fd_icon1"},
                       @{@"name" : @"公众号", @"imageName" : @"Cont_my_fd_icon1"}];
    for (NSDictionary *dict in dicts) {
        TTContactModel *model = [TTContactModel new];
        model.name = dict[@"name"];
        model.imageName = dict[@"imageName"];
        [operrationModels addObject:model];
    }
    [self.dataSource addObject:operrationModels];
    
    //    创建团队
    TTContactModel *model2 = [TTContactModel new];
    model2.name = @"创建团队";
    model2.imageName = @"Cont_new_fd_icon";
    [self.dataSource addObject:@[model2]];
    

    //    常用联系人
    TTContactModel *model3 = [TTContactModel new];
    model3.name = @"常用联系人";
    model3.imageName = @"Cont_my_fd_icon1";
    model3.isExpend = NO;
    model3.canExpend = YES;
    model3.contentArray = [self genDataWithCount:10];
    [self.dataSource addObject:@[model3]];

    [self.addressView reloadData:self.dataSource];
}


/**
 填写联系人
 
 @param count 人数
 @return 人员数组
 */
- (NSMutableArray *)genDataWithCount:(NSInteger)count
{
    NSMutableArray *dataArray = [NSMutableArray arrayWithCapacity:count];
    NSArray *xings = @[@"赵",@"钱",@"孙",@"李",@"周",@"吴",@"郑",@"王",@"冯",@"陈",@"楚",@"卫",@"蒋",@"沈",@"韩",@"杨"];
    NSArray *ming1 = @[@"大",@"美",@"帅",@"应",@"超",@"海",@"江",@"湖",@"春",@"夏",@"秋",@"冬",@"上",@"左",@"有",@"纯"];
    NSArray *ming2 = @[@"强",@"好",@"领",@"亮",@"超",@"华",@"奎",@"海",@"工",@"青",@"红",@"潮",@"兵",@"垂",@"刚",@"山"];
    
    for (int i = 0; i < count; i++) {
        NSString *name = xings[arc4random_uniform((int)xings.count)];
        NSString *ming = ming1[arc4random_uniform((int)ming1.count)];
        name = [name stringByAppendingString:ming];
        if (arc4random_uniform(10) > 3) {
            NSString *ming = ming2[arc4random_uniform((int)ming2.count)];
            name = [name stringByAppendingString:ming];
        }
        TTContactModel *model = [TTContactModel new];
        model.name = name;
        model.imageName = @"Cont_my_fd_icon1";
        [dataArray addObject:model];
    }
    return dataArray;
}


//section=0的相关跳转操作
- (void)toNormalOperation:(TTContactModel *)model{
    
}


//管理团队
- (void)toManageTeam:(TTContactModel *)model{
    
}


//组织架构相关联系人
- (void)toOrganizationOperation:(TTContactModel *)model detailModel:(TTContactModel *)detailModel{
    
    if ([detailModel.name isEqualToString:@"外部联系人"]) {
        
    }else{
        
        TTAddressDetailVC *addressDetailVC = [TTAddressDetailVC new];
        addressDetailVC.transModel = detailModel;
        addressDetailVC.headTitleArray = [NSMutableArray arrayWithObjects:self.navigationItem.title,model.name, nil];
        
        if ([detailModel.name isEqualToString:@"组织架构"]) {
            addressDetailVC.isTeam = YES;
        }else{
            addressDetailVC.isTeam = NO;
        }
        
        addressDetailVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:addressDetailVC animated:YES];
    }
    
}
 

//常用联系人
- (void)toContact:(TTContactModel *)model{
    
}


- (void)toCreateTeam:(TTContactModel *)model{
    
}

/**
 从数据库获取团队数据
 */
- (void)getTeamDBData{

    //     查询当前用户所在的team
    NSMutableArray *teams = [[TTDBManager shareInstance] queryAllTeam:[[TTMemberManager shareInstance] getLoginUsername]];
    [teams enumerateObjectsUsingBlock:^(TTIMMemberTeamModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        TTContactModel *model = [[TTContactModel alloc] init];
        model.name = obj.TEAMNAME;
        model.imageName = obj.LOGO;
        model.isTeamOnwer = obj.isPRIMARY_ADMIN;

        model.isTeam = YES;
        model.canExpend = YES;
        
        TTContactModel *zzModel = [TTContactModel new];
        zzModel.name = @"组织架构";
        zzModel.imageName = @"im_icon_add_member";
        zzModel.PARENTCODE = obj.PARENTCODE;
        zzModel.TEAMCODE = obj.TEAMCODE;
        
        TTContactModel *wbModel = [TTContactModel new];
        wbModel.name = @"外部联系人";
        wbModel.imageName = @"im_icon_add_member";
        
        TTIMMemberOrgModel *orgModel = [[TTDBManager shareInstance] queryOrgByUsername:[[TTMemberManager shareInstance] getLoginUsername] TeamCode:obj.TEAMCODE];
        if (orgModel) {
            TTContactModel *bmModel = [TTContactModel new];
            bmModel.name = orgModel.ORGNAME;
            bmModel.imageName = @"im_icon_add_member";
            bmModel.ORGCODE = orgModel.ORGCODE;
            bmModel.TEAMCODE = orgModel.TEAMCODE;
            bmModel.PARENTCODE = orgModel.PARENTCODE;
            
            model.contentArray = [NSMutableArray arrayWithObjects:zzModel,wbModel,bmModel, nil];
        }else{
            model.contentArray = [NSMutableArray arrayWithObjects:zzModel,wbModel, nil];
        }
        
        [self.dataSource insertObject:@[model] atIndex:1];
    }];
    
    [self.addressView reloadData:self.dataSource];
}


@end
