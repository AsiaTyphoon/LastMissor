//
//  MultiColorView.h
//  obj_C_study
//
//  Created by haixinweishi on 15/12/2.
//  Copyright © 2015年 蒋林. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MultiColorViewDelegate <NSObject>

@required
- (void)multiColorView:(CGFloat)circleRadius Center:(CGPoint)circlePoint;

@end

@interface MultiColorView : UIView

@property(weak, nonatomic) id<MultiColorViewDelegate> delegate;

- (void)startAnimation;
- (void)endAnimation;

@end
