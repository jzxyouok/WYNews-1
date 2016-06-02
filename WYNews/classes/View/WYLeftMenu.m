 //
//  WYLeftMenu.m
//  WYNews
//
//  Created by dabbyGHF on 16/6/1.
//  Copyright © 2016年 dabbyGHF. All rights reserved.
//

#import "WYLeftMenu.h"
#import "UIImage+color.h"
#import "WYLeftMenuButton.h"
@interface WYLeftMenu()
@property (nonatomic, weak) WYLeftMenuButton *selectedButton;
@end

@implementation WYLeftMenu

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        
        // 透明度
        CGFloat alpha = 0.2;
        
        WYLeftMenuButton *newsButton = [self setupBtnWithIcon:@"sidebar_nav_news" titile:@"新闻" bgColor:WYColorRGBA(202, 68, 73, alpha)];
        [self btnClick:newsButton];
        [self setupBtnWithIcon:@"sidebar_nav_reading" titile:@"订阅" bgColor:WYColorRGBA(190, 111, 69, alpha)];
        [self setupBtnWithIcon:@"sidebar_nav_photo" titile:@"图片" bgColor:WYColorRGBA(76, 132, 190, alpha)];
        [self setupBtnWithIcon:@"sidebar_nav_video" titile:@"视频" bgColor:WYColorRGBA(101, 170, 78, alpha)];
        [self setupBtnWithIcon:@"sidebar_nav_comment" titile:@"跟帖" bgColor:WYColorRGBA(170, 172, 73, alpha)];
        [self setupBtnWithIcon:@"sidebar_nav_radio" titile:@"电台" bgColor:WYColorRGBA(190, 62, 119, alpha)];
        
    }
    return self;
}

-(void)setDelegate:(id<WYLeftMenuDelegate>)delegate
{
    _delegate = delegate;
    
    // 默认选中新闻按钮
    [self btnClick:[self.subviews firstObject]];
}

/**
 *  添加按钮
 *
 *  @param icon  图表
 *  @param title 文字
 *
 *  @return 创建好的按钮
 */
-(WYLeftMenuButton *)setupBtnWithIcon:(NSString *)icon titile:(NSString *)title bgColor:(UIColor *)bgColor
{
    WYLeftMenuButton *btn = [[WYLeftMenuButton alloc]init];
    
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown ];
    
    [btn setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:17];
    
    
    // 设置按钮高亮的时候不让图标变色
    btn.adjustsImageWhenHighlighted = NO;
    
    // 设置间距
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    
    // 设置按钮的内容左对齐
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    // 设置所有内容右移
    btn.contentEdgeInsets = UIEdgeInsetsMake(0, 30, 0, 0);
    
    // 设置按钮选中背景
    [btn setBackgroundImage:[UIImage imageWithColor:bgColor] forState:UIControlStateSelected];
    
    [self addSubview:btn];
    
    return btn;
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    
    int btnCount = (int)self.subviews.count;
    
    CGFloat btnW = self.width;
    CGFloat btnH = self.height / btnCount;
    
    for (int i = 0; i < btnCount; i++) {
        WYLeftMenuButton *btn = self.subviews[i];
        btn.tag = i;
        btn.width = btnW;
        btn.height = btnH;
        btn.x = 0;
        btn.y = i * btnH;
        
    }
}

-(void)btnClick:(WYLeftMenuButton *)button
{
    // 2、通知代理
    if ([self.delegate respondsToSelector:@selector(leftMenu:didSelectedFromIndex:toIndex:)]) {
        [self.delegate leftMenu:self didSelectedFromIndex:(int)_selectedButton.tag toIndex:(int)button.tag];
    }
    
    // 1、控制按钮状态
    _selectedButton.selected = NO;
    button.selected = YES;
    _selectedButton = button;
}


@end
