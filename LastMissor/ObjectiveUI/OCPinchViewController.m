//
//  OCPinchViewController.m
//  OcTrain
//
//  Created by HXjiang on 16/6/14.
//  Copyright © 2016年 蒋林. All rights reserved.
//

#import "OCPinchViewController.h"

#define UISCREEN_WIDTH  (0)
#define UISCREEN_HEIGHT (0)

@interface OCPinchViewController ()
{
    CGFloat lastScale;
    CGPoint lastPoint;
}
@property (nonatomic, strong) UIView *viewTest;

@end

@implementation OCPinchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.viewTest];
    
    //缩放手势
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinch:)];
    [self.viewTest addGestureRecognizer:pinch];
    
    //拖拉手势
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self.viewTest addGestureRecognizer:pan];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //强制旋转屏幕
    NSLog(@"强制旋转屏幕");
    [self forceChangeToOrientation:UIInterfaceOrientationLandscapeRight];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    [self forceChangeToOrientation:UIInterfaceOrientationPortrait];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pinch:(UIPinchGestureRecognizer *)pinchGesture
{
    if ([pinchGesture numberOfTouches] < 2) {
        return;
    }
    
    if (pinchGesture.state == UIGestureRecognizerStateBegan) {
        lastScale = pinchGesture.scale;
        lastPoint = [pinchGesture locationInView:self.view];
    }
    
    if (pinchGesture.state == UIGestureRecognizerStateEnded) {
    }
    
    if (pinchGesture.state == UIGestureRecognizerStateChanged) {
        CGFloat scale;
        //Scale
        if (pinchGesture.scale > lastScale) {
            scale = lastScale + (pinchGesture.scale - lastScale);
        }
        else {
            scale = lastScale - (lastScale - pinchGesture.scale);
        }
        
        NSLog(@"scale:%f", scale);
        NSLog(@"lastScale:%f", lastScale);
        if (scale < 1.0) {
            self.viewTest.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0);
            self.viewTest.center = self.view.center;
        }
        else if (scale > 1.5) {
            self.viewTest.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.5, 1.5);
        }
        else {
            self.viewTest.transform = CGAffineTransformScale(CGAffineTransformIdentity, scale, scale);
        }
        lastScale = pinchGesture.scale;
    }
    
}

- (void)pan:(UIPanGestureRecognizer *)panGesture
{
    CGPoint point = [panGesture translationInView:self.view];
    
    if (panGesture.state == UIGestureRecognizerStateChanged) {
    
        if (CGRectGetMinX(self.viewTest.frame) > 0 || CGRectGetMaxX(self.viewTest.frame) < UISCREEN_WIDTH) {
            return;
        }
        
        CGFloat x = self.viewTest.center.x + point.x;
        CGFloat y = self.viewTest.center.y;
        self.viewTest.center = CGPointMake(x, y);
        
        CGFloat minX = CGRectGetMinX(self.viewTest.frame);
        CGFloat maxX = CGRectGetMaxX(self.viewTest.frame);
        
        NSLog(@"minX:%f", minX);
        NSLog(@"maxX:%f", maxX);
        
        if (minX > 0 || maxX < UISCREEN_WIDTH) {
            CGRect rectCurrent = self.viewTest.frame;
            if (minX >= 0) {
                rectCurrent.origin.x = 0;
                self.viewTest.frame = rectCurrent;
            }
            if (maxX <= UISCREEN_WIDTH) {
                rectCurrent.origin.x += (UISCREEN_WIDTH - maxX);
                self.viewTest.frame = rectCurrent;
            }
            return;
        }

        
        NSLog(@"xxx:%f", x);
        [panGesture setTranslation:CGPointMake(0, 0) inView:self.view];
    }
}

- (UIView *)viewTest
{
    if (!_viewTest)
    {
        _viewTest = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UISCREEN_WIDTH, 250)];
        _viewTest.center = self.view.center;
        _viewTest.backgroundColor = [UIColor redColor];
        
        UIImageView *imgLeft = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, UISCREEN_WIDTH/2, 250)];
        imgLeft.backgroundColor = [UIColor greenColor];
        [_viewTest addSubview:imgLeft];
        
        UIImageView *imgRight = [[UIImageView alloc] initWithFrame:CGRectMake(UISCREEN_WIDTH/2, 0, UISCREEN_WIDTH/2, 250)];
        imgRight.backgroundColor = [UIColor orangeColor];
        [_viewTest addSubview:imgRight];
    }
    return _viewTest;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark --
//是否支持设备旋转
- (BOOL)shouldAutorotate
{
    //    NSLog(@"shouldAutorotate");
    return YES;
}

//返回支持的屏幕指向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    //    NSLog(@"supportedInterfaceOrientations");
    return UIInterfaceOrientationMaskAllButUpsideDown;
}

////返回当前屏幕需要的指向
//- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
//{
//    NSLog(@"preferredInterfaceOrientationForPresentation");
//    return UIInterfaceOrientationPortrait;
//}

//强制更改横竖屏
- (void)forceChangeToOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    [[UIDevice currentDevice] setValue:[NSNumber numberWithInteger:interfaceOrientation] forKey:@"orientation"];
}

@end
