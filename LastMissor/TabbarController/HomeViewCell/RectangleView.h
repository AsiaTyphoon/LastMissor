//
//  RectangleView.h
//  LastMissor
//
//  Created by HXjiang on 16/6/18.
//  Copyright © 2016年 JiangLin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RectangleViewDelegate <NSObject>

@optional   //可以不实现
- (void)didClickBtnWithDictionary:(NSDictionary *)dic;


@end

@interface RectangleView : UIView

@property (nonatomic, assign) id<RectangleViewDelegate> delegate;

- (id)initWithFrame:(CGRect)frame WithArray:(NSArray *)dicArray;

@end
