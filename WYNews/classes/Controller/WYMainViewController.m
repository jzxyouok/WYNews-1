//
//  WYMainViewController.m
//  WYNews
//
//  Created by dabbyGHF on 16/6/1.
//  Copyright © 2016年 dabbyGHF. All rights reserved.
//

#import "WYMainViewController.h"
#import "WYLeftMenu.h"
#import "WYNewsTableViewController.h"
#import "WYNavigationController.h"
#import "WYReadingTableViewController.h"
#import "WYTitleView.h"
#define WYNavShowAnimation 0.25
#define WYCoverTag 100

@interface WYMainViewController () <WYLeftMenuDelegate>
@property (nonatomic,weak) WYNavigationController *showingNavigationController;
@end

@implementation WYMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 2.1添加新闻控制器
    WYNewsTableViewController *news = [[WYNewsTableViewController alloc]init];
    [self setupChildVc:news title:@"新闻"];
    
    // 2.2添加订阅控制器
    WYReadingTableViewController *reading = [[WYReadingTableViewController alloc]init];
    [self setupChildVc:reading title:@"订阅"];
    
    UIViewController *photo = [[UIViewController alloc]init];
    [self setupChildVc:photo title:@"图片"];
    
    UIViewController *video = [[UIViewController alloc]init];
    [self setupChildVc:video title:@"视频"];
    
    UIViewController *comment = [[UIViewController alloc]init];
    [self setupChildVc:comment title:@"跟帖"];
    
    UIViewController *radio = [[UIViewController alloc]init];
    [self setupChildVc:radio title:@"电台"];
    
    // 1、添加左菜单
    WYLeftMenu *leftMenu = [[WYLeftMenu alloc]init];
    leftMenu.height = 300;
    leftMenu.width = 200;
    leftMenu.y = 60;
    leftMenu.delegate = self;
    
    [self.view insertSubview:leftMenu atIndex:1];
}


/**
 *  初始化控制器
 *
 *  @param childVc 需要初始化的控制器
 *  @param title   控制器的标题
 */
-(void)setupChildVc:(UIViewController *)childVc title:(NSString *)title
{
    // 1、设置背景色
    childVc.view.backgroundColor = WYRandomColor;
    
    // 2、设置标题
    WYTitleView *titleView = [[WYTitleView alloc]init];
    titleView.title = title;
    childVc.navigationItem.titleView = titleView;
    
    // 3、设置左右的按钮
    childVc.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(leftMenu) image:@"top_navigation_menuicon"];
    
    childVc.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(rightMenu) image:@"top_navigation_infoicon"];
    
    // 4、包装导航控制器
    WYNavigationController *nav = [[WYNavigationController alloc]initWithRootViewController:childVc];
    nav.view.frame = self.view.frame;
    //    [self.view addSubview:newsNav.view];
    [self addChildViewController:nav];
    
}

/**
 *  点击左侧菜单
 */
-(void)leftMenu
{
    [UIView animateWithDuration:0.25 animations:^{
        //          CGFloat scale = 300.0 / SCREEN_HEIGHT;
        CGFloat scale = (SCREEN_HEIGHT - 60 * 2) / SCREEN_HEIGHT;
        // 菜单左边的间距
        CGFloat leftMenuMargin = SCREEN_WIDTH * (1 - scale) * 0.5;
        CGFloat translateX = 200 - leftMenuMargin;
        CGFloat topMargin = SCREEN_HEIGHT * (1 - scale) * 0.5;
        CGFloat translateY = topMargin - 60;
        
        // 缩放
        CGAffineTransform scaleForm =  CGAffineTransformMakeScale(scale, scale);
        
        // 平移
        CGAffineTransform translateForm =  CGAffineTransformTranslate(scaleForm, translateX / scale, -translateY / scale);
        
        _showingNavigationController.view.transform = translateForm;
        
        // 添加一个遮盖
        UIButton *cover = [[UIButton alloc]init];
        cover.tag = WYCoverTag;
        cover.frame = _showingNavigationController.view.bounds;
        [cover addTarget:self action:@selector(coverClick:) forControlEvents:UIControlEventTouchUpInside];
        [_showingNavigationController.view addSubview:cover];
    }];
    
}

-(void)rightMenu
{
    MyLog(@"right");
}

-(void)coverClick:(UIButton *)cover
{
    [UIView animateWithDuration:WYNavShowAnimation animations:^{
        _showingNavigationController.view.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [cover removeFromSuperview];
    }];
}

#pragma mark -LeftMenu代理方法
-(void)leftMenu:(WYLeftMenu *)menu didSelectedFromIndex:(int)fromIndex toIndex:(int)toIndex
{
//    MyLog(@"fromIndex -> %d, toIndex -> %d", fromIndex, toIndex);
    // 移除旧控制器的view
    WYNavigationController *oldNav = self.childViewControllers[fromIndex];
    [oldNav.view removeFromSuperview];
    
    // 显示新控制器的view
    WYNavigationController *newNav = self.childViewControllers[toIndex];
    [self.view addSubview:newNav.view];
    
    // 一个导航控制器的view第一次显示到它的父控件上时，如果transform的缩放值被改变，上面的20高度当时不会出来
    newNav.view.transform = oldNav.view.transform;

    
    _showingNavigationController = newNav;
    newNav.view.layer.shadowColor = [UIColor redColor].CGColor;
    newNav.view.layer.shadowOffset = CGSizeMake(-5, 0);
    newNav.view.layer.shadowOpacity = 0.1;
    
//    [UIView animateWithDuration:WYNavShowAnimation animations:^{
//        newNav.view.transform = CGAffineTransformIdentity;
//    }];
//    
//    // 清除当前正在显示的遮盖
//    [[newNav.view viewWithTag:WYCoverTag] removeFromSuperview];
    
    [self coverClick:[newNav.view viewWithTag:WYCoverTag]];
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end
