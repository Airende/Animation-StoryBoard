//
//  UIButton+WMButton.m
//  StoryboardDome
//
//  Created by airende on 16/8/11.
//  Copyright © 2016年 airende. All rights reserved.
//

#import "UIButton+WMButton.h"

@implementation UIButton (WMButton)


//圆角、边框、边框颜色
- (void)wmButtonWithRounded:(CGFloat)cornerRadius width:(CGFloat)borderWidth color:(UIColor *)borderColor
{
    self.layer.cornerRadius = cornerRadius;
    self.layer.borderWidth = borderWidth;
    self.layer.borderColor = [borderColor CGColor];
    self.layer.masksToBounds = YES;
}

//圆角
- (void)wmButtonWithRounded:(CGFloat)cornerRadius
{
    [self wmButtonWithRounded:cornerRadius width:0 color:nil];
}

//字体、字体大小
- (void)wmButtonWithFont:(UIFont *)font size:(CGFloat)size;
{
    self.titleLabel.font = [UIFont systemFontOfSize:size];
    self.titleLabel.font = font;
}

//字体大小
- (void)wmButtonWithFontSize:(CGFloat)size
{
    self.titleLabel.font = [UIFont systemFontOfSize:size];
}

//设置文字
- (void)wmButtonWithTitle:(NSString *)string
{
    [self setTitle:string forState:UIControlStateNormal];
}

//常态文字颜色、高亮文字颜色、常态背景颜色、高亮背景颜色
- (void)wmButtonWithTitleColor:(UIColor *)tcolor
         highlightedTitleColor:(UIColor *)htcolor
                backgoundColor:(UIColor *)bcolor
     highlightedBackgoundColor:(UIColor *)hbcolor
{
    [self setTitleColor:tcolor forState:UIControlStateNormal];
    [self setTitleColor:htcolor forState:UIControlStateHighlighted];
    self.backgroundColor = bcolor;
    [self setBackgroundImage:[self imageWithColor:hbcolor] forState:UIControlStateHighlighted];
}

//文字颜色常态、高亮
- (void)wmButtonWithTitleColor:(UIColor *)color highlightedColor:(UIColor *)hlColor
{
    [self setTitleColor:color forState:UIControlStateNormal];
    [self setTitleColor:hlColor forState:UIControlStateHighlighted];
}

//背景颜色常态、高亮
- (void)wmButtonWithBackgoundColor:(UIColor *)color highlightedColor:(UIColor *)hlColor
{
    self.backgroundColor = color;
    [self setBackgroundImage:[self imageWithColor:hlColor] forState:UIControlStateHighlighted];
}

//常态颜色文字、背景
- (void)wmButtonWithTitleColor:(UIColor *)tcolor backgoundColor:(UIColor *)bcolor
{
    
    [self setTitleColor:tcolor forState:UIControlStateNormal];
    self.backgroundColor = bcolor;

}

//高亮颜色文字、背景
- (void)wmButtonWithHighlightedTitleColor:(UIColor *)htcolor highlightedBackgoundColor:(UIColor *)hbcolor
{
    [self setTitleColor:htcolor forState:UIControlStateHighlighted];
    [self setBackgroundImage:[self imageWithColor:hbcolor] forState:UIControlStateHighlighted];
}

- (void)wmButtonWithValidTitleColor:(UIColor *)tcolor backgoundColor:(UIColor *)bcolor
{
    if (self.enabled) {
        
        [self wmButtonWithTitleColor:tcolor backgoundColor:bcolor];
    }else{
        
        [self wmButtonWithTitleColor:[UIColor colorWithRed:167/255.0 green:167/255.0 blue:167/255.0 alpha:1] backgoundColor:[UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1]];
    }
}

- (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
