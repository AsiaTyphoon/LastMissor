//
//  PicturesLoop.h
//  管理系统
//
//  Created by haixinweishi on 16/1/8.
//  Copyright © 2016年 SanMao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PicturesLoop : UIView


- (id)initWithFrame:(CGRect)frame WithImages:(NSArray *)imageArray WithTitle:(NSArray *)titleArray WithDetail:(NSArray *)detailArray;


- (id)initWithFrame:(CGRect)frame WithImages:(NSArray *)imageArray;


//setPagecontrol
- (void)setPagecontrolHidden:(BOOL)hide;
- (void)setpagecontrolFrame:(CGRect)frame;
- (void)setPagecontrolIndicatorTintColor:(UIColor *)color;
- (void)setPagecontrolCurrentPageIndicatorTintColor:(UIColor *)color;

@end
