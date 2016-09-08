//
//  UILabel+TextAlignment.m
//  LastMissor
//
//  Created by HXjiang on 16/9/8.
//  Copyright © 2016年 JiangLin. All rights reserved.
//

#import "UILabel+TextAlignment.h"

@implementation UILabel (TextAlignment)

- (void)setTextAlignmentTop {
 
    CGSize size = [self.text sizeWithAttributes:@{NSFontAttributeName:self.font}];
    CGRect rect = [self.text boundingRectWithSize:CGSizeMake(self.frame.size.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.font} context:nil];
    self.numberOfLines = 0;//为了添加\n必须为0
    NSInteger newLinesToPad = (self.frame.size.height - rect.size.height)/size.height;
    
    for (NSInteger i = 0; i < newLinesToPad; i ++) {
        self.text = [self.text stringByAppendingString:@"\n "];
    }
}

- (void)setTextAlignmentBottom {
    
    CGSize size = [self.text sizeWithAttributes:@{NSFontAttributeName:self.font}];
    CGRect rect = [self.text boundingRectWithSize:CGSizeMake(self.frame.size.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.font} context:nil];
    self.numberOfLines = 0;//为了添加\n必须为0
    NSInteger newLinesToPad = (self.frame.size.height - rect.size.height)/size.height;
    
    for (NSInteger i = 0; i < newLinesToPad; i ++) {
        self.text = [NSString stringWithFormat:@" \n%@",self.text];
    }
}

@end
