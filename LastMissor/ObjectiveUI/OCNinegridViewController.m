//
//  OCNinegridViewController.m
//  OcTrain
//
//  Created by HXjiang on 16/3/30.
//  Copyright © 2016年 蒋林. All rights reserved.
//

#import "OCNinegridViewController.h"

#define UI_SCREEN_W (self.view.bounds.size.width)
#define UI_SCREEN_H (self.view.bounds.size.height)
#define AppViewW    80  //视图宽度
#define AppViewH    90  //视图高度
#define LineCount   3   //每行视图个数
#define TotalCount  12  //总的视图个数


@interface OCNinegridViewController ()

@end

@implementation OCNinegridViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //
    [self setUpNinegrid];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

//初始化九宫格
- (void)setUpNinegrid
{
    //起始坐标
    CGFloat startX = (UI_SCREEN_W - LineCount*AppViewW)/(LineCount+1);
    CGFloat startY = 64;
    //视图间距
    CGFloat Xx = startX;
    CGFloat Yy = 10;
    
    for (int i = 0; i < TotalCount; i++) {
        //行
        //0,1,2     =>  0
        //3,4,5     =>  1
        int row = i / LineCount;
        //列
        //0,3,6     =>  0
        //1,4,7     =>  1
        int col = i % LineCount;
        
        //视图坐标
        CGFloat x = startX+(AppViewW+Xx)*col;
        CGFloat y = startY+(AppViewH+Yy)*row;
        
        UIView *appView = [[UIView alloc] initWithFrame:CGRectMake(x, y, AppViewW, AppViewH)];
        appView.backgroundColor = [UIColor redColor];
        [self.view addSubview:appView];
        
        UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(0, -2, AppViewW, 50)];
        icon.image = [UIImage imageNamed:@"lion.png"];
        icon.contentMode = UIViewContentModeScaleAspectFit;
        [appView addSubview:icon];
    }
}


@end
