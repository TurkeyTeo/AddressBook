//
//  TTContactDB.m
//  AddressBook
//
//  Created by Teo on 2017/6/16.
//  Copyright © 2017年 Teo. All rights reserved.
//

#import "TTContactDB.h"


@implementation TTContactDB

#pragma mark ------------------------ member --------------------------
/**
 缓存一个用户
 
 @param member TTIMMemberModel
 */
- (void)insertMember:(TTIMMemberModel *)member{
    [self replaceMember:member];
}


- (void)replaceMember:(TTIMMemberModel *)member{
    
    NSString *sql = [NSString stringWithFormat:@"replace into t_im_member(USERNAME,UID,REALNAME,NIKENAME,MOBILE,address,EMAIL,SEX,PYABBR,PYFULL,THUMBPIC,ORIGINALPIC,created_by,created_date,modified_by,modified_date)values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)"];
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        
        BOOL res = [db executeUpdate:sql,   member.username,
                                            member.uid,
                                            member.realName,
                                            member.nikeName,
                                            member.mobile,
                                            member.address,
                                            member.email,
                                            member.sex,
                                            member.pyabbr,
                                            member.pyfull,
                                            member.thumbPic,
                                            member.originalPic,
                                            member.created_by,
                                            member.created_date,
                                            member.modified_by,
                                            member.modified_date];
        if (res) {
            NSLog(@"*** 插入或更新失败 ***");
        }
    }];
}


/**
 *  @Author Teo
 *
 *  @brief  缓存多个用户会话
 */
- (void)insertMembers:(NSMutableArray *)members {
    
    [self.dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        [members enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            TTIMMemberModel *member = (TTIMMemberModel *)obj;
            [self replaceMember:member];
        }];
    }];
}


/**
 *  @Author Teo
 *
 *  @brief  删除一个用户
 *
 *  @param member member
 */
- (void)removeMember:(TTIMMemberModel *)member{
    
    NSString *sql = [NSString stringWithFormat:@"delete from t_im_member where USERNAME = ?"];
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        BOOL res = [db executeUpdate:sql,member.username];
        if (!res) {
            NSLog(@"删除用户失败");
        }
    }];
}


/**
 *  @Author Teo
 *
 *  @brief  更新一条用户数据
 *
 *  @param member member
 */
- (void)updateMember:(TTIMMemberModel *)member{
    [self replaceMember:member];
}


/**
 *  @Author Teo
 
 *
 *  @brief  更新多条用户数据
 *
 *  @param members members
 */
- (void)updateMembers:(NSMutableArray *)members{
    [self.dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        [members enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            TTIMMemberModel *member = (TTIMMemberModel *)obj;
            [self replaceMember:member];
        }];
    }];
}


/**
 根据username查询用户
 
 @param username 用户唯一标识
 */
- (TTIMMemberModel *)queryMemberByUsername:(NSString *)username{
    NSString *sql = [NSString stringWithFormat:@"select * from t_im_member where USERNAME = ?"];
    __block TTIMMemberModel *member;
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        FMResultSet *set = [db executeQuery:sql,username];
        while ([set next])
        {
            member = [self parseMemberResult:set];
        }
        [set close];
    }];
    return member;
}


/**
 查询所有用户
 
 */
- (NSMutableArray *)queryAllMember{
    NSString *sql = [NSString stringWithFormat:@"select * from t_im_member"];
    __block NSMutableArray *arr = [NSMutableArray arrayWithCapacity:10];
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        FMResultSet *set = [db executeQuery:sql];
        while ([set next])
        {
            TTIMMemberModel *member = [self parseMemberResult:set];
            [arr addObject:member];
        }
        [set close];
    }];
    return arr;
}


/**
 查询org下所有人员
 
 @param orgCode orgCode
 @param teamCode teamCode
 @return TTIMMemberModel数组
 */
- (NSMutableArray *)queryAllMemberInOrg:(NSString *)orgCode TeamCode:(NSString *)teamCode{
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM t_im_member WHERE t_im_member.USERNAME in (SELECT USERNAME FROM t_im_member_org WHERE t_im_member_org.ORGCODE = ? And TEAMCODE = ?)"];
    __block NSMutableArray *arr = [NSMutableArray arrayWithCapacity:10];
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        FMResultSet *set = [db executeQuery:sql,orgCode,teamCode];
        while ([set next])
        {
            TTIMMemberModel *member = [self parseMemberResult:set];
            [arr addObject:member];
        }
        [set close];
    }];
    return arr;
}


#pragma mark -------------------------- team ----------------------------

/**
 查询当前用户所在的team
 
 @return TTIMMemberTeamOrgModel
 */
- (NSMutableArray *)queryAllTeam:(NSString *)username{
    
    NSString *sql = [NSString stringWithFormat:@"select * from t_im_member_team where USERNAME = ?"];
    __block NSMutableArray *teams = [NSMutableArray array];
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        FMResultSet *set = [db executeQuery:sql,username];
        while ([set next])
        {
            TTIMMemberTeamModel *team = [self parseTeamResult:set Fmdb:db];
            [teams addObject:team];
        }
        [set close];
    }];
    return teams;
}


/**
 根据团队编号查询团队详情
 
 @param teamCode 团队编号
 @return TTIMTeamModel
 */
- (TTIMMemberTeamModel *)queryTeamByTeamCode:(NSString *)teamCode Database:(FMDatabase *)db{
    
    TTIMMemberTeamModel *model = [[TTIMMemberTeamModel alloc] init];
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM t_im_team WHERE TEAMCODE = ?"];
    FMResultSet *set = [db executeQuery:sql,teamCode];
    while ([set next]) {
        model.TEAMNAME = [set stringForColumn:@"TEAMNAME"];
        model.PARENTCODE = [set stringForColumn:@"PARENTCODE"];
        model.STATUS = [set stringForColumn:@"STATUS"];
        model.DESCRIPTION = [set stringForColumn:@"DESCRIPTION"];
        model.LOGO = [set stringForColumn:@"LOGO"];
    }
    
    return model;
}


#pragma mark ---------------------------- Org ------------------------------

/**
 根据用户编号和团队编号查询机构
 
 @param username 用户编号
 @param teamCode 团队编号
 @return TTIMMemberTeamOrgModel
 */
- (TTIMMemberOrgModel *)queryOrgByUsername:(NSString *)username TeamCode:(NSString *)teamCode{
    
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM t_im_member_org WHERE USERNAME = ? AND TEAMCODE = ?"];
    __block TTIMMemberOrgModel *model;
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        FMResultSet *set = [db executeQuery:sql,username,teamCode];
        while ([set next]) {
            model = [self parseMemberTeamOrgResult:set DB:db];
        }
        [set close];
    }];
    return model;
}


/**
 查询团队下所有机构
 
 @param teamCode teamCode
 @param parentCode parentCode
 @return TTIMOrgModel模型数组
 */
- (NSMutableArray *)queryOrgByTeamCode:(NSString *)teamCode ParentCode:(NSString *)parentCode{
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM t_im_org WHERE TEAMCODE = ? AND PARENTCODE = ?"];
    __block NSMutableArray *array = [NSMutableArray array];
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        FMResultSet *set = [db executeQuery:sql,teamCode,parentCode];
        while ([set next]) {
            [array addObject:[self parseOrgResult:set Database:db]];
        }
        [set close];
    }];
    return array;
}


/**
 查询机构下所有机构
 
 @param orgCode orgCode
 @param parentCode parentCode
 @return org模型数组
 */
- (NSMutableArray *)queryOrgByOrgCode:(NSString *)orgCode ParentCode:(NSString *)parentCode{
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM t_im_org WHERE ORGCODE = ? AND PARENTCODE = ?"];
    __block NSMutableArray *array = [NSMutableArray array];
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        FMResultSet *set = [db executeQuery:sql,orgCode,parentCode];
        while ([set next]) {
            [array addObject:[self parseOrgResult:set Database:db]];
        }
        [set close];
    }];
    return array;
}


/**
 根据orgcode查询机构下人数
 
 @param orgCode orgcode
 @return 人数
 */
- (NSString *)queryOrgNumberbyOrgCode:(NSString *)orgCode Database:(FMDatabase *)db{
    NSString *sql = [NSString stringWithFormat:@"SELECT count(*) FROM t_im_member_org WHERE ORGCODE = ?"];
    NSString *str;
    FMResultSet *set = [db executeQuery:sql,orgCode];
    while ([set next]) {
        str = [set stringForColumn:@"count(*)"];
    }
    
    return str;
}



/**
 根据团队编号查询团队详情
 
 @param orgCode 机构编号
 @return TTIMMemberOrgModel
 */
- (TTIMMemberOrgModel *)queryOrgByOrgCode:(NSString *)orgCode Database:(FMDatabase *)db{
    
    TTIMMemberOrgModel *model = [[TTIMMemberOrgModel alloc] init];
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM t_im_org WHERE ORGCODE = ?"];
    FMResultSet *set = [db executeQuery:sql,orgCode];
    while ([set next]) {
        model.ORGNAME = [set stringForColumn:@"ORGNAME"];
        model.PARENTCODE = [set stringForColumn:@"PARENTCODE"];
    }
    return model;
}


/**
 根据teamCode查询orgcode
 
 @param teamCode teamCode
 @param parentCode parentCode
 @return orgcode
 */
- (NSString *)queryOrgCodeByTeamCode:(NSString *)teamCode ParentCode:(NSString *)parentCode{
    NSString *sql = [NSString stringWithFormat:@"SELECT ORGCODE FROM t_im_org WHERE TEAMCODE = ? AND PARENTCODE = ?"];
    __block NSString *str = @"";
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        FMResultSet *set = [db executeQuery:sql,teamCode,parentCode];
        while ([set next]) {
            str = [set stringForColumn:@"ORGCODE"];
        }
        [set close];
    }];
    return str;
}


#pragma mark ------------------------ 数据模型解析 --------------------------

#pragma mark -----------------  解析t_im_org
/**
 解析t_im_org
 
 @param set FMResultSet
 @return TTIMOrgModel
 */
- (TTIMOrgModel *)parseOrgResult:(FMResultSet *)set{
    TTIMOrgModel *model = [[TTIMOrgModel alloc] init];
    model.ORGCODE = [set stringForColumn:@"ORGCODE"];
    model.ORGNAME = [set stringForColumn:@"ORGNAME"];
    model.TEAMCODE = [set stringForColumn:@"TEAMCODE"];
    model.PARENTCODE = [set stringForColumn:@"PARENTCODE"];
    model.CREATED_BY = [set stringForColumn:@"CREATED_BY"];
    model.CREATED_DATE = [set stringForColumn:@"CREATED_DATE"];
    model.MODIFIED_BY = [set stringForColumn:@"MODIFIED_BY"];
    model.MODIFIED_DATE = [set stringForColumn:@"MODIFIED_DATE"];
//    model.orgNum = [self queryOrgNumberbyOrgCode:model.ORGCODE];
    return model;
}


- (TTIMOrgModel *)parseOrgResult:(FMResultSet *)set Database:(FMDatabase *)db{
    TTIMOrgModel *model = [[TTIMOrgModel alloc] init];
    model.ORGCODE = [set stringForColumn:@"ORGCODE"];
    model.ORGNAME = [set stringForColumn:@"ORGNAME"];
    model.TEAMCODE = [set stringForColumn:@"TEAMCODE"];
    model.PARENTCODE = [set stringForColumn:@"PARENTCODE"];
    model.CREATED_BY = [set stringForColumn:@"CREATED_BY"];
    model.CREATED_DATE = [set stringForColumn:@"CREATED_DATE"];
    model.MODIFIED_BY = [set stringForColumn:@"MODIFIED_BY"];
    model.MODIFIED_DATE = [set stringForColumn:@"MODIFIED_DATE"];
    model.orgNum = [self queryOrgNumberbyOrgCode:model.ORGCODE Database:db];
    return model;
}


#pragma mark -----------------  解析t_im_member
/**
 解析t_im_member
 
 @param set FMResultSet
 @return TTIMMemberModel
 */
- (TTIMMemberModel *)parseMemberResult:(FMResultSet *)set{
    TTIMMemberModel *member = [[TTIMMemberModel alloc] init];
    member.username = [set stringForColumn:@"USERNAME"];
    member.uid = [set stringForColumn:@"UID"];
    member.realName = [set stringForColumn:@"REALNAME"];
    member.nikeName = [set stringForColumn:@"NIKENAME"];
    member.mobile = [set stringForColumn:@"MOBILE"];
    member.address = [set stringForColumn:@"address"];
    member.email = [set stringForColumn:@"EMAIL"];
    member.sex = [set stringForColumn:@"SEX"];
    member.pyabbr = [set stringForColumn:@"PYABBR"];
    member.pyfull = [set stringForColumn:@"PYFULL"];
    member.thumbPic = [set stringForColumn:@"THUMBPIC"];
    member.originalPic = [set stringForColumn:@"ORIGINALPIC"];
    member.created_by = [set stringForColumn:@"created_by"];
    member.created_date = [set stringForColumn:@"created_date"];
    member.modified_by = [set stringForColumn:@"modified_by"];
    member.modified_date = [set stringForColumn:@"modified_date"];
    return member;
}


#pragma mark -----------------  解析t_member_team
/**
 解析t_im_team
 
 @param set FMResultSet
 @return TTIMTeamModel
 */
- (TTIMMemberTeamModel *)parseTeamResult:(FMResultSet *)set Fmdb:(FMDatabase *)db{
    TTIMMemberTeamModel *team = [[TTIMMemberTeamModel alloc] init];
    team.TEAMCODE = [set stringForColumn:@"TEAMCODE"];
    team.USERNAME = [set stringForColumn:@"USERNAME"];
    team.JOBNO = [set stringForColumn:@"JOBNO"];
    team.isPRIMARY_TEAM = [[set stringForColumn:@"PRIMARY_TEAM"] boolValue];
    team.isPRIMARY_ADMIN = [[set stringForColumn:@"PRIMARY_ADMIN"] boolValue];
    team.isASSISTANT_ADMIN = [[set stringForColumn:@"ASSISTANT_ADMIN"] boolValue];
    team.CREATED_BY = [set stringForColumn:@"CREATED_BY"];
    team.CREATED_DATE = [set stringForColumn:@"CREATED_DATE"];
    team.MODIFIED_BY = [set stringForColumn:@"MODIFIED_BY"];
    team.MODIFIED_DATE = [set stringForColumn:@"MODIFIED_DATE"];
    
    TTIMMemberTeamModel *detailTeamM = [self queryTeamByTeamCode:team.TEAMCODE Database:db];
    if (detailTeamM) {
        team.TEAMNAME = detailTeamM.TEAMNAME;
        team.PARENTCODE = detailTeamM.PARENTCODE;
        team.STATUS = detailTeamM.STATUS;
        team.DESCRIPTION = detailTeamM.DESCRIPTION;
        team.LOGO = detailTeamM.LOGO;
    }
    
    return team;
}


#pragma mark -----------------  解析t_im_member_org
/**
 数据库数据解析TTIMMemberTeamOrgModel
 
 @param set FMResultSet
 @return TTIMMemberTeamOrgModel
 */
- (TTIMMemberOrgModel *)parseMemberTeamOrgResult:(FMResultSet *)set DB:(FMDatabase *)db{
    TTIMMemberOrgModel *model = [[TTIMMemberOrgModel alloc] init];
    model.ID = [set stringForColumn:@"ID"];
    model.USERNAME = [set stringForColumn:@"USERNAME"];
    model.TEAMCODE = [set stringForColumn:@"TEAMCODE"];
    model.ORGCODE = [set stringForColumn:@"ORGCODE"];
    model.CREATED_BY = [set stringForColumn:@"CREATED_BY"];
    model.CREATED_DATE = [set stringForColumn:@"CREATED_DATE"];
    model.MODIFIED_BY = [set stringForColumn:@"MODIFIED_BY"];
    model.MODIFIED_DATE = [set stringForColumn:@"MODIFIED_DATE"];
    
    TTIMMemberOrgModel *mOrgM = [self queryOrgByOrgCode:model.ORGCODE Database:db];
    if (mOrgM) {
        model.ORGNAME = mOrgM.ORGNAME;
        model.PARENTCODE = mOrgM.PARENTCODE;
    }
    
    return model;
}




@end
