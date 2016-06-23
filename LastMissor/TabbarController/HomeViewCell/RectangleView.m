//
//  RectangleView.m
//  LastMissor
//
//  Created by HXjiang on 16/6/18.
//  Copyright © 2016年 JiangLin. All rights reserved.
//

#import <objc/runtime.h>
#import "RectangleView.h"

#define objc_setAssociatedButtonKey     (@"objc_setAssociatedButtonKey")

@interface RectangleView ()
{
    CGFloat viewW;
    CGFloat viewH;
    NSInteger lines;
    NSInteger rows;
}

@end

@implementation RectangleView

- (id)initWithFrame:(CGRect)frame WithArray:(NSArray *)dicArray
{
    if (self = [super initWithFrame:frame]) {
        
        viewW = frame.size.width;
        viewH = frame.size.height;
        self.backgroundColor = [UIColor whiteColor];
        rows = 4;
        lines = dicArray.count/rows + (dicArray.count%rows == 0 ? 0 : 1);
        NSLog(@"lines:%ld", lines);
        CGFloat btnW = viewW/rows-1;
        CGFloat btnH = viewH/lines;
        
        for (int i = 0; i < dicArray.count; i++) {
            
            NSInteger lineIndex = i/rows;
            NSInteger rowIndex = i%rows;
            
            CGFloat btnX = btnW*rowIndex;
            CGFloat btnY = btnH*lineIndex;
            
            NSDictionary *dic = (NSDictionary *)[dicArray objectAtIndex:i];
            
            UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(btnX, btnY, btnW, btnH)];
            [button setTitle:dic[@"keyText"] forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:12];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
            button.tag = i;
            objc_setAssociatedObject(button, objc_setAssociatedButtonKey, dic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            [self addSubview:button];
        }
    }
    return self;
    
}//@initWithFrame

- (void)btnAction:(id)sender
{
    UIButton *button = (UIButton *)sender;

    NSDictionary *dic = (NSDictionary *)objc_getAssociatedObject(sender, objc_setAssociatedButtonKey);
    
//    NSLog(@"sender:%@", dic);
//    NSLog(@"button.tag:%ld", button.tag);
    
    if (self.delegate) {
        [self.delegate didClickBtnWithDictionary:dic];
    }
}




// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetRGBStrokeColor(context, 0, 0, 0, 1);
    CGContextSetLineWidth(context, 0.1);
    
    for (int i = 1; i <= rows; i++) {
        
        CGContextMoveToPoint(context, viewW/rows*i, 0);
        CGContextAddLineToPoint(context, viewW/rows*i, viewH);
        CGContextStrokePath(context);
    }

    for (int i = 1; i <= lines; i++) {
        
        CGContextMoveToPoint(context, 0, viewH/lines*i);
        CGContextAddLineToPoint(context, viewW, viewH/lines*i);
        CGContextStrokePath(context);
    }

    

    
}//@drawRect


@end
