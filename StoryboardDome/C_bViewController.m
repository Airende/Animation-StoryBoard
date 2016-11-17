//
//  C_bViewController.m
//  StoryboardDome
//
//  Created by airende on 16/8/24.
//  Copyright © 2016年 airende. All rights reserved.
//

#import "C_bViewController.h"


@interface C_bViewController ()
@property (weak, nonatomic) IBOutlet UIView *layerView;
@property (weak, nonatomic) IBOutlet UIButton *changeButton;

@property (nonatomic, strong) CALayer * colorLayer;


@end

@implementation C_bViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    _colorLayer = [CALayer layer];
    _colorLayer.frame = CGRectMake(50, 8, 100, 100);
    _colorLayer.backgroundColor = [UIColor blueColor].CGColor;
    
    /*
    //改变动画的过渡形式
    CATransition *transition = [CATransition animation];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromLeft;
    _colorLayer.actions = @{@"backgroundColor": transition};
    */
    
    
    [self.layerView.layer addSublayer:_colorLayer];
    
}
- (IBAction)changeColor:(id)sender {
    
    [CATransaction begin];                      //开始一个事物
    [CATransaction setAnimationDuration:1];     //设置动画时间
    
    
    CGFloat red = arc4random() / (CGFloat)INT_MAX;
    CGFloat green = arc4random() / (CGFloat)INT_MAX;
    CGFloat blue = arc4random() / (CGFloat)INT_MAX;
    
    CGFloat X = arc4random()%100+1;
    CGFloat Y = arc4random()%100+1;
    CGFloat w = arc4random()%100+1;
    CGFloat h = arc4random()%100+1;
    
    _colorLayer.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1].CGColor;
    
    _colorLayer.frame = CGRectMake(X, Y, w, h);
    
    
    [CATransaction setCompletionBlock:^{
        
        CGAffineTransform transform = _colorLayer.affineTransform;
        transform = CGAffineTransformRotate(transform, M_PI_2);
        _colorLayer.affineTransform = transform;

    }];
    
    
    [CATransaction commit];                    //合并一个事物
    
}


@end
