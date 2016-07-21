//
//  AVPlayerViewController.m
//  LastMissor
//
//  Created by HXjiang on 16/7/14.
//  Copyright © 2016年 JiangLin. All rights reserved.
//

#import "AVPlayerViewController.h"
#import "HXAVPlayer.h"

@interface AVPlayerViewController ()

@end

@implementation AVPlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.tabBarController.tabBar.hidden = YES;
    
    NSString *videoPath = @"http://mw5.dwstatic.com/2/4/1529/134981-99-1436844583.mp4";
    NSURL *viderURL = [NSURL URLWithString: videoPath];
    HXAVPlayer *player = [[HXAVPlayer alloc] initWithFrame:CGRectMake(0, 0, 320, 250) withURL:viderURL];
    player.center = self.view.center;
    [self.view addSubview:player];
    
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

@end
