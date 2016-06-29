//
//  HXProgress.h
//  LastMissor
//
//  Created by HXjiang on 16/6/29.
//  Copyright © 2016年 JiangLin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HXProgress : UIView


+ (void)showProgressWithSize:(CGSize)size;
+ (void)showText:(NSString *)text withSize:(CGSize)size durationTime:(NSTimeInterval)time;
+ (void)dismiss;

@end
