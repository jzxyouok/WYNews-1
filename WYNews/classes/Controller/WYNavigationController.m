//
//  WYNavigationController.m
//  WYNews
//
//  Created by dabbyGHF on 16/6/1.
//  Copyright © 2016年 dabbyGHF. All rights reserved.
//

#import "WYNavigationController.h"
#import "WYNavigationBar.h"

@implementation WYNavigationController
+(void)initialize
{
    UINavigationBar *appearance = [UINavigationBar appearance];
    
    // 设置导航栏背景
    [appearance setBackgroundImage:[UIImage imageNamed:@"top_navigation_background"] forBarMetrics:UIBarMetricsDefault];
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    // 替换为自定义的导航栏
    [self setValue:[[WYNavigationBar alloc]init] forKey:@"navigationBar"];
}

//#pragma mark - 这个方法也是专门用来布局子控件（当控制器的view尺寸发生改变的时候会调用）
//- (void)viewDidLayoutSubviews
//{
//    [super viewDidLayoutSubviews];
//
//    for (UIButton *button in self.navigationBar.subviews) {
//        if (![button isKindOfClass:[UIButton class]]) continue;
//
//        if (button.centerX < self.navigationBar.width * 0.5) { // 左边的按钮
//            button.x = 0;
//        } else if (button.centerX > self.navigationBar.width * 0.5) { // 右边的按钮
//            button.x = self.view.width - button.width;
//        }
//    }
//}
@end
