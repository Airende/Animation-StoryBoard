//
//  UIButton+WMButton.h
//  StoryboardDome
//
//  Created by airende on 16/8/11.
//  Copyright © 2016年 airende. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (WMButton)

/**
 *  @brief 设置圆角和边框
 */
- (void)wmButtonWithRounded:(CGFloat)cornerRadius width:(CGFloat)borderWidth color:(UIColor *)borderColor;

/**
 *  @brief 设置圆角
 */
- (void)wmButtonWithRounded:(CGFloat)cornerRadius;


/**
 *  @brief 字体和大小
 */
- (void)wmButtonWithFont:(UIFont *)font size:(CGFloat)size;

/**
 *  @brief 字体大小
 */
- (void)wmButtonWithFontSize:(CGFloat)size;

/**
 *  @brief 设置文字
 */
- (void)wmButtonWithTitle:(NSString *)string;

/**
 *  设置颜色
 *
 *  @param tcolor 文字常态
 *  @param htcolor 文字高亮
 *  @param bcolor 背景常态
 *  @param hbcolor 背景高亮
 */
- (void)wmButtonWithTitleColor:(UIColor *)tcolor
         highlightedTitleColor:(UIColor *)htcolor
                backgoundColor:(UIColor *)bcolor
     highlightedBackgoundColor:(UIColor *)hbcolor;

/**
 *  字体颜色
 *
 *  @param color   常态
 *  @param hlColor 高亮
 */
- (void)wmButtonWithTitleColor:(UIColor *)color highlightedColor:(UIColor *)hlColor;

/**
 *  背景
 *
 *  @param color   常态
 *  @param hlColor 高亮
 */
- (void)wmButtonWithBackgoundColor:(UIColor *)color highlightedColor:(UIColor *)hlColor;
/**
 *  常态
 *
 *  @param tcolor 文字
 *  @param bcolor 背景
 */
- (void)wmButtonWithTitleColor:(UIColor *)tcolor backgoundColor:(UIColor *)bcolor;
/**
 *  高亮
 *
 *  @param htcolor 文字
 *  @param hbcolor 背景
 */
- (void)wmButtonWithHighlightedTitleColor:(UIColor *)htcolor highlightedBackgoundColor:(UIColor *)hbcolor;

/**
 *  可点击状态<不可点击状态下都是一样的>
 *
 *  @param tcolor 文字颜色
 *  @param bcolor 背景颜色
 */
- (void)wmButtonWithValidTitleColor:(UIColor *)tcolor backgoundColor:(UIColor *)bcolor;
@end
