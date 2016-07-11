//
//  HXTabBarController.m
//  LastMissor
//
//  Created by HXjiang on 16/6/16.
//  Copyright © 2016年 JiangLin. All rights reserved.
//

#import "HXTabBarController.h"
#import "HXNavigationController.h"

//child viewcontroller
#import "HomeViewController.h"
#import "FoodViewController.h"
#import "FriendViewController.h"
#import "AboutViewController.h"


#define keyClass   (@"viewcontroller")
#define keyTtitle   (@"title")
#define keyBtitle   (@"tabBarItemTitle")
#define keyNimage   (@"image")
#define keySimage   (@"selectedImage")

@interface HXTabBarController ()

@end

@implementation HXTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //初始化控制器
    [self setUpChildViewControllers];
    
    
    //设置tabbarcontroller的tabbaritem图片的大小
    CGFloat w = self.tabBar.frame.size.width;
    CGFloat h = self.tabBar.frame.size.height;
    UIImage *tabbarImg = [UIImage imageWithColor:RGBA_COLOR(220, 220, 220, 0.7) wihtSize:CGSizeMake(w, h)];
    UIImageView *tabBarBackgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, w, h)];
    //tabBarBackgroundImageView.contentMode = UIViewContentModeScaleAspectFit;//效果将按原图原来的比例缩放
    tabBarBackgroundImageView.image = tabbarImg;
    [self.tabBar insertSubview:tabBarBackgroundImageView atIndex:1]; //atIndex决定你的图片显示在标签栏的哪一层
     
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- 添加所有子控制器
- (void)setUpChildViewControllers
{
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
 
    NSArray *childViewControllers = @[
                                      @{keyClass:@"HomeViewController",
                                        keyTtitle:@"账单",
                                        keyBtitle:@"支付宝",
                                        keyNimage:@"tabbar_mainframe",
                                        keySimage:@"tabbar_mainframeHL"},
                                      
                                      @{keyClass:@"FoodViewController",
                                        keyTtitle:@"商家",
                                        keyBtitle:@"口碑",
                                        keyNimage:@"tabbar_discover",
                                        keySimage:@"tabbar_discoverHL"},
                                      
                                      @{keyClass:@"FriendViewController",
                                        keyTtitle:@"生活圈",
                                        keyBtitle:@"朋友",
                                        keyNimage:@"tabbar_contacts",
                                        keySimage:@"tabbar_contactsHL"},
                                      
                                      @{keyClass:@"AboutViewController",
                                        keyTtitle:@"设置",
                                        keyBtitle:@"我的",
                                        keyNimage:@"tabbar_me",
                                        keySimage:@"tabbar_meHL"}
                                      ];
    
    
    [childViewControllers enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL *stop) {
        
        [self setUpController:dict[keyClass] Title:dict[keyTtitle] ItemTitle:dict[keyBtitle] Image:dict[keyNimage] SelectImage:dict[keySimage]];
        
    }];//@enumerateObjectsUsingBlock

}//@setUpChildViewControllers


/**
 *  将所有的子控制器包装成导航控制器
 *
 *  @param vc                   控制器
 *  @param title                控制器的标题
 *  @param itemTitle            tabbarItem 的标题
 *  @param imageName                正常图片
 *  @param selectImageName          选中图片
 */

- (void)setUpController:(NSString *)class Title:(nullable NSString *)title ItemTitle:(NSString *)itemTitle Image:(NSString *)imageName SelectImage:(NSString *)selectImageName
{
    UIViewController *vc = [[NSClassFromString(class) alloc] init];
    
    HXNavigationController *HXNaVc = [[HXNavigationController alloc] initWithRootViewController:vc];

        
    vc.title = title;//与navigationItem.title效果相同
    //    vc.navigationItem.title = title;
    
    vc.tabBarItem.title = itemTitle;
    vc.tabBarItem.image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //selectedImage支持iOS7以后的系统
    vc.tabBarItem.selectedImage = [[UIImage imageNamed:selectImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    //tabBarItem图片位置
//    CGFloat offset = 5.0f;
//    vc.tabBarItem.imageInsets = UIEdgeInsetsMake(offset, 0, -offset, 0);
    
    
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
