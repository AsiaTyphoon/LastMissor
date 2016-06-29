//
//  HXProgress.m
//  LastMissor
//
//  Created by HXjiang on 16/6/29.
//  Copyright © 2016年 JiangLin. All rights reserved.
//

#import "HXProgress.h"

@interface HXProgress ()

@end


@implementation HXProgress

+ (instancetype)sharedProgress {
    
    static HXProgress *progress = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        progress = [[HXProgress alloc] init];
    });
    
    return progress;
}

- (id)init {
    
    if (self = [super init]) {
        
    }
    
    return self;
}

+ (void)showProgressWithSize:(CGSize)size {
    
    CGFloat w = size.width;
    CGFloat h = size.height;
    
    UIWindow *window  = [[UIApplication sharedApplication].windows objectAtIndex:0];

    HXProgress *p = [HXProgress sharedProgress];
    
    while (p.subviews.lastObject != nil) {
        [(UIView *)p.subviews.lastObject removeFromSuperview];
    }
    
    p.frame = CGRectMake(0, 0, w, h);
    p.center = window.center;
    p.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
    p.clipsToBounds = YES;
    p.layer.cornerRadius = 5.0f;
    
    UIActivityIndicatorView *activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    activity.center = CGPointMake(w/2, h/2);
    [activity startAnimating];
    
    [p addSubview:activity];

    [window addSubview:p];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [activity stopAnimating];
        
        UIButton *btnDismiss = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, w, h)];
        btnDismiss.titleLabel.font = [UIFont systemFontOfSize:14];
        [btnDismiss setTitle:@"Time out!" forState:UIControlStateNormal];
        [btnDismiss setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btnDismiss addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        [p addSubview:btnDismiss];
        
    });
}

+ (void)showProgressWithSize:(CGSize)size timeOut:(NSTimeInterval)time {
    
    CGFloat w = size.width;
    CGFloat h = size.height;
    
    UIWindow *window  = [[UIApplication sharedApplication].windows objectAtIndex:0];
    
    HXProgress *p = [HXProgress sharedProgress];
    
    while (p.subviews.lastObject != nil) {
        [(UIView *)p.subviews.lastObject removeFromSuperview];
    }
    
    p.frame = CGRectMake(0, 0, w, h);
    p.center = window.center;
    p.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
    p.clipsToBounds = YES;
    p.layer.cornerRadius = 5.0f;
    
    UIActivityIndicatorView *activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    activity.center = CGPointMake(w/2, h/2);
    [activity startAnimating];
    
    [p addSubview:activity];
    
    [window addSubview:p];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [activity stopAnimating];
        
        UIButton *btnDismiss = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, w, h)];
        btnDismiss.titleLabel.font = [UIFont systemFontOfSize:14];
        [btnDismiss setTitle:@"Time out!" forState:UIControlStateNormal];
        [btnDismiss setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btnDismiss addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        [p addSubview:btnDismiss];
        
    });

}

+ (void)showText:(NSString *)text withSize:(CGSize)size durationTime:(NSTimeInterval)time {
    
    UIWindow *window  = [[UIApplication sharedApplication].windows objectAtIndex:0];
    
    HXProgress *p = [HXProgress sharedProgress];
    
    CGRect r = [p rectOfText:text WithFont:[UIFont systemFontOfSize:18]];
    CGFloat w = size.width > r.size.width ? size.width : r.size.width;
    CGFloat h = size.height > r.size.height ? size.height : r.size.height;

    while (p.subviews.lastObject != nil) {
        [(UIView *)p.subviews.lastObject removeFromSuperview];
    }
    
    p.frame = CGRectMake(0, 0, w, h);
    p.center = window.center;
    p.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
    p.clipsToBounds = YES;
    p.layer.cornerRadius = 5.0f;
    

    UILabel *l = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, r.size.width, r.size.height)];
    l.text = text;
    l.textColor = [UIColor whiteColor];
    l.textAlignment = NSTextAlignmentCenter;
    l.center = CGPointMake(w/2, h/2);
//    l.backgroundColor = [UIColor greenColor];
    
    [p addSubview:l];
    
    [window addSubview:p];
    
//    NSLog(@"r{%.2f, %.2f, %.2f, %.2f}", r.origin.x, r.origin.y, r.size.width, r.size.height);
    
    NSTimeInterval s = time <= 0 ? 1 : time;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(s * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self dismiss];
    });
    
}

+ (void)dismiss {
    
    for (UIView *view in [[UIApplication sharedApplication].windows objectAtIndex:0].subviews) {
        
        NSLog(@"class:%@", [NSString stringWithUTF8String:object_getClassName(view)]);
        
        if ([view isKindOfClass:[HXProgress class]]) {
            
            [view removeFromSuperview];
            break;
        }
    }

//    HXProgress *p = [HXProgress sharedProgress];
//    [p removeFromSuperview];
    
}


#pragma mark -
- (CGRect)rectOfText:(NSString *)text WithFont:(UIFont *)font
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    //    NSLog(@"text:%@", text);
    NSDictionary *attributesDic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle.copy};
    CGSize size = CGSizeMake([UIScreen mainScreen].bounds.size.width-20, CGFLOAT_MAX);
    CGRect rect = [text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attributesDic context:nil];
    //    NSLog(@"text.width:%f", rect.size.width);
    //    NSLog(@"text.height:%f", rect.size.height);
    
    return rect;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
