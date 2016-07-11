//
//  HXNavigationController.m
//  LastMissor
//
//  Created by HXjiang on 16/6/16.
//  Copyright © 2016年 JiangLin. All rights reserved.
//

#import "HXNavigationController.h"


@interface HXNavigationController ()

@end

@implementation HXNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //修改导航栏标题颜色
    self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    //修改导航栏item颜色
    self.navigationBar.tintColor = [UIColor greenColor];
    //修改导航栏背景颜色
    self.navigationBar.backgroundColor = [UIColor clearColor];
    
    //修改导航栏背景颜色为黑色，并且状态栏的字体颜色为白色
    self.navigationBar.barStyle = UIBarStyleBlack;
    
    //添加阴影图片，用来隐藏导航栏底部线条
    UIImage *shadowImg = [UIImage imageWithColor:RGBA_COLOR(0, 0, 0, 0) wihtSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, 1)];
    [self.navigationBar setShadowImage:shadowImg];

    //设置导航栏背景图片
    UIImage *backgroundImg = [UIImage imageWithColor:RGBA_COLOR(0, 0, 0, 0.8) wihtSize:CGSizeMake([UIScreen mainScreen].bounds.size.height, 45)];
    [self.navigationBar setBackgroundImage:backgroundImg forBarMetrics:UIBarMetricsDefault];
    

    //设置统一的返回按钮样式,设置返回按钮图片和文字偏移,图片设置拉伸变形厉害，暂未使用
    //UIBarMetricsCompact 只显示文字
//        UIImage *backImage = [UIImage imageNamed:@"back_white.png"];
//        [[UIBarButtonItem appearance] setBackButtonBackgroundImage:backgroundImg forState:UIControlStateNormal barMetrics:UIBarMetricsCompact];
    //    [[UIBarButtonItem appearance] setBackButtonBackgroundVerticalPositionAdjustment:CGFLOAT_MIN forBarMetrics:UIBarMetricsDefault];//调整返回图片上下移动
    //    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(NSIntegerMin, NSIntegerMin) forBarMetrics:UIBarMetricsDefault];

    
    //全局隐藏tabbar
//    self.navigationBar.hidden = YES;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 旋转屏幕
//是否支持设备旋转
- (BOOL)shouldAutorotate
{
    //    if (self.topViewController.shouldAutorotate)
    //    {
    //        NSLog(@"YES--------------");
    //    }
    //    else
    //    {
    //        NSLog(@"NO---------------");
    //    }
    
    return self.topViewController.shouldAutorotate;
}
//支持的界面指向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    //    UIInterfaceOrientationMask orientation = self.topViewController.supportedInterfaceOrientations;
    //    if (orientation == UIInterfaceOrientationLandscapeLeft)
    //    {
    //        NSLog(@"UIInterfaceOrientationLandscapeLeft------");
    //    }
    //    if (orientation == UIInterfaceOrientationLandscapeRight)
    //    {
    //        NSLog(@"UIInterfaceOrientationLandscapeRight------");
    //    }
    //    if (orientation == UIInterfaceOrientationPortrait)
    //    {
    //        NSLog(@"UIInterfaceOrientationPortrait-------------");
    //    }
    //    if (orientation == UIInterfaceOrientationPortraitUpsideDown)
    //    {
    //        NSLog(@"UIInterfaceOrientationPortraitUpsideDown-----");
    //    }
    
    return self.topViewController.supportedInterfaceOrientations;
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
