//
//  WMWhiteButton.m
//  StoryboardDome
//
//  Created by airende on 16/8/15.
//  Copyright © 2016年 airende. All rights reserved.
//

#import "WMWhiteButton.h"
#import "UIButton+WMButton.h"

@implementation WMWhiteButton

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
    [self wmButtonWithTitleColor:[UIColor colorWithRed:26/255.0 green:26/255.0 blue:26/255.0 alpha:1] highlightedTitleColor:[UIColor colorWithRed:26/255.0 green:26/255.0 blue:26/255.0 alpha:1] backgoundColor:[UIColor whiteColor] highlightedBackgoundColor:[UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1]];
    
    [self wmButtonWithFontSize:18];
    [self wmButtonWithRounded:4 width:1 color:[UIColor colorWithRed:167/255.0 green:167/255.0 blue:167/255.0 alpha:1]];
}

- (void)setValid:(BOOL)valid
{
    self.enabled = valid;
    
    [self wmButtonWithValidTitleColor:[UIColor colorWithRed:26/255.0 green:26/255.0 blue:26/255.0 alpha:1] backgoundColor:[UIColor whiteColor]];
    
}


@end
