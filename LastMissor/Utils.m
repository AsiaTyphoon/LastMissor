//
//  Utils.m
//  Medical_Wisdom
//
//  Created by Mac on 14-1-26.
//  Copyright (c) 2014年 NanJingXianLang. All rights reserved.
//

#import "Utils.h"

#import "AppDelegate.h"

@implementation Utils

/*
 AppDelegate
 */
+ (AppDelegate *)applicationDelegate
{
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

+ (UIImageView *)imageViewWithFrame:(CGRect)frame withImage:(UIImage *)image{
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
    imageView.image = image;
    return nil;
}

+ (UILabel *)labelWithFrame:(CGRect)frame withTitle:(NSString *)title titleFontSize:(UIFont *)font textColor:(UIColor *)color backgroundColor:(UIColor *)bgColor alignment:(NSTextAlignment)textAlignment{
    
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.text = title;
    label.font = font;
    label.textColor = color;
    label.backgroundColor = bgColor;
    label.textAlignment = textAlignment;
    return nil;
    
}


//alertView
+(UIAlertView *)alertTitle:(NSString *)title message:(NSString *)msg delegate:(id)aDeleagte cancelBtn:(NSString *)cancelName otherBtnName:(NSString *)otherbuttonName{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:msg delegate:aDeleagte cancelButtonTitle:cancelName otherButtonTitles:otherbuttonName, nil];
    [alert show];
    return nil;
}

+(UIButton *)createBtnWithType:(UIButtonType)btnType frame:(CGRect)btnFrame backgroundColor:(UIColor*)bgColor{
    UIButton *btn = [UIButton buttonWithType:btnType];
    btn.frame = btnFrame;
    [btn setBackgroundColor:bgColor];
    return btn;
}

//利用正则表达式验证邮箱的合法性
+(BOOL)isValidateEmail:(NSString *)email {
    
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
    
}
//利用正则表达式验证用户名的合法性
+ (BOOL)validateUserName:(NSString *)name
{
    
    NSString *userNameRegex = @"^[A-Za-z0-9]{6,20}+$";
    NSPredicate *userNamePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",userNameRegex];
    BOOL B = [userNamePredicate evaluateWithObject:name];
    return B;
}
//利用正则表达式验证手机号码的合法性
+ (BOOL)validatePhone:(NSString *)phone
{
    NSString *phoneRegex = @"1[3|5|7|8|][0-9]{9}";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    return [phoneTest evaluateWithObject:phone];
}


//利用正则表达式验证手机验证码的合法性
+ (BOOL)validatecaptcha:(NSString *)captcha
{
    NSString *captchaRegex = @"[0-9]{4,6}";
    NSPredicate *captchaTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", captchaRegex];
    return [captchaTest evaluateWithObject:captcha];
}
//利用正则表达式验证昵称的合法性
+ (BOOL) validateNickname:(NSString *)nickname
{
        
        NSString *nicknameRegex = @"^[\u4e00-\u9fa5]{4,8}$";
        
        NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",nicknameRegex];
        
        return [passWordPredicate evaluateWithObject:nickname];
        
}
//利用正则表达式验证密码的合法性
+ (BOOL) validatePassword:(NSString *)passWord

{
    
    NSString *passWordRegex = @"^[a-zA-Z0-9]{6,16}+$";
    
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    
    return [passWordPredicate evaluateWithObject:passWord];
    
}
//字符串转字节
- (Byte)strEndMinute:(NSString *)endMinute {
    // 转成 int  类型
    int endMinutes = [endMinute intValue];
    Byte endMinuteByte = (Byte)0xff&endMinutes;
    return endMinuteByte;
}
@end
