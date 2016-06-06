//
//  WYRightMenuViewController.m
//  WYNews
//
//  Created by dabbyGHF on 16/6/3.
//  Copyright © 2016年 dabbyGHF. All rights reserved.
//

#import "WYRightMenuViewController.h"
#import "WYRightMenuCenterViewRow.h"

@interface WYRightMenuViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UIView *centerView;
@property (weak, nonatomic) IBOutlet UIView *bottonView;

@end

@implementation WYRightMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1、填充中间内容
    [self setupCenterView];
    
    // 2、填充底部内容
    [self setupBottomView];
}

/**
 *  填充中间内容
 */
-(void)setupCenterView
{
    [self setupCenterViewRow:@"商城 能赚能花，土豪当家" icon:@"promoboard_icon_mall"];
    [self setupCenterViewRow:@"活动 4.0发布会粉丝招募" icon:@"promoboard_icon_activities"];
    [self setupCenterViewRow:@"应用 金币从来都是这送的" icon:@"promoboard_icon_apps"];
}

/**
 *  设置中部按钮图标和文字
 *
 *  @param title 文字
 *  @param icon  图标
 */
-(void)setupCenterViewRow:(NSString *)title icon:(NSString *)icon
{
    WYRightMenuCenterViewRow *centerRow = [WYRightMenuCenterViewRow centerViewRow];
    centerRow.y = centerRow.height * self.centerView.subviews.count;
    centerRow.title = title;
    centerRow.icon = icon;
    [self.centerView addSubview:centerRow];
}

/**
 *  填充底部内容
 */
-(void)setupBottomView
{
    
}


-(void)didShow
{
    // 头像旋转
//    [UIView animateWithDuration:0.5 animations:^{
//        self.iconView.layer.transform = CATransform3DMakeRotation(M_PI_2, 0, 1, 0);
//    } completion:^(BOOL finished) {
//        self.iconView.image = [UIImage imageNamed:@"promoboard_icon_apps"];
//    }];
    [UIView transitionWithView:self.iconView duration:1.0 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
        self.iconView.image = [UIImage imageNamed:@"user_defaultgift"];
    } completion:^(BOOL finished) {
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [UIView transitionWithView:self.iconView duration:1.0 options:UIViewAnimationOptionTransitionFlipFromRight animations:^{
                self.iconView.image = [UIImage imageNamed:@"default_avatar"];
            } completion:nil];
        });
    }];
}

@end
