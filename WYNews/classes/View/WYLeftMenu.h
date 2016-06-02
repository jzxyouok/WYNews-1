//
//  WYLeftMenu.h
//  WYNews
//
//  Created by dabbyGHF on 16/6/1.
//  Copyright © 2016年 dabbyGHF. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WYLeftMenu;
@protocol WYLeftMenuDelegate <NSObject>
@optional
-(void)leftMenu:(WYLeftMenu *)menu didSelectedFromIndex:(int) fromIndex toIndex:(int)toIndex;
@end

@interface WYLeftMenu : UIView
@property (nonatomic, weak) id<WYLeftMenuDelegate> delegate;
@end
