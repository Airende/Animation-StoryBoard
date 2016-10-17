//
//  WMRedButton.m
//  StoryboardDome
//
//  Created by airende on 16/8/15.
//  Copyright © 2016年 airende. All rights reserved.
//

#import "WMRedButton.h"
#import "UIButton+WMButton.h"

@implementation WMRedButton

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setupView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    
    return self;
}

- (void)wmButtonWithFontSize:(CGFloat)size
{
    [super wmButtonWithFontSize:size];
}

- (void)wmButtonWithTitle:(NSString *)string
{
    [super wmButtonWithTitle:string];
}

- (void)wmButtonWithRounded:(CGFloat)cornerRadius
{
    [super wmButtonWithRounded:cornerRadius];
}

- (void)setupView
{
    [self wmButtonWithTitleColor:[UIColor whiteColor] highlightedTitleColor:[UIColor whiteColor] backgoundColor:[UIColor colorWithRed:242/255.0 green:85/255.0 blue:85/255.0 alpha:1] highlightedBackgoundColor:[UIColor colorWithRed:169/255.0 green:59/255.0 blue:59/255.0 alpha:1]];
    
    [self wmButtonWithFontSize:18];
    [self wmButtonWithRounded:10];
}

- (void)setValid:(BOOL)valid
{
    self.enabled = valid;
    
    [self wmButtonWithValidTitleColor:[UIColor whiteColor] backgoundColor:[UIColor colorWithRed:242/255.0 green:85/255.0 blue:85/255.0 alpha:1]];
    
}

@end
