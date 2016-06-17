//
//  HomeViewController.m
//  LastMissor
//
//  Created by HXjiang on 16/6/17.
//  Copyright © 2016年 JiangLin. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // [self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
    
    self.navigationItem.rightBarButtonItems = @[[self setupBarButtonItemWihtImageName:@"tabbar_mainframe"],
                                                [self setupBarButtonItemWihtImageName:@"tabbar_contacts"],
                                                [self setupBarButtonItemWihtImageName:@"tabbar_discover"]];
    
    
//    self.navigationController.navigationBar.hidden = YES;
    
    [self setupScanView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//导航栏
- (UIBarButtonItem *)setupBarButtonItemWihtImageName:(NSString *)imageName
{
    //tabbar_mainframe,tabbar_discover,tabbar_contacts
    UIImage *image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIButton *buttonItem = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
    [buttonItem setImage:image forState:UIControlStateNormal];
    
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithCustomView:buttonItem];

    return barItem;
}

//扫描付款区
- (void)setupScanView
{
    CGFloat viewH = 100.0f;
    
    UIView *viewScan = [[UIView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, viewH)];
    viewScan.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
    
    [self.view addSubview:viewScan];
}



//- (UIStatusBarStyle)preferredStatusBarStyle
//{
//    return UIStatusBarStyleLightContent;
//}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

/*
 在老版本的iOS中，状态栏永远都是白色风格。而在iOS 7中，我们可以修改每个view controller中状态栏的外观。通过UIStatusBarStyle常量可以指定状态栏的内容是暗色或亮色。默认情况下，状态栏的显示是暗色。也就是说，状态栏上的时间、电池指示器和Wi-Fi信号显示为暗色。
 
 我们可能希望将导航栏的风格修改为亮色。这里有两个方法可以实现。在iOS 7中，我们可以在每个view controller中overridingpreferredStatusBarStyle:方法，如下所示：
 - (UIStatusBarStyle)preferredStatusBarStyle {     return UIStatusBarStyleLightContent; }
 PS：此法的只有在设置了以下代码才会被调用（对于preferredStatusBarStyle不执行问题）：
 [self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
 
 */

@end
