//
//  B_aViewController.m
//  StoryboardDome
//
//  Created by airende on 16/8/12.
//  Copyright © 2016年 airende. All rights reserved.
//

#import "B_aViewController.h"
#import "WMBlueButton.h"
#import "WMRedButton.h"
#import "WMWhiteButton.h"

@interface B_aViewController ()

@property (nonatomic, strong) WMRedButton * button1;
@property (weak, nonatomic) IBOutlet WMBlueButton *blueButton;
@property (nonatomic, strong)  WMWhiteButton* button2;

@property (nonatomic, strong) UITextField * aaa;


@end

@implementation B_aViewController

- (void)viewDidLoad{
    [super viewDidLoad];//fdaf
    _aaa = [[UITextField alloc] initWithFrame:CGRectMake(50, 70, 250, 30)];
    _aaa.placeholder = @"123";
    _aaa.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:_aaa];
    
    [_aaa addTarget:self action:@selector(canClick) forControlEvents:UIControlEventEditingChanged];
    //sb创建  -------------------------------------------
    _blueButton.valid = NO;
    [_blueButton addTarget:self action:@selector(wmBlueButton) forControlEvents:UIControlEventTouchUpInside];
    
    //手写创建------------------------------------------------
    _button1 = [[WMRedButton alloc] initWithFrame:CGRectMake(100, 100, 100, 50)];
    [_button1 wmButtonWithRounded:4];
    [_button1 wmButtonWithTitle:@"点击"];
    _button1.valid = NO;
    [_button1 addTarget:self action:@selector(clickWMButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_button1];
    
    //手写
    _button2 = [[WMWhiteButton alloc] initWithFrame:CGRectMake(50, 250, 100, 50)];
    [_button2 wmButtonWithTitle:@"黑白"];
    _button2.valid = NO;
    [_button2 addTarget:self action:@selector(clickWhiteButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_button2];
    
}

- (void)wmBlueButton
{
    NSLog(@"=======");
}

- (void)clickWMButton{
    NSLog(@"++++++++");
}

- (void)clickWhiteButton{
    NSLog(@"--------");
}

- (void)canClick{
    
    if (_aaa.text.length > 0) {
        _blueButton.valid = YES;
        _button1.valid = YES;
        _button2.valid = YES;
        
    }else{
        _blueButton.valid = NO;
        _button1.valid = NO;
        _button2.valid = NO;
    }
}

@end
