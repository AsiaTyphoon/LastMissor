//
//  AboutViewController.m
//  LastMissor
//
//  Created by HXjiang on 16/6/17.
//  Copyright © 2016年 JiangLin. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()

@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self shot];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)shot{
    
    UIImage *image = [UIImage imageWithColor:RGBA_COLOR(255, 0, 0, 1) wihtSize:CGSizeMake(320, 560)];
    self.view.layer.contents = (__bridge id)image.CGImage;
    
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imageView.alpha = 0.5;
    imageView.backgroundColor = [UIColor grayColor];
    
    //bezierPathWithRect 根据一个矩形画曲线
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRect:self.view.bounds];
    
    // Punch a hole :p...
    //bezierPathWithRoundedRect 根据矩形画带圆角的曲线
    //     [maskPath appendPath:[UIBezierPath bezierPathWithRoundedRect:CGRectMake(100, 100, 100, 100) cornerRadius:50]];
    //bezierPathWithRect
    [maskPath appendPath:[UIBezierPath bezierPathWithRect:CGRectMake(50, 100, 200, 300)]];
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    
    maskLayer.fillRule = kCAFillRuleEvenOdd;
    maskLayer.path = maskPath.CGPath;
    
    //     view.layer.mask = maskLayer;
    imageView.layer.mask = maskLayer;
    
    [self.view addSubview:imageView];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
