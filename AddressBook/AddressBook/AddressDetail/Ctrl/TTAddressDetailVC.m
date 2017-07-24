//
//  TTAddressDetailVC.m
//  AddressBook
//
//  Created by Teo on 2017/6/14.
//  Copyright © 2017年 Teo. All rights reserved.
//

#import "TTAddressDetailVC.h"
#import "TTAddressSearchViewController.h"
#import "TTHeadTableViewCell.h"
#import "TTAddressDetailModel.h"

@interface TTAddressDetailVC ()<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource,TTHeadTableViewClickDelegate>

@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation TTAddressDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = self.headTitleArray.lastObject;
    
    [self initSearchController];
    
    [self.tableView setTableFooterView:[UIView new]];
    self.tableView.rowHeight = 50;
 
    self.dataArray = [NSMutableArray array];
    
    [self getTitleData];
    [self getOrgData];
    [self getMemberData];
    [self getInviteColleagueData];
}


/**
 获取title
 */
- (void)getTitleData{
    TTAddressDetailModel *model = [[TTAddressDetailModel alloc] init];
    model.isTitle = YES;
    model.dataSource = self.headTitleArray;
    [self.dataArray addObject:model];
}


//获取机构
- (void)getOrgData{
    TTAddressDetailModel *model = [[TTAddressDetailModel alloc] init];
    model.isOrg = YES;
    
    if (self.isTeam) {
//        团队下所有机构
        model.dataSource = [[TTDBManager shareInstance] queryOrgByTeamCode:self.transModel.TEAMCODE ParentCode:[[TTDBManager shareInstance] queryOrgCodeByTeamCode:self.transModel.TEAMCODE ParentCode:self.transModel.PARENTCODE]];
    }else{
//        子机构下所有机构
        model.dataSource = [[TTDBManager shareInstance] queryOrgByTeamCode:self.transModel.TEAMCODE ParentCode:self.transModel.ORGCODE];
    }
    
    if (model.dataSource.count) {
        [self.dataArray addObject:model];
    }
}


/**
 获取人员数据
 */
- (void)getMemberData{
    TTAddressDetailModel *model = [[TTAddressDetailModel alloc] init];
    model.isMember = YES;
    
    
//    NSLog(@"********** TEAMCODE:%@   ORGCODE:%@   PARENTCODE:%@",self.transModel.TEAMCODE,self.transModel.ORGCODE,self.transModel.PARENTCODE);

    
    if (self.isTeam) {
        //        团队下需先查询orgcode
        model.dataSource = [[TTDBManager shareInstance] queryAllMemberInOrg:[[TTDBManager shareInstance] queryOrgCodeByTeamCode:self.transModel.TEAMCODE ParentCode:self.transModel.PARENTCODE] TeamCode:self.transModel.TEAMCODE];
    }else{
        model.dataSource = [[TTDBManager shareInstance] queryAllMemberInOrg:self.transModel.ORGCODE TeamCode:self.transModel.TEAMCODE];
    }
    
    if (model.dataSource.count) {
        [self.dataArray addObject:model];
    }
}


/**
 邀请同事
 */
- (void)getInviteColleagueData{
    TTAddressDetailModel *model = [[TTAddressDetailModel alloc] init];
    model.icon = @"Cont_new_fd_icon";
    [model.dataSource addObject:@"邀请同事加入"];
    
    [self.dataArray addObject:model];
}


#pragma mark ----- 创建UISearchController ----
- (void)initSearchController{
    //创建UISearchController
    TTAddressSearchViewController *searchDetailVC = [TTAddressSearchViewController new];
    UISearchController *detailSearchVC = [[UISearchController alloc] initWithSearchResultsController:searchDetailVC];
    //设置代理
    //    _searchController.delegate = self;
    //    _searchController.searchResultsUpdater= self;

    UISearchBar *bar = detailSearchVC.searchBar;
    bar.barStyle = UIBarStyleDefault;
    bar.translucent = YES;
    bar.barTintColor = Global_mainBackgroundColor;
    bar.tintColor = Global_tintColor;
    UIImageView *view = [[[bar.subviews objectAtIndex:0] subviews] firstObject];
    view.layer.borderColor = Global_mainBackgroundColor.CGColor;
    view.layer.borderWidth = 1;
    
    bar.delegate = self;
    CGRect rect = bar.frame;
    rect.size.height = 44;
    bar.frame = rect;
    
    self.tableView.tableHeaderView = bar;

}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }else{
        TTAddressDetailModel *model = self.dataArray[section];
        return model.dataSource.count;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TTAddressDetailModel *model = self.dataArray[indexPath.section];
    if (model.isTitle) {
//        头
        TTHeadTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"titleCell"];
        if (!cell) {
            cell = [[TTHeadTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"titleCell"];
            cell.delegate = self;
        }
        cell.model = model;
        return cell;
        
    }else if (model.isOrg){
//        机构
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"orgCell"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"orgCell"];
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        TTIMOrgModel *orgM = model.dataSource[indexPath.row];
        cell.textLabel.text = [NSString stringWithFormat:@"%@(%@)",orgM.ORGNAME,orgM.orgNum];
        return cell;

    }else if (model.isMember){
//        人员
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"memberCell"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"memberCell"];
        }
        TTIMMemberModel *mModel = model.dataSource[indexPath.row];
        cell.imageView.image = [UIImage imageNamed:@"Cont_my_fd_icon1"];
        cell.textLabel.text = [NSString stringWithFormat:@"%@",mModel.realName];
        return cell;

    }else{
//        邀请同事
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"InviteCell"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"InviteCell"];
        }
        cell.imageView.image = [UIImage imageNamed:@"Cont_my_fd_icon1"];
        cell.textLabel.text = [NSString stringWithFormat:@"%@",model.dataSource[0]];
        return cell;
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    CGFloat height = 0;
    /** 第一组的组头高度为0 */
    if (section == 0) {
        height = 0.01;//注意如果设置成0,则还会有默认高度出现
    }else{
        height = 20;
    }
    return height;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    TTAddressDetailModel *model = self.dataArray[indexPath.section];
    if (model.isOrg){
        //        机构
        TTIMOrgModel *orgM = model.dataSource[indexPath.row];
        
        TTContactModel *cModel = [[TTContactModel alloc] init];
        cModel.name = orgM.ORGNAME;
        cModel.TEAMCODE = orgM.TEAMCODE;
        cModel.PARENTCODE = orgM.PARENTCODE;
        cModel.ORGCODE = orgM.ORGCODE;
        
        TTAddressDetailVC *addressDetailVC = [TTAddressDetailVC new];
        
        addressDetailVC.transModel = cModel;
        [self.headTitleArray addObject:cModel.name];
        addressDetailVC.headTitleArray = self.headTitleArray;
        addressDetailVC.isTeam = NO;
        
        [self.navigationController pushViewController:addressDetailVC animated:YES];
        
    }else if (model.isMember){
        //        人员
//        TTIMMemberModel *mModel = model.dataSource[indexPath.row];
        
        
    }else if (model.isTitle){
        //        头

    }else{
        //        邀请同事
//        model.dataSource[0];
    }

}


/**
 点击头部的回调

 @param index index
 */
- (void)headViewClickWhichIndex:(NSInteger)index{
    NSArray *arrController = self.navigationController.viewControllers;
    UIViewController *vC = arrController[index];
    [self.navigationController popToViewController:vC animated:YES];
}

@end
