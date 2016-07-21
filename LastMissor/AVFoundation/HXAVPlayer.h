//
//  HXAVPlayer.h
//  CamHi
//
//  Created by HXjiang on 16/6/22.
//  Copyright © 2016年 ouyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HXAVPlayer : UIView

- (id)initWithFrame:(CGRect)frame withURL:(NSURL *)url;
- (void)play;
- (void)pause;
- (void)playNextURL:(NSURL *)nextUrl;
- (void)fastForward;
- (void)fastBack;
- (void)dismiss;


@end
