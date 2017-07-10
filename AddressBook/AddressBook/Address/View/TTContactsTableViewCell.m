//
//  TTContactsTableViewCell.m
//  AddressBook
//
//  Created by Teo on 2017/6/8.
//  Copyright © 2017年 Teo. All rights reserved.
//

#import "TTContactsTableViewCell.h"

@implementation TTContactsTableViewCell
{
    UIImageView *_iconImageView;
    UILabel *_nameLabel;
    UIButton *_manageBtn;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupView];
    }
    return self;
}


- (void)setupView
{
    _iconImageView = [UIImageView new];
    [self.contentView addSubview:_iconImageView];
    
    _nameLabel = [UILabel new];
    _nameLabel.textColor = [UIColor darkGrayColor];
    _nameLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:_nameLabel];
    
    _manageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_manageBtn setTitleColor:[UIColor colorWithRed:76./255 green:151./255 blue:220./255 alpha:1.] forState:UIControlStateNormal];
    _manageBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    _manageBtn.hidden = YES;
    [self.contentView addSubview:_manageBtn];
    
    [_manageBtn addTarget:self action:@selector(managedBtnClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)managedBtnClick{
    if (_manageBlock) {
        _manageBlock(self.model);
    }
}


- (void)setModel:(TTContactModel *)model
{
    _model = model;
    
    _nameLabel.text = [NSString stringWithFormat:@"%@",model.name];
    _iconImageView.image = [UIImage imageNamed:model.imageName];
    
    if (model.isTeam) {
        _manageBtn.hidden = NO;
        if (model.isTeamOnwer) {
            [_manageBtn setTitle:@"管理" forState:UIControlStateNormal];
            [_manageBtn setImage:[UIImage imageNamed:@"im_btn_addToContact"] forState:UIControlStateNormal];
        }else{
            [_manageBtn setTitle:@"邀请" forState:UIControlStateNormal];
            [_manageBtn setImage:[UIImage imageNamed:@"im_btn_contact_call"] forState:UIControlStateNormal];
        }
        
        _manageBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -4, 0, 4);
        
    }else{
        _manageBtn.hidden = YES;
    }
    
}


+ (CGFloat)fixedHeight
{
    return 50;
}


- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat margin = 8;
    _iconImageView.frame = CGRectMake(margin, (self.contentView.height - 34)/2, 34, 34);
    _nameLabel.frame = CGRectMake(_iconImageView.right + margin, _iconImageView.top, self.contentView.width - _iconImageView.left, 30);
    _manageBtn.frame = CGRectMake(SCREEN_WIDTH - 70, _iconImageView.top, 60, _iconImageView.width);
}


@end
