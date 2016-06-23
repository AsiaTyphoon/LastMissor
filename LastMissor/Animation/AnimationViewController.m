//
//  AnimationViewController.m
//  OcTrain
//
//  Created by ( on 16/6/15.
//  Copyright © 2016年 蒋林. All rights reserved.
//

#import "AnimationViewController.h"

#define UISCREEN_WIDTH  ([UIScreen mainScreen].bounds.size.width)
#define UISCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@interface AnimationViewController ()

@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) NSMutableArray *btnArray;

@end

@implementation AnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 100)];
    _imgView.center = self.view.center;
    _imgView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:_imgView];

    [self setUpButtons];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)setUpButtons
{
    _btnArray = [[NSMutableArray alloc] initWithCapacity:0];
    [_btnArray addObject:@"翻转"];
    [_btnArray addObject:@"旋转"];
    [_btnArray addObject:@"翻页"];
    [_btnArray addObject:@"缩放"];
    [_btnArray addObject:@"取反"];
    [_btnArray addObject:@"平移"];
    [_btnArray addObject:@"彩虹"];
    
//    [_btnArray addObject:@"旋转"];
//    [_btnArray addObject:@"翻页"];
//    [_btnArray addObject:@"缩放"];
//    [_btnArray addObject:@"取反"];
//    [_btnArray addObject:@"平移"];
//    [_btnArray addObject:@"平移"];

    //列数
    NSInteger rowCount = 6;
    
    CGFloat btnW = 50.0f;
    CGFloat btnH = 50.0f;
    CGFloat offSpaceY = 10;
    CGFloat offSpaceX = (UISCREEN_WIDTH-rowCount*btnW)/(rowCount+1);

    for (int i = 0; i < _btnArray.count; i++) {
        
        //第几行
        int lineIndex = i / rowCount;
        //第几列
        int rowIndex = i % rowCount;
        
        CGFloat btnX = offSpaceX + (btnW+offSpaceX)*rowIndex;
        CGFloat btnY = UISCREEN_HEIGHT - (offSpaceY + (btnH+offSpaceY)*lineIndex)-btnH;
        
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(btnX, btnY, btnW, btnH)];
        btn.tag = i;
        btn.clipsToBounds = YES;
        btn.layer.cornerRadius = btnW/2;
        btn.backgroundColor = [UIColor purpleColor];
        [btn setTitle:[_btnArray objectAtIndex:i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }
    
}

- (void)btnAction:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    if (btn.tag == 0)
    {
        //翻转动画
        [self startView:_imgView AnimationTransition:UIViewAnimationTransitionFlipFromLeft Duration:1];
    }
    
    if (btn.tag == 1)
    {
        //
        //创建一个CGAffineTransform  transform对象
        CGAffineTransform  transform;
        //设置旋转度数
        transform = CGAffineTransformRotate(_imgView.transform,M_PI/*/6.0*/);
        //动画开始
        [UIView beginAnimations:@"rotate" context:nil ];
        //动画时常
        [UIView setAnimationDuration:2];
        //动画自动重播时间
//        [UIView setAnimationRepeatCount:10];
        //动画是否向前播放
//        [UIView setAnimationRepeatAutoreverses:YES];
        //添加代理
        [UIView setAnimationDelegate:self];
        //获取transform的值
        [_imgView setTransform:transform];
        //关闭动画  
        [UIView commitAnimations];
    }
    
    if (btn.tag == 2)
    {
        [UIView beginAnimations:@"curlUp" context:nil];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];//指定动画曲线类型，该枚举是默认的，线性的是匀速的
        //设置动画时常
        [UIView setAnimationDuration:1];
        [UIView setAnimationDelegate:self];
        //设置翻页的方向
        [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:_imgView cache:YES];
        //关闭动画
        [UIView commitAnimations];
    }
    
    if (btn.tag == 3)
    {
        CGAffineTransform  transform;
        transform = CGAffineTransformScale(_imgView.transform,1.2,1.2);
        [UIView beginAnimations:@"scale" context:nil];
        [UIView setAnimationDuration:2];
        [UIView setAnimationDelegate:self];
        [_imgView setTransform:transform];
        [UIView commitAnimations];
    }
    
    if (btn.tag == 4)
    {
        CGAffineTransform transform;
        transform=CGAffineTransformInvert(_imgView.transform);
        
        [UIView beginAnimations:@"Invert" context:nil];
        [UIView setAnimationDuration:2];//动画时常
        [UIView setAnimationDelegate:self];
        [_imgView setTransform:transform];//获取改变后的view的transform
        [UIView commitAnimations];//关闭动画
    }
    
    if (btn.tag == [_btnArray indexOfObject:@"平移"])
    {
        __block CGPoint point = _imgView.center;
        
        point.y -= 150;
        //使用动画代码块 方法四
        [UIView animateWithDuration:2 delay:0 usingSpringWithDamping:1 initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            
            _imgView.center = point;
            
        } completion:^(BOOL finished) {
            
            point.y += 150;
            [UIView animateWithDuration:2 animations:^{
                _imgView.center = point;
            }];
        }];
        
    }
    
    if (btn.tag == [_btnArray indexOfObject:@"彩虹"])
    {
        //方法五
        [self runAnimateKeyframes];
    }
}

- (void)startView:(UIView *)view AnimationTransition:(UIViewAnimationTransition)transition Duration:(NSTimeInterval)time
{
    //开始动画
    [UIView beginAnimations:@"doflip" context:nil];
    //设置时常
    [UIView setAnimationDuration:time];
    //设置动画淡入淡出
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    //设置代理
    [UIView setAnimationDelegate:self];
    //设置翻转方向,在动画中为视图设置过渡
    [UIView setAnimationTransition:transition  forView:view cache:YES];
    //动画停止时的消息
    [UIView setAnimationDidStopSelector:@selector(animationStoppedAction)];
    //动画结束
    [UIView commitAnimations];

}

- (void)animationStoppedAction
{
    NSLog(@"animationStoppedAction");
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    
}


- (void)runAnimateKeyframes {
    
    /**
     *  relativeDuration  动画在什么时候开始
     *  relativeStartTime 动画所持续的时间
     */
    
//    [UIView animateKeyframesWithDuration:6.f
//                                   delay:0.0
//                                 options:UIViewKeyframeAnimationOptionCalculationModeLinear
//                              animations:^{
//                                  [UIView addKeyframeWithRelativeStartTime:0.0   // 相对于6秒所开始的时间（第0秒开始动画）
//                                                          relativeDuration:1/3.0 // 相对于6秒动画的持续时间（动画持续2秒）
//                                                                animations:^{
//                                                                    _imgView.backgroundColor = [UIColor redColor];
//                                                                }];
//                                  
//                                  [UIView addKeyframeWithRelativeStartTime:1/3.0 // 相对于6秒所开始的时间（第2秒开始动画）
//                                                          relativeDuration:1/3.0 // 相对于6秒动画的持续时间（动画持续2秒）
//                                                                animations:^{
//                                                                    _imgView.backgroundColor = [UIColor yellowColor];
//                                                                }];
//                                  [UIView addKeyframeWithRelativeStartTime:2/3.0 // 相对于6秒所开始的时间（第4秒开始动画）
//                                                          relativeDuration:1/3.0 // 相对于6秒动画的持续时间（动画持续2秒）
//                                                                animations:^{
//                                                                    _imgView.backgroundColor = [UIColor greenColor];                                                                }];
//                                  
//                              }
//                              completion:^(BOOL finished) {
//                                  [self runAnimateKeyframes];
//                              }];
    
    
    void (^keyFrameBlock)() = ^(){
        // 创建颜色数组
        NSArray *arrayColors = @[[UIColor orangeColor],
                                 [UIColor yellowColor],
                                 [UIColor greenColor],
                                 [UIColor blueColor],
                                 [UIColor purpleColor],
                                 [UIColor redColor]];
        NSUInteger colorCount = [arrayColors count];
        // 循环添加关键帧
        for (NSUInteger i = 0; i < colorCount; i++) {
            [UIView addKeyframeWithRelativeStartTime:i / (CGFloat)colorCount
                                    relativeDuration:1 / (CGFloat)colorCount
                                          animations:^{
                                              [_imgView setBackgroundColor:arrayColors[i]];
                                          }];
        }
    };
    
    [UIView animateKeyframesWithDuration:4.0
                                   delay:0.0
                                 options:UIViewKeyframeAnimationOptionCalculationModeCubic | UIViewAnimationOptionCurveLinear
                              animations:keyFrameBlock
                              completion:^(BOOL finished) {
                                  // 动画完成后执行
                                  // code...
                                  [self runAnimateKeyframes];
                              }];

}

/*
// 开始动画
+ (void)beginAnimations:(NSString *)animationID context:(void *)context;

// 提交动画
+ (void)commitAnimations;

// 设置动画曲线，默认是匀速进行：
+ (void)setAnimationCurve:(UIViewAnimationCurve)curve;

// 设置动画时长：
+ (void)setAnimationDuration:(NSTimeInterval)duration;

// 默认为YES。为NO时跳过动画效果，直接跳到执行后的状态。
+ (void)setAnimationsEnabled:(BOOL)enabled;

// 设置动画延迟执行（delay：秒为单位）：
+ (void)setAnimationDelay:(NSTimeInterval)delay;

// 动画的重复播放次数
+ (void)setAnimationRepeatCount:(float)repeatCount;

// 如果为YES，逆向（相反）动画效果，结束后返回动画逆向前的状态; 默认为NO：
+ (void)setAnimationRepeatAutoreverses:(BOOL)repeatAutoreverses;

// 设置动画代理：
+ (void)setAnimationDelegate:(id)delegate;

// 动画将要开始时执行方法××（必须要先设置动画代理）：
+ (void)setAnimationWillStartSelector:(SEL)selector;

// 动画已结束时执行方法××（必须要先设置动画代理）：
+ (void)setAnimationDidStopSelector:(SEL)selector;


   设置动画过渡效果
 
   @param transition 动画的过渡效果
   @param view 过渡效果作用视图
   @param cache 如果为YES，开始和结束视图分别渲染一次并在动画中创建帧；否则，视图将会渲染每一帧。例如，你不需要在视图转变中不停的更新，你只需要等到转换完成再去更新视图。
 
+ (void)setAnimationTransition:(UIViewAnimationTransition)transition forView:(UIView *)view cache:(BOOL)cache;

// 删除所有动画层
// 注意：层指的是layout，例：[_imageView.layer removeAllAnimations];
- (void)removeAllAnimations;
*/

#pragma mark - 使用UIView的动画代码块
/*
 方法一:
 [UIView animateWithDuration:4.0 // 动画时长
 animations:^{
 // code
 }];
 */

/*
 方法二:
 [UIView animateWithDuration:4.0 // 动画时长
 animations:^{
 // code...
 }
 completion:^(BOOL finished) {
 // 动画完成后执行
 // code...
 }];
 */

/*
 方法三:
 [UIView animateWithDuration:4.0 // 动画时长
 delay:2.0 // 动画延迟
 options:UIViewAnimationOptionCurveEaseIn // 动画过渡效果
 animations:^{
 // code...
 }
 completion:^(BOOL finished) {
 // 动画完成后执行
 // code...
 }];
 */


/*
 方法四:
 [UIView animateWithDuration:4.0 // 动画时长
 delay:0.0 // 动画延迟
 usingSpringWithDamping:1.0 // 类似弹簧振动效果 0~1
 initialSpringVelocity:5.0 // 初始速度
 options:UIViewAnimationOptionCurveEaseInOut // 动画过渡效果
 animations:^{
 // code...
 CGPoint point = _imageView.center;
 point.y += 150;
 [_imageView setCenter:point];
 } completion:^(BOOL finished) {
 // 动画完成后执行
 // code...
 [_imageView setAlpha:1];
 }]; 
 
 
 usingSpringWithDamping：它的范围为 0.0f 到 1.0f ，数值越小「弹簧」的振动效果越明显。
 
 initialSpringVelocity：初始的速度，数值越大一开始移动越快。值得注意的是，初始速度取值较高而时间较短时，也会出现反弹情况。
 
 转：Spring Animation 是线性动画或 ease-out 动画的理想替代品。由于 iOS 本身大量使用的就是 Spring Animation，用户已经习惯了这种动画效果，因此使用它能使 App 让人感觉更加自然，用 Apple 的话说就是「instantly familiar」。此外，Spring Animation 不只能对位置使用，它适用于所有可被添加动画效果的属性。
 */

/*
 方法五:
 
 UIView动画已经具备高级的方法来创建动画，而且可以更好地理解和构建动画。IOS7以后苹果新加了一个animateKeyframesWithDuration的方法，我们可以使用它来创建更多更复杂更酷炫的动画效果，而不需要去使用到核心动画（CoreAnimatino）。
 
 创建关键帧方法：
 
 
    添加关键帧方法
 
    @param duration   动画时长
    @param delay      动画延迟
    @param options    动画效果选项
    @param animations 动画执行代码
    @param completion 动画结束执行代码
 
+ (void)animateKeyframesWithDuration:(NSTimeInterval)duration
                               delay:(NSTimeInterval)delay
                             options:(UIViewKeyframeAnimationOptions)options
                          animations:(void (^)(void))animations
                          completion:(void (^)(BOOL finished))completion;

 
 
 添加关键帧方法：
 
   添加关键帧
 
   @param frameStartTime 动画相对开始时间
   @param frameDuration  动画相对持续时间
   @param animations     动画执行代码
 
+ (void)addKeyframeWithRelativeStartTime:(double)frameStartTime
                        relativeDuration:(double)frameDuration
                              animations:(void (^)(void))animations;
 
 
 
 以上说的相对时间，也就是说：“它们自身会根据动画总持续时长自动匹配其运行时长”。
 
 下面用一个简单的示例作解答，彩虹变化视图：
 
 void (^keyFrameBlock)() = ^(){
 // 创建颜色数组
 NSArray *arrayColors = @[[UIColor orangeColor],
 [UIColor yellowColor],
 [UIColor greenColor],
 [UIColor blueColor],
 [UIColor purpleColor],
 [UIColor redColor]];
 NSUInteger colorCount = [arrayColors count];
 // 循环添加关键帧
 for (NSUInteger i = 0; i < colorCount; i++) {
 [UIView addKeyframeWithRelativeStartTime:i / (CGFloat)colorCount
 relativeDuration:1 / (CGFloat)colorCount
 animations:^{
 [_graduallyView setBackgroundColor:arrayColors[i]];
 }];
 }
 };
 [UIView animateKeyframesWithDuration:4.0
 delay:0.0
 options:UIViewKeyframeAnimationOptionCalculationModeCubic | UIViewAnimationOptionCurveLinear
 animations:keyFrameBlock
 completion:^(BOOL finished) {
 // 动画完成后执行
 // code...
 }];
 
 动画过渡效果（Options），新增了以下几个：
 
 UIViewKeyframeAnimationOptionCalculationModeLinear     = 0 << 10, // default
 UIViewKeyframeAnimationOptionCalculationModeDiscrete   = 1 << 10,
 UIViewKeyframeAnimationOptionCalculationModePaced      = 2 << 10,
 UIViewKeyframeAnimationOptionCalculationModeCubic      = 3 << 10,
 UIViewKeyframeAnimationOptionCalculationModeCubicPaced = 4 << 10
 
 
 运行效果
 补充--动画设置参数
 在动画方法中有一个option参数，UIViewAnimationOptions类型，它是一个枚举类型，动画参数分为三类，可以组合使用：
 1.常规动画属性设置（可以同时选择多个进行设置）
 UIViewAnimationOptionLayoutSubviews：动画过程中保证子视图跟随运动。
 UIViewAnimationOptionAllowUserInteraction：动画过程中允许用户交互。
 UIViewAnimationOptionBeginFromCurrentState：所有视图从当前状态开始运行。
 UIViewAnimationOptionRepeat：重复运行动画。
 UIViewAnimationOptionAutoreverse ：动画运行到结束点后仍然以动画方式回到初始点。
 UIViewAnimationOptionOverrideInheritedDuration：忽略嵌套动画时间设置。
 UIViewAnimationOptionOverrideInheritedCurve：忽略嵌套动画速度设置。
 UIViewAnimationOptionAllowAnimatedContent：动画过程中重绘视图（注意仅仅适用于转场动画）。
 UIViewAnimationOptionShowHideTransitionViews：视图切换时直接隐藏旧视图、显示新视图，而不是将旧视图从父视图移除（仅仅适用于转场动画）
 UIViewAnimationOptionOverrideInheritedOptions ：不继承父动画设置或动画类型。
 2.动画速度控制（可从其中选择一个设置）
 UIViewAnimationOptionCurveEaseInOut：动画先缓慢，然后逐渐加速。
 UIViewAnimationOptionCurveEaseIn ：动画逐渐变慢。
 UIViewAnimationOptionCurveEaseOut：动画逐渐加速。
 UIViewAnimationOptionCurveLinear ：动画匀速执行，默认值。
 3.转场类型（仅适用于转场动画设置，可以从中选择一个进行设置，基本动画、关键帧动画不需要设置）
 UIViewAnimationOptionTransitionNone：没有转场动画效果。
 UIViewAnimationOptionTransitionFlipFromLeft ：从左侧翻转效果。
 UIViewAnimationOptionTransitionFlipFromRight：从右侧翻转效果。
 UIViewAnimationOptionTransitionCurlUp：向后翻页的动画过渡效果。
 UIViewAnimationOptionTransitionCurlDown ：向前翻页的动画过渡效果。
 UIViewAnimationOptionTransitionCrossDissolve：旧视图溶解消失显示下一个新视图的效果。
 UIViewAnimationOptionTransitionFlipFromTop ：从上方翻转效果。
 UIViewAnimationOptionTransitionFlipFromBottom：从底部翻转效果。
 
 
 补充--动画设置参数
 对于关键帧动画也有一些动画参数设置options，UIViewKeyframeAnimationOptions类型，和上面基本动画参数设置有些差别，关键帧动画设置参数分为两类，可以组合使用：
 1.常规动画属性设置（可以同时选择多个进行设置）
 UIViewAnimationOptionLayoutSubviews：动画过程中保证子视图跟随运动。
 UIViewAnimationOptionAllowUserInteraction：动画过程中允许用户交互。
 UIViewAnimationOptionBeginFromCurrentState：所有视图从当前状态开始运行。
 UIViewAnimationOptionRepeat：重复运行动画。
 UIViewAnimationOptionAutoreverse ：动画运行到结束点后仍然以动画方式回到初始点。
 UIViewAnimationOptionOverrideInheritedDuration：忽略嵌套动画时间设置。
 UIViewAnimationOptionOverrideInheritedOptions ：不继承父动画设置或动画类型。
 2.动画模式设置（同前面关键帧动画动画模式一一对应，可以从其中选择一个进行设置）
 UIViewKeyframeAnimationOptionCalculationModeLinear：连续运算模式。
 UIViewKeyframeAnimationOptionCalculationModeDiscrete ：离散运算模式。
 UIViewKeyframeAnimationOptionCalculationModePaced：均匀执行运算模式。
 UIViewKeyframeAnimationOptionCalculationModeCubic：平滑运算模式。
 UIViewKeyframeAnimationOptionCalculationModeCubicPaced：平滑均匀运算模式。
 注意：前面说过关键帧动画有两种形式，上面演示的是属性值关键帧动画，路径关键帧动画目前UIView还不支持。
 转场动画
 
 */






/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
