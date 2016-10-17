//
//  WMBlueButton.h
//  StoryboardDome
//
//  Created by airende on 16/8/15.
//  Copyright © 2016年 airende. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WMBlueButton : UIButton

@property (nonatomic, assign) BOOL valid;

//字体大小
- (void)wmButtonWithFontSize:(CGFloat)size;
//圆角
- (void)wmButtonWithRounded:(CGFloat)cornerRadius;
//文字
- (void)wmButtonWithTitle:(NSString *)string;

@end
