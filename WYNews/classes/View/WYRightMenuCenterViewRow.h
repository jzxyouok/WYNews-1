//
//  WYRightMenuCenterViewRow.h
//  WYNews
//
//  Created by dabbyGHF on 16/6/3.
//  Copyright © 2016年 dabbyGHF. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WYRightMenuCenterViewRow : UIView

@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *title;

+(instancetype)centerViewRow;
@end
