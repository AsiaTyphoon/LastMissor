//
//  MultiColorView.m
//  obj_C_study
//
//  Created by haixinweishi on 15/12/2.
//  Copyright © 2015年 蒋林. All rights reserved.
//

#import "MultiColorView.h"

@interface MultiColorView ()
{
    NSInteger second;
    UIImageView *imageView;
}

@end

@implementation MultiColorView

//layerClass 返回主layer所使用的类 决定绘制类型
+ (Class)layerClass
{
    return [CAGradientLayer class];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        NSLog(@"width = %f", frame.size.width);
        
        second = 0;
        [self setupMulticolor];
        [self initImage];

        [NSTimer scheduledTimerWithTimeInterval:1.0/30.0 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    }
    return self;
}

-(void)initImage{
    
    imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    imageView.image = [UIImage imageNamed:@"lion.png"];
    imageView.clipsToBounds = YES;
    [self addSubview:imageView];

}

- (void)setupMulticolor
{
    NSLog(@"setupMulticolor...");
    CAGradientLayer *gradientLayer = (id)[self layer];
    
    //设置颜色线条分布的方向
    gradientLayer.startPoint = CGPointMake(0.0, 0.0);
    gradientLayer.endPoint = CGPointMake(1.0, 0.0);
    
    //创建颜色数组
    NSMutableArray *colors = [NSMutableArray array];
    for (NSInteger hue = 0; hue <= 360; hue += 10) {
        [colors addObject:(id)[UIColor colorWithHue:1.0*hue/360.0 saturation:1.0 brightness:1.0 alpha:1.0].CGColor];
    }
    
    [gradientLayer setColors:[NSArray arrayWithArray:colors]];
}

- (void)timerAction{
    
    second++;
    self.layer.mask = [self produceCircleShapeLayer];
}

- (CAShapeLayer *)produceCircleShapeLayer
{
    
    //生产一个圆的路径
    CGFloat lineWidth = CGRectGetWidth(self.bounds)/20;
    CGFloat circleStartAngle = M_PI;
    CGFloat circleEndAngle = -M_PI;
    int circleClockwise = 0.0f;
    CGFloat circleRadius = CGRectGetWidth(self.bounds)/6;
    
    //圆心动态坐标
    CGFloat R = CGRectGetWidth(self.bounds)/2 - circleRadius - lineWidth;
    CGFloat circleX = CGRectGetWidth(self.bounds)/2 + R*cos(second*M_PI/180);
    CGFloat circleY = CGRectGetHeight(self.bounds)/2 + R*sin(second*M_PI/180);
    CGPoint circleCenter = CGPointMake(circleX, circleY);

    //delegate
    [self.delegate multiColorView:circleRadius Center:circleCenter];
    //image
    imageView.frame = CGRectMake(0, 0, circleRadius*2, circleRadius*2);
    imageView.center = circleCenter;
    [imageView.layer setCornerRadius:circleRadius];
//    imageView.transform = CGAffineTransformRotate(CGAffineTransformIdentity, second*M_PI/180);
    
    UIBezierPath *circlePath = [UIBezierPath bezierPathWithArcCenter:circleCenter
                                                              radius:circleRadius
                                                          startAngle:circleStartAngle
                                                            endAngle:circleEndAngle
                                                           clockwise:circleClockwise];
    
    //生产出一个圆形路径的layer
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = circlePath.CGPath;
    shapeLayer.strokeColor = [UIColor lightGrayColor].CGColor;
    shapeLayer.lineWidth = lineWidth;
    
    //设置出圆的完整性
    shapeLayer.strokeStart = 0;
    shapeLayer.strokeEnd = 1.0;
    
    return shapeLayer;
}

#pragma mark - Animation
- (void)startAnimation
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.duration = 5;
    animation.repeatCount = MAXFLOAT;
    animation.fromValue = [NSNumber numberWithDouble:0];
    animation.toValue = [NSNumber numberWithDouble:M_PI*2];
    [self.layer addAnimation:animation forKey:@"transform"];
}

- (void)endAnimation
{
    [self.layer removeAllAnimations];
}

@end
