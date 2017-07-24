//
//  TTHeadTableViewCell.m
//  AddressBook
//
//  Created by Teo on 2017/6/23.
//  Copyright © 2017年 Teo. All rights reserved.
//

#import "TTHeadTableViewCell.h"
#import "TTHeadTitleView.h"

@interface TTHeadTableViewCell ()

@property (nonatomic, strong) TTHeadTitleView *headView;
@end

@implementation TTHeadTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}


- (void)setModel:(TTAddressDetailModel *)model{
    _model = model;
    if (!self.headView) {
        self.headView = [[TTHeadTitleView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.height) dataArray:model.dataSource titleClickBlock:^(NSInteger index) {
            
            if ([self.delegate respondsToSelector:@selector(headViewClickWhichIndex:)]) {
                [self.delegate headViewClickWhichIndex:index];
            }
        }];
        [self addSubview:self.headView];
    }
}



@end
