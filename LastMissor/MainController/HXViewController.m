//
//  HXViewController.m
//  LastMissor
//
//  Created by HXjiang on 16/6/16.
//  Copyright © 2016年 JiangLin. All rights reserved.
//

#import "HXViewController.h"

@interface HXViewController ()

@end

@implementation HXViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupNavigationView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//扫描付款区
- (void)setupNavigationView
{
    CGFloat viewH = 64.0f;
    
    UIView *viewScan = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, viewH)];
    viewScan.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
    
//    [self.view addSubview:viewScan];
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
