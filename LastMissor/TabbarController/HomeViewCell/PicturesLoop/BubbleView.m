//
//  BubbleView.m
//  obj_C_study
//
//  Created by haixinweishi on 15/11/6.
//  Copyright © 2015年 蒋林. All rights reserved.
//

#import "BubbleView.h"
#import <QuartzCore/QuartzCore.h>

@interface BubbleView ()
{
    NSInteger originX;
    NSInteger originY;
    CGFloat angle;
    NSTimer *timer;
}
@end

@implementation BubbleView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //需在此处改变背景颜色
        self.backgroundColor = [UIColor clearColor];
        originX = 0;
        originY = 1;
        angle = 0.0f;
        [self startTimer];
    }
    return self;
}

- (void)timerAction{
    originX += 1;
    originY += 1;
    angle += 1;
//    NSLog(@"originX = %ld, originY = %ld ", originX, originY);
    [self setNeedsDisplay];
    //填充多种颜色
//    CAGradientLayer *gradient = [CAGradientLayer layer];
//    gradient.frame = self.bounds;
//    gradient.colors = [NSArray arrayWithObjects:
//                       (id)[UIColor whiteColor].CGColor,
//                       (id)[UIColor grayColor].CGColor,
//                       (id)[UIColor blackColor].CGColor,
//                       (id)[UIColor yellowColor].CGColor,
//                       (id)[UIColor blueColor].CGColor,
//                       (id)[UIColor redColor].CGColor,
//                       (id)[UIColor greenColor].CGColor,
//                       (id)[UIColor orangeColor].CGColor,
//                       (id)[UIColor brownColor].CGColor,
//                       nil];
//    [self.layer insertSublayer:gradient atIndex:0];

}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
    CGFloat x = rect.origin.x;
    CGFloat y = rect.origin.y;
    CGFloat width = /*rect.size.width*/ self.bounds.size.width;
    CGFloat height = /*rect.size.height*/ self.bounds.size.width;
    
    //创建上下文.设置一个空白view
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //填充矩形
//    CGContextSetRGBFillColor(context, 1, 0, 0, 1); //redcolor
//    CGContextFillRect(context, CGRectMake(x, y, width, height));
//    CGContextSetAlpha(context, 0.1);
//    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
//    CGContextFillRect(context, CGRectMake(x, y, width, height-10));
    
    //创建一个path句柄
    CGMutablePathRef pathRef = CGPathCreateMutable();
    
    //初始化该path到一个初始点
    CGPathMoveToPoint(pathRef, &CGAffineTransformIdentity, x, y);
    
    //添加一条直线，从初始点到该函数指定的坐标点
    CGPathAddLineToPoint(pathRef, &CGAffineTransformIdentity, width, y);
    CGPathAddLineToPoint(pathRef, &CGAffineTransformIdentity, width, height-10);
    CGPathAddLineToPoint(pathRef, &CGAffineTransformIdentity, width-5, height-10);
    CGPathAddLineToPoint(pathRef, &CGAffineTransformIdentity, width-10, height);
    CGPathAddLineToPoint(pathRef, &CGAffineTransformIdentity, width-15, height-10);
    CGPathAddLineToPoint(pathRef, &CGAffineTransformIdentity, x, height-10);
//    CGPathAddLineToPoint(pathRef, &CGAffineTransformIdentity, x, y);

    
    //关闭该path
    CGPathCloseSubpath(pathRef);
    
    //设置描边颜色
    CGContextSetRGBStrokeColor(context, 0.99f, 0.01f, 0.02f, 1.0f);
    CGContextSetLineCap(context, kCGLineCapSquare);//设置线条样式
    CGContextSetLineWidth(context, 1.0);//设置线条粗细

   
    
    
    //讲此path添加到quartz上下文中
    CGContextAddPath(context, pathRef);
    
    //对上下文进行描边
//    CGContextStrokePath(context);//启动画图
//    CGContextSetRGBFillColor(context, 0.99f, 0.01f, 0.02f, 1.0f);
//    CGContextDrawPath(context, kCGPathFill); //启动画图并用画笔颜色填充图形（rgb若设置则用rgb颜色）
    CGContextDrawPath(context, kCGPathStroke);
    
    //释放该path
    CGPathRelease(pathRef);

#pragma mark   /*------- 动态画圆 -------*/
//    CGContextSetRGBFillColor(context, 0, 0, 0, 1);
    CGContextSetFillColorWithColor(context, [UIColor orangeColor].CGColor);
    CGFloat radius = height/4;

    CGFloat yuanX = width/2 - width/4*cos(angle*M_PI/180);
    CGFloat yuanY = height/2 - height/4*sin(angle*M_PI/180);
//    CGFloat startAngle =  0;
//    CGFloat endAngle = M_PI*2;
//    int clockwise = 0;
//    CGContextMoveToPoint(context, yuanX, yuanY);
//    CGContextAddArc(context, yuanX, yuanY, radius, startAngle, endAngle, clockwise);
    CGContextAddEllipseInRect(context, CGRectMake(yuanX - radius*sin(M_PI_4), yuanY - radius*cos(M_PI_4), radius, radius));
    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathFillStroke);
}

- (void)startTimer
{
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0/60.0 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];

}
- (void)endTimer
{
    [timer invalidate];
}

@end
