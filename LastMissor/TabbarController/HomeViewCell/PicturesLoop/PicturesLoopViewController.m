//
//  PicturesLoopViewController.m
//  OcTrain
//
//  Created by HXjiang on 16/6/16.
//  Copyright © 2016年 蒋林. All rights reserved.
//

#import "PicturesLoopViewController.h"
#import "PicturesLoop.h"
#import "BubbleView.h"
#import "MultiColorView.h"

@interface PicturesLoopViewController ()
{
    BubbleView *bubView;
    MultiColorView *colorView;

}

@end

@implementation PicturesLoopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    //picture loops
//    CGRect picRect = CGRectMake(0, 64, UISCREEN_WIDTH, 250);
//    NSArray *picArray = @[@"01.jpg", @"02.jpg", @"03.jpg", @"04.jpg", @"05.jpg", @"06.jpg"];
//    PicturesLoop *picturesLoop = [[PicturesLoop alloc] initWithFrame:picRect WithImages:picArray];
//    [self.view addSubview:picturesLoop];
    
    
//    bubView = [[BubbleView alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(picturesLoop.frame), 260, 300)];
//    [self.view addSubview:bubView];
    
    [self multiColorView];


}


- (void)viewWillAppear:(BOOL)animated{
    [bubView startTimer];
}
- (void)viewDidDisappear:(BOOL)animated{
    [bubView endTimer];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)multiColorView
{
    CGRect colorViewRect = CGRectMake(self.view.frame.size.width-100, 64, 100, 100);
    //    CGRect colorViewRect = self.view.frame;
    //
    colorView = [[MultiColorView alloc] initWithFrame:colorViewRect];
    
    [self.view addSubview:colorView];
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
