//
//  PicturesLoop.m
//  管理系统
//
//  Created by haixinweishi on 16/1/8.
//  Copyright © 2016年 SanMao. All rights reserved.
//

#import "PicturesLoop.h"

typedef NS_ENUM(NSInteger, UIScrollViewTag) {
    UIScrollViewTagPicturesLoop,
    UIScrollViewTagDetails,
};

@interface PicturesLoop ()<UIScrollViewDelegate, UIScrollViewAccessibilityDelegate>
{
    CGFloat pageW;
    CGFloat pageH;
    
    NSInteger imageindex;
    NSTimer *timer;
    
    BOOL isNavigationBarHidden;
}

//书签控制图片轮播
@property (strong, nonatomic) NSArray *imagearray;
@property (strong, nonatomic) UIScrollView *imagescroll;
@property (strong, nonatomic) UIImageView *imageleft;
@property (strong, nonatomic) UIImageView *imagecenter;
@property (strong, nonatomic) UIImageView *imageright;
@property (strong, nonatomic) UIPageControl *pagecontrol;

//图片滑动展示详情
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) NSArray *titlearray;
@property (strong, nonatomic) NSArray *detailarray;
@property (strong, nonatomic) UILabel *countLable;
@property (strong, nonatomic) UILabel *detailLable;


@end

@implementation PicturesLoop


#pragma mark - 2016.01.09 图片查看////////////
- (id)initWithFrame:(CGRect)frame WithImages:(NSArray *)imageArray WithTitle:(NSArray *)titleArray WithDetail:(NSArray *)detailArray
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.imagearray  = [NSArray arrayWithArray:imageArray];
        self.titlearray  = [NSArray arrayWithArray:titleArray];
        self.detailarray = [NSArray arrayWithArray:detailArray];

        [self presentScrollView];
    }
    return self;
}

- (void)presentScrollView
{
    
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenH = [UIScreen mainScreen].bounds.size.height;
    
    CGFloat lableW = 200;
    CGFloat lableH = 50;
    CGFloat lableX = (screenW - lableW)/2;
    CGFloat lableY = 20 + 64;
    
    CGFloat detailX = 20;
    CGFloat detailY = screenH - 150;
    CGFloat detailW = screenW - detailX*2;
    CGFloat detailH = 150;
    
    CGFloat imageX = 0;
    CGFloat imageY = lableY + 10 + lableH;
    CGFloat imageW = screenW - imageX*2;
    CGFloat imageH = screenH - detailH - lableY - lableH;
    NSLog(@"imageY:%f", imageY);
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(imageX, imageY, imageW, imageH)];
//    self.scrollView.backgroundColor = [UIColor blackColor];
    self.scrollView.delegate = self;
    self.scrollView.tag = UIScrollViewTagDetails;
    [self addSubview:self.scrollView];
    
    //添加单击手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureRecognizer:)];
    [self addGestureRecognizer:tap];
    
    
    
    for (int i = 0; i < self.imagearray.count; i++) {
        //lable
        //        UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(lableX + (lableW + 2*lableX)*i , lableY, lableW, lableH)];
        //        lable.backgroundColor = [UIColor redColor];
        //        [self.scrollView addSubview:lable];
        //        lable.text = [NSString stringWithFormat:@"%d/%ld", i + 1, self.imageArray.count];
        //        lable.textAlignment = NSTextAlignmentCenter;
        //        lable.textColor = [UIColor whiteColor];
        
        //imageview
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(imageX + (imageW + 2*imageX)*i, 0, imageW, imageH)];
        //        imageView.backgroundColor = [UIColor orangeColor];
        [self.scrollView addSubview:imageView];
        imageView.image = [UIImage imageNamed:[self.imagearray objectAtIndex:i]];
        
        //detail
        //        UILabel *detail = [[UILabel alloc] initWithFrame:CGRectMake(detailX + (detailW + 2*detailX)*i, detailY, detailW, detailH)];
        //        detail.backgroundColor = [UIColor greenColor];
        //        [self.scrollView addSubview:detail];
        //        detail.text = [self.detailArray objectAtIndex:i];
        //        detail.textColor = [UIColor whiteColor];
    }
    
    self.scrollView.contentSize = CGSizeMake(screenW*self.imagearray.count, 0);
    self.scrollView.pagingEnabled = YES;
    
    
    self.countLable = [[UILabel alloc] initWithFrame:CGRectMake(lableX, lableY, lableW, lableH)];
    //    lable.backgroundColor = [UIColor redColor];
    [self addSubview:self.countLable];
    self.countLable.text = [NSString stringWithFormat:@"%d/%ld", 1, self.imagearray.count];
    self.countLable.textAlignment = NSTextAlignmentCenter;
    self.countLable.textColor     = [UIColor whiteColor];
    
    
    self.detailLable = [[UILabel alloc] initWithFrame:CGRectMake(detailX, detailY, detailW, detailH)];
    //    detail.backgroundColor = [UIColor greenColor];
    [self addSubview:self.detailLable];
    self.detailLable.text = [self.detailarray objectAtIndex:0];
    self.detailLable.textColor = [UIColor whiteColor];
    
    
}

- (void)tapGestureRecognizer:(UITapGestureRecognizer *)tap
{
    isNavigationBarHidden = !isNavigationBarHidden;
//    self.navigationController.navigationBarHidden = isNavigationBarHidden;
    [[UIApplication sharedApplication] setStatusBarHidden:isNavigationBarHidden withAnimation:UIStatusBarAnimationSlide];
}


#pragma mark - 2016.01.08 图片轮播功能///////////////////
- (id)initWithFrame:(CGRect)frame WithImages:(NSArray *)imageArray
{
    self = [super initWithFrame:frame];
    if (self) {
        
        imageindex = 0;
        pageW = frame.size.width;
        pageH = frame.size.height;
        self.imagearray = [NSArray arrayWithArray:imageArray];
        
        [self presentUIScrollViewWithFrame];
        [self presentUIImageView];
        [self presentUIPageControl];
        
        [self startTimerWithTimeInterval:0];
    }
    return self;
}


- (void)presentUIScrollViewWithFrame
{
    CGRect frame = CGRectZero;
    frame.size.width  = pageW;
    frame.size.height = pageH;
    
    self.imagescroll = [[UIScrollView alloc] initWithFrame:frame];
    self.imagescroll.delegate = self;
    self.imagescroll.contentSize = CGSizeMake(pageW * self.imagearray.count, pageH);
    self.imagescroll.pagingEnabled = YES;
    self.imagescroll.bounces = NO;
    self.imagescroll.showsHorizontalScrollIndicator = NO;
    self.imagescroll.showsVerticalScrollIndicator = NO;

    [self addSubview:self.imagescroll];
}

- (void)presentUIImageView
{
    
    for (NSInteger i = 0; i < self.imagearray.count; i++)
    {
        CGRect frame = CGRectMake(i * pageW, 0, pageW, pageH);

        if (i == 0)
        {
            self.imageleft   = [self editWithFrame:frame WithImage:[self.imagearray objectAtIndex:i]];
        }
        if (i == 1)
        {
            self.imagecenter = [self editWithFrame:frame WithImage:[self.imagearray objectAtIndex:i]];
        }
        if (i == 2)
        {
            self.imageright  = [self editWithFrame:frame WithImage:[self.imagearray objectAtIndex:i]];
        }
    }
}

- (UIImageView *)editWithFrame:(CGRect)frame WithImage:(NSString *)imagepath
{
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
    imageView.image = [self imageAlwaysOriginal:imagepath];
    [self.imagescroll addSubview:imageView];
    
    return imageView;
}

#pragma mark -- 设置UIPageControl
- (void)presentUIPageControl
{
    CGRect frame = CGRectZero;
    frame.size.width  = (self.imagearray.count + 2) * 12;
    frame.size.height = 5.0f;
    frame.origin.x    = pageW - frame.size.width;
    frame.origin.y    = pageH - frame.size.height;
    
    self.pagecontrol = [[UIPageControl alloc] initWithFrame:frame];
    self.pagecontrol.numberOfPages = self.imagearray.count;
    self.pagecontrol.currentPage   = imageindex;
    self.pagecontrol.currentPageIndicatorTintColor = [UIColor orangeColor];
    self.pagecontrol.pageIndicatorTintColor = [UIColor whiteColor];
    
    [self addSubview:self.pagecontrol];
}

//设置书签的颜色
- (void)setPagecontrolIndicatorTintColor:(UIColor *)color
{
    self.pagecontrol.pageIndicatorTintColor = color;
}
//设置当前显示书签的颜色
- (void)setPagecontrolCurrentPageIndicatorTintColor:(UIColor *)color
{
    self.pagecontrol.currentPageIndicatorTintColor = color;
}
//是否隐藏书签
- (void)setPagecontrolHidden:(BOOL)hide
{
    self.pagecontrol.hidden = hide;
}
//设置书签的frame
- (void)setpagecontrolFrame:(CGRect)frame
{
    self.pagecontrol.frame = frame;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView.tag == UIScrollViewTagDetails)
    {
        CGFloat pageWidth = scrollView.frame.size.width;
        
        int page = floor((scrollView.contentOffset.x - pageWidth/2)/pageWidth) + 1 + 1;
        
        self.countLable.text  = [NSString stringWithFormat:@"%d/%ld", page, self.imagearray.count];
        self.detailLable.text = [NSString stringWithFormat:@"这是图片 %d ", page];    }
    
    if (scrollView.tag == UIScrollViewTagPicturesLoop)
    {
        [self presentPicturesLoopView];
    }
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self deleteTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self startTimerWithTimeInterval:0];
}

#pragma mark - NSTimer
#pragma mark -- 删除定时器
- (void)deleteTimer
{
    if (timer)
    {
        [timer invalidate];
    }
}

#pragma mark -- 开启定时器
- (void)startTimerWithTimeInterval:(NSTimeInterval)seconds
{
    NSTimeInterval detaultSecond = 2;
    if (seconds < detaultSecond)
    {
        seconds = detaultSecond;
    }
    
    timer = [NSTimer scheduledTimerWithTimeInterval:seconds target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
}

#pragma mark -- 定时器响应事件
- (void)timerAction
{
    self.imagescroll.contentOffset = CGPointMake(pageW, 0);
    [self presentPicturesLoopView];
}

#pragma mark - Others
#pragma mark -- 更换视图
- (void)presentPicturesLoopView
{
    if (self.imagearray.count == 0) {
        NSLog(@"self.imagearray.count == 0");
        return;
    }
    
    /*
     *  判断 scrollView 的contentoffset
     *  若是大于 每页的宽度，向右滑动，则将imageindex ＋ 1
     *  若是小于 每页的宽度，向左滑动，则将imageindex － 1
     */
    CGPoint offset = self.imagescroll.contentOffset;
    
    if (offset.x >= pageW)
    {
        imageindex = (imageindex + 1) % self.imagearray.count;
    }
    if (offset.x < pageW)
    {
        imageindex = (imageindex - 1 + self.imagearray.count) % self.imagearray.count;
    }
  
    [self setupImageAtIndex:imageindex];
}

- (void)setupImageAtIndex:(NSInteger)imageIndex
{
    
    /*
     *  初始化3个imageview 滚动动作完成后始终显示中间的imageview
     *  self.imagescroll.contentOffset = CGPointMake(pageW, 0);
     */
    
    /*
     *  根据imageindex 加载中间imageview的图片
     *
     *  根据imageindex算出左边的index，然后加载左边的图片
     *  NSUInteger imageIndexleft  = (imageIndex - 1 + self.imagearray.count) % self.imagearray.count;
     *
     *  根据imageindex算出右边的index，然后加载右边的图片
     *  NSUInteger imageIndexright = (imageIndex + 1) % self.imagearray.count;
     */
    
    self.imagescroll.contentOffset = CGPointMake(pageW, 0);
    self.pagecontrol.currentPage   = imageindex;

    NSUInteger imageIndexleft  = (imageIndex - 1 + self.imagearray.count) % self.imagearray.count;
    NSUInteger imageIndexright = (imageIndex + 1) % self.imagearray.count;
    
    self.imagecenter.image = [self imageAlwaysOriginal:[self.imagearray objectAtIndex:imageIndex]];
    self.imageleft.image   = [self imageAlwaysOriginal:[self.imagearray objectAtIndex:imageIndexleft]];
    self.imageright.image  = [self imageAlwaysOriginal:[self.imagearray objectAtIndex:imageIndexright]];
}

#pragma mark -- 加载原始小图片
- (UIImage *)imageAlwaysOriginal:(NSString *)imagename
{
    UIImage *image = [UIImage imageNamed:imagename];
    UIImage *imageOriginal = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    /*
     //加载缩略小图
    UIGraphicsGetCurrentContext();
    CGSize size = CGSizeMake(pageW, pageH);
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, pageW, pageH)];
    UIImage *returnImage = UIGraphicsGetImageFromCurrentImageContext();
    */
    
    return imageOriginal;
}

#pragma mark - drawRect
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}


@end
