//
//  HXTabBarController.m
//  LastMissor
//
//  Created by HXjiang on 16/6/16.
//  Copyright © 2016年 JiangLin. All rights reserved.
//

#import "HXTabBarController.h"
#import "HXNavigationController.h"

@interface HXTabBarController ()

@end

@implementation HXTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //初始化控制器
    [self setUpAllControllers];
    
    //回执编号[2915003931]，成功凭证[14663476]
    
    //设置tabbarcontroller的tabbaritem图片的大小
    UIImage *tabbarimage=[[UIImage imageNamed:@"home-10.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImageView *tabBarBackgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.tabBar.frame.size.width, self.tabBar.frame.size.height)];
    //tabBarBackgroundImageView.contentMode = UIViewContentModeScaleAspectFit;//效果将按原图原来的比例缩放
    tabBarBackgroundImageView.image =tabbarimage;
    [self.tabBar insertSubview:tabBarBackgroundImageView atIndex:1]; //atIndex决定你的图片显示在标签栏的哪一层
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- 添加所有子控制器
- (void)setUpAllControllers
{
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    
//    NSString *strTitle;
//    NSString *strTabBarItemTitle;
//    NSString *strImageName;
//    NSString *strSelectImageName;
//    
//    //camera
//    //    CameraViewController *camera = [[CameraViewController alloc] init];
//    CameraViewController *camera = [storyboard instantiateViewControllerWithIdentifier:@"CameraViewSBID"];
//    strTitle            = @"ROCAM";
//    strTabBarItemTitle  = NSLocalizedString(@"Camera", nil);
//    strImageName        = @"home-6-30×30.png";
//    strSelectImageName  = @"home-6-Click-30×30.png";
//    [self setUpController:camera Title:strTitle ItemTitle:strTabBarItemTitle Image:strImageName SelectImage:strSelectImageName];
//    
//    //video
//    //    VideoViewController *HXVideo = [[VideoViewController alloc] init];
//    VideoViewController *HXVideo = [storyboard instantiateViewControllerWithIdentifier:@"VideoViewSBID"];
//    strTitle            = NSLocalizedString(@"video viewing", nil);
//    strTabBarItemTitle  = NSLocalizedString(@"video", nil);
//    strImageName        = @"home-7-30×30.png";
//    strSelectImageName  = @"home-7-Click-30×30.png";
//    
//    [self setUpController:HXVideo Title:strTitle ItemTitle:strTabBarItemTitle Image:strImageName SelectImage:strSelectImageName];
//    
//    
//    //photo
//    //    PhotoViewController *HXPhoto = [[PhotoViewController alloc] init];
//    PhotoViewController *HXPhoto = [[PhotoViewController alloc] init];
//    strTitle            = NSLocalizedString(@"Local Picture", nil);
//    strTabBarItemTitle  = NSLocalizedString(@"picture", nil);
//    strImageName        = @"home-8-30×30.png";
//    strSelectImageName  = @"home-8-Click-30×30.png";
//    [self setUpController:HXPhoto Title:strTitle ItemTitle:strTabBarItemTitle Image:strImageName SelectImage:strSelectImageName];
//    
//    
//    
//    //about
//    //    AboutViewController *about = [[AboutViewController alloc] init];
//    //    AboutViewController *about = [storyboard instantiateViewControllerWithIdentifier:@"AboutViewSBID"];
//    MoreViewController *more = [[MoreViewController alloc] init];
//    strTitle            = NSLocalizedString(@"About", nil);
//    strTabBarItemTitle  = NSLocalizedString(@"About", nil);
//    strImageName        = @"home-9-30×30.png";
//    strSelectImageName  = @"home-9-Click-30×30.png";
//    [self setUpController:more Title:strTitle ItemTitle:strTabBarItemTitle Image:strImageName SelectImage:strSelectImageName];
    
}


/**
 *  将所有的子控制器包装成导航控制器
 *
 *  @param vc                   控制器
 *  @param title                控制器的标题
 *  @param itemTitle            tabbarItem 的标题
 *  @param imageName                正常图片
 *  @param selectImageName          选中图片
 */

- (void)setUpController:(UIViewController *)vc Title:(nullable NSString *)title ItemTitle:(NSString *)itemTitle Image:(NSString *)imageName SelectImage:(NSString *)selectImageName
{
    HXNavigationController *HXNaVc = [[HXNavigationController alloc] initWithRootViewController:vc];
    //设置导航栏背景图片
    [HXNaVc.navigationBar setBackgroundImage:[[UIImage imageNamed:@"home-10.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forBarMetrics:UIBarMetricsDefault];
    //导航栏上title字体的颜色
    //    HXNaVc.navigationBar.titleTextAttributes = @{UITextAttributeTextColor:[UIColor whiteColor]};
    HXNaVc.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    
    //导航栏上字体的颜色，不包括title
    //    HXNaVc.navigationBar.tintColor = [UIColor redColor];
    //    HXNaVc.navigationBar.backgroundColor = [UIColor redColor];
    
    //设置统一的返回按钮样式,设置返回按钮图片和文字偏移,图片设置拉伸变形厉害，暂未使用
    //UIBarMetricsCompact 只显示文字
    //    UIImage *backImage = [UIImage imageNamed:@"back_white.png"];
    //    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:backImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    //    [[UIBarButtonItem appearance] setBackButtonBackgroundVerticalPositionAdjustment:CGFLOAT_MIN forBarMetrics:UIBarMetricsDefault];//调整返回图片上下移动
    //    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(NSIntegerMin, NSIntegerMin) forBarMetrics:UIBarMetricsDefault];
    
    
    //    vc.title = title;//与navigationItem.title效果相同
    //    vc.navigationItem.title = title;
    //    vc.tabBarItem.title = itemTitle;
    vc.tabBarItem.image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //selectedImage支持iOS7以后的系统
    vc.tabBarItem.selectedImage = [[UIImage imageNamed:selectImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    //tabBarItem图片位置
    CGFloat offset = 5.0f;
    vc.tabBarItem.imageInsets = UIEdgeInsetsMake(offset, 0, -offset, 0);
    
    [self addChildViewController:HXNaVc];
    
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
