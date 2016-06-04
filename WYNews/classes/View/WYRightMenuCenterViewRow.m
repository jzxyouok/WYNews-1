//
//  WYRightMenuCenterViewRow.m
//  WYNews
//
//  Created by dabbyGHF on 16/6/3.
//  Copyright © 2016年 dabbyGHF. All rights reserved.
//

#import "WYRightMenuCenterViewRow.h"
@interface WYRightMenuCenterViewRow()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UIButton *titleView;
@end


@implementation WYRightMenuCenterViewRow


+(instancetype)centerViewRow
{
    return [[[NSBundle mainBundle]loadNibNamed:@"WYRightMenuCenterViewRow" owner:nil options:nil] lastObject];
}

-(void)setIcon:(NSString *)icon
{
    _icon = [icon copy];
    
    self.iconView.image = [UIImage imageNamed:icon];
}

-(void)setTitle:(NSString *)title
{
    _title = [title copy];
    
    [self.titleView setTitle:title forState:UIControlStateNormal];
}

@end
