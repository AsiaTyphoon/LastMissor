//
//  UIImage+Colors.m
//  LastMissor
//
//  Created by HXjiang on 16/7/1.
//  Copyright © 2016年 JiangLin. All rights reserved.
//

#import "UIImage+Colors.h"

@implementation UIImage (Colors)

+ (UIImage *)imageWithColor:(UIColor *)color wihtSize:(CGSize)size {
    
    
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context,color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}

+ (UIImage *)roundImageWithColor:(UIColor *)color wihtSize:(CGSize)size {
    
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context,color.CGColor);
    CGContextSetRGBFillColor(context, 1, 0, 0, 1);
    CGContextSetRGBStrokeColor(context, 1, 1, 1, 1);
//    CGContextSetFillColor(context, color.CGColor);
    CGContextAddArc(context, size.width/2, size.width/2, 5, 0, 2*M_PI, 0);
//    CGContextStrokePath(context);
//    CGContextStrokeEllipseInRect(context, rect);
//    CGContextFillRect(context, rect);
    
    CGContextDrawPath(context, kCGPathFill);
    CGContextAddArc(context, size.width/2, size.width/2, size.width/2, 0, 2*M_PI, 0);
    CGContextDrawPath(context, kCGPathStroke);

    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}


@end
