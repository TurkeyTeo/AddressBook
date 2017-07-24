//
//  TTHeadTitleView.m
//  AddressBook
//
//  Created by Teo on 2017/6/14.
//  Copyright © 2017年 Teo. All rights reserved.
//

#import "TTHeadTitleView.h"

@interface TTHeadTitleView ()

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, copy) TitleClickBlock titleClickBlock;

@end

@implementation TTHeadTitleView


/**
 初始化头部滚动视图
 
 @param frame frame
 @param dataArray 数据源
 @param tcBlock block
 @return self
 */
- (instancetype)initWithFrame:(CGRect)frame dataArray:(NSArray *)dataArray titleClickBlock:(TitleClickBlock)tcBlock{
  
    if (self = [super initWithFrame:frame]) {
        _titleClickBlock = tcBlock;
        [self initScrollView:frame dataArray:dataArray];
    }
    return self;
}


- (void)initScrollView:(CGRect)frame dataArray:(NSArray *)dataArray{
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:frame];
    self.scrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:self.scrollView];
    
    CGFloat widthOffset = 0;
    for (NSInteger i = 0; i < dataArray.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = 100 + i;
        [btn addTarget:self action:@selector(titleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitle:[dataArray objectAtIndex:i] forState:UIControlStateNormal];
        
        CGFloat width = [btn.titleLabel.text sizeWithAttributes:@{ NSFontAttributeName: btn.titleLabel.font }].width + 30;
        btn.frame = CGRectMake(widthOffset, 0, width, frame.size.height);
        widthOffset += width;
        
        if (i == dataArray.count - 1) {
            [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        }else{
            [btn setTitleColor:[UIColor colorWithRed:76./255 green:151./255 blue:220./255 alpha:1.] forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:@"im_icon_arrow_right"] forState:UIControlStateNormal];
            
            float imageSize = btn.imageView.frame.size.width;
            float titleSize = btn.titleLabel.frame.size.width;
            float margin = 8;
            btn.imageEdgeInsets = UIEdgeInsetsMake(0, titleSize + margin, 0, -titleSize - margin);
            btn.titleEdgeInsets = UIEdgeInsetsMake( 0, -imageSize, 0, imageSize);
        }
        [self.scrollView addSubview:btn];
    }
    [self.scrollView setContentSize:CGSizeMake(widthOffset, frame.size.height)];
    
    if (widthOffset > SCREEN_WIDTH) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.scrollView scrollRectToVisible:CGRectMake(widthOffset - SCREEN_WIDTH, 0, self.scrollView.width, self.scrollView.height) animated:YES];
        });
    }
}
 

- (void)titleBtnClick:(UIButton *)sender{
    NSInteger i = sender.tag - 100;
    if (_titleClickBlock) {
        _titleClickBlock(i);
    }
}


@end



