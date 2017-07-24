//
//  TTAddressView.m
//  AddressBook
//
//  Created by Teo on 2017/6/7.
//  Copyright © 2017年 Teo. All rights reserved.
//

#import "TTAddressView.h"
#import "TTAddressSearchViewController.h"
#import "TTContactsTableViewCell.h"

@interface TTAddressView ()<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UISearchController *searchController;
@property (strong, nonatomic) TTAddressSearchViewController *addressSearchVC;
@property (strong, nonatomic) UITableView *tableView;


@end

@implementation TTAddressView


#pragma mark ----- 初始化 -----
- (NSMutableArray *)sectionArray{
    if (!_sectionArray) {
        _sectionArray = [NSMutableArray arrayWithCapacity:10];
    }
    return _sectionArray;
}


/**
 初始化
 
 @param frame frame
 @param delegate delegate
 */
-(instancetype)initWithFrame:(CGRect)frame widthDelegate:(id)delegate{
    if (self = [super initWithFrame:frame]) {
        _delegate = delegate;
        //创建tablview
        [self initTableView:frame];
        
        //创建UISearchController
        [self initSearchController];        
    }
    return self;
}


/**
 创建tableview
 */
- (void)initTableView:(CGRect)frame{
    _tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStyleGrouped];
    [_tableView setTableFooterView:[UIView new]];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;

    _tableView.rowHeight = [TTContactsTableViewCell fixedHeight];
    [self addSubview:_tableView];
}


#pragma mark ----- 创建UISearchController ----
- (void)initSearchController{
    //创建UISearchController
    _addressSearchVC = [TTAddressSearchViewController new];
    _searchController = [[UISearchController alloc]initWithSearchResultsController:_addressSearchVC];
    //设置代理
    //    _searchController.delegate = self;
    //    _searchController.searchResultsUpdater= self;
    
    //设置UISearchController的显示属性，以下3个属性默认为YES
    //搜索时，背景变暗色
    _searchController.dimsBackgroundDuringPresentation = YES;
    //搜索时，背景变模糊
    _searchController.obscuresBackgroundDuringPresentation = NO;
    //隐藏导航栏
    _searchController.hidesNavigationBarDuringPresentation = YES;
    _searchController.searchBar.frame = CGRectMake(0, 100, SCREEN_WIDTH, 44);
    
    
    UISearchBar *bar = self.searchController.searchBar;
    bar.barStyle = UIBarStyleDefault;
    bar.translucent = YES;
    bar.barTintColor = Global_mainBackgroundColor;
    bar.tintColor = Global_tintColor;
    UIImageView *view = [[[bar.subviews objectAtIndex:0] subviews] firstObject];
    view.layer.borderColor = Global_mainBackgroundColor.CGColor;
    view.layer.borderWidth = 1;
    
    bar.layer.borderColor = [UIColor redColor].CGColor;
    
    bar.delegate = self;
    CGRect rect = bar.frame;
    rect.size.height = 44;
    bar.frame = rect;
    
    self.tableView.tableHeaderView = bar;
    
}




#pragma mark ---- tableview delegate and datasource ----

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sectionArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    TTContactModel *model = self.sectionArray[section][0];
    if (model.isExpend) {
//        展开时为count+1
        return model.contentArray.count + 1;
    }else{
//        未展开则为数组当前section个数
        return [self.sectionArray[section] count];
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"SDContacts";
    TTContactsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[TTContactsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        
        cell.manageBlock = ^(TTContactModel *model) {
//            点击邀请管理
            if ([self.delegate respondsToSelector:@selector(toManageTeam:)]) {
                [self.delegate toManageTeam:model];
            }
        };
    }
    
    NSUInteger section = indexPath.section;
    NSUInteger row = indexPath.row;
    TTContactModel *model = self.sectionArray[section][0];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    if (model.canExpend) {
//        如果可以展开并且model.contentArray有数据
        if (model.isExpend && model.contentArray != nil) {
            if (row == 0) {
//                当为第一行时是[section][0]数据
                cell.model = model;
            }else{
//                否则是对应model.contentArray-1的TTContactModel
                cell.selectionStyle = UITableViewCellSelectionStyleDefault;
                cell.model = (TTContactModel *)[model.contentArray objectAtIndex:row - 1];
            }
        }else{
//            收起时
            cell.model = model;
        }
        
    }else{
//        不可展开对应的数据显示
        cell.selectionStyle = UITableViewCellSelectionStyleDefault;
        cell.model = self.sectionArray[section][row];
    }
    
    return cell;
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

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TTContactModel *model = self.sectionArray[indexPath.section][0];
    
    if (model.canExpend) {
//如果可展开，并为关闭状态且有子数据则设在展开 isExpend = YES
        if (!model.isExpend && model.contentArray != nil) {
            model.isExpend = YES;
            
            [tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationNone];
            
        }else{
//            否则为打开，点击为收起   当点击第一行时，收起，否则为点击对应的行
            if (indexPath.row == 0) {
                model.isExpend = NO;
                [tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationNone];
                
            }else{
                [tableView deselectRowAtIndexPath:indexPath animated:YES];
                
                TTContactModel *cModel = (TTContactModel *)[model.contentArray objectAtIndex:indexPath.row - 1];

                if (model.isTeam) {
//                    企业团队
                    if ([self.delegate respondsToSelector:@selector(toOrganizationOperation:detailModel:)]) {
                        [self.delegate toOrganizationOperation:model detailModel:cModel];
                    }
                }else{
//                    常用联系人
                    if ([self.delegate respondsToSelector:@selector(toContact:)]) {
                        [self.delegate toContact:cModel];
                    }
                }
            }
        }
        
    }else{
//        不可展开
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        
        if (indexPath.section == 0) {
            //常规项
            if ([self.delegate respondsToSelector:@selector(toNormalOperation:)]) {
                [self.delegate toNormalOperation:model];
            }
        }else{
//            创建团队
            if ([self.delegate respondsToSelector:@selector(toCreateTeam:)]) {
                [self.delegate toCreateTeam:model];
            }
        }
    }
}


/**
 刷新
 
 @param dataSource 数据源
 */
- (void)reloadData:(NSMutableArray *)dataSource{
    if (dataSource) {
        self.sectionArray = dataSource;
        [self.tableView reloadData];
    }
}


@end
