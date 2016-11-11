//
//  C_dViewController.m
//  StoryboardDome
//
//  Created by airende on 2016/10/27.
//  Copyright © 2016年 airende. All rights reserved.
//

#import "C_dViewController.h"




#define ButtonW 50
@interface C_dViewController ()
{
    BOOL _isSelect;
}

@property (nonatomic, strong) UIView *playButtonView;
@property (nonatomic, strong) CAShapeLayer *leftLayer;
@property (nonatomic, strong) CAShapeLayer *rightLayer;

@property (nonatomic, strong) UIView * fristView;
@property (nonatomic, strong) UIView * secondView;
@property (nonatomic, strong) UIView * thirdView;



@end

@implementation C_dViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //按钮动画
    [self creatPlayButton];
    
    //图片动画
    [self initView];
    
    //path 动画
    [self pathCoerAnimation];
    
}
///-------------------------------| 创建播放按钮动画
- (void)creatPlayButton{
    
    _isSelect = NO;

    //播放按钮动画创建
    _playButtonView = [[UIView alloc] initWithFrame:CGRectMake(30, 70, ButtonW, ButtonW)];
    _playButtonView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    _playButtonView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapReg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pathAnimation)];
    [_playButtonView addGestureRecognizer:tapReg];

    [self creatBezierPathAndLayer];
    [self.view addSubview:_playButtonView];
}

- (void)creatBezierPathAndLayer{
    
    _leftLayer = [CAShapeLayer layer];
    _leftLayer.path = [self creatBezierPath_unselect_left].CGPath;

    _leftLayer.fillColor = [UIColor blackColor].CGColor;
    
    [_playButtonView.layer addSublayer:_leftLayer];
    
    
    _rightLayer = [CAShapeLayer layer];
    
    _rightLayer.path = [self creatBezierPath_unselect_right].CGPath;
    _rightLayer.fillColor = [UIColor blackColor].CGColor;
    
    [_playButtonView.layer addSublayer:_rightLayer];
}

- (UIBezierPath *)creatBezierPath_unselect_left{
    
    UIBezierPath *leftPath = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, (ButtonW-8)/2, ButtonW)];

    return leftPath;
}

- (UIBezierPath *)creatBezierPath_unselect_right{
    
    UIBezierPath *rightPath = [UIBezierPath bezierPathWithRect:CGRectMake((ButtonW-8)/2+8, 0, (ButtonW-8)/2, ButtonW)];

    return rightPath;
}

- (UIBezierPath *)creatBezierPath_select_left{

    UIBezierPath *leftPath = [UIBezierPath bezierPath];
    [leftPath moveToPoint:CGPointMake(0, 0)];
    [leftPath addLineToPoint:CGPointMake(ButtonW/2, ButtonW/4)];
    [leftPath addLineToPoint:CGPointMake(ButtonW/2, ButtonW/4*3)];
    [leftPath addLineToPoint:CGPointMake(0, ButtonW)];
    [leftPath addLineToPoint:CGPointMake(0, 0)];

    return leftPath;
}

- (UIBezierPath *)creatBezierPath_select_right{
    
    UIBezierPath *rightPath = [UIBezierPath bezierPath];
    [rightPath moveToPoint:CGPointMake(ButtonW/2, ButtonW/4)];
    [rightPath addLineToPoint:CGPointMake(ButtonW, ButtonW/2)];
    [rightPath addLineToPoint:CGPointMake(ButtonW, ButtonW/2)];
    [rightPath addLineToPoint:CGPointMake(ButtonW/2, ButtonW/4*3)];
    [rightPath addLineToPoint:CGPointMake(ButtonW/2, ButtonW/4)];
    
    return rightPath;
}


- (void)pathAnimation{
    NSLog(@"---");
    [_leftLayer removeAllAnimations];
    [_rightLayer removeAllAnimations];
    
    
    CABasicAnimation *leftAnimation = [CABasicAnimation animation];
    leftAnimation.removedOnCompletion = NO;
    leftAnimation.fillMode=kCAFillModeForwards;
    leftAnimation.keyPath = @"path";
    leftAnimation.duration = 0.25;
    if (_isSelect) {
        leftAnimation.fromValue = (__bridge id _Nullable)([self creatBezierPath_select_left].CGPath);
        leftAnimation.toValue = (__bridge id _Nullable)([self creatBezierPath_unselect_left].CGPath);
    }else{
        leftAnimation.fromValue = (__bridge id _Nullable)([self creatBezierPath_unselect_left].CGPath);
        leftAnimation.toValue = (__bridge id _Nullable)([self creatBezierPath_select_left].CGPath);
    }

    [_leftLayer addAnimation:leftAnimation forKey:@"left"];
    
    
    CABasicAnimation *rightAnimation = [CABasicAnimation animation];
    rightAnimation.removedOnCompletion = NO;
    rightAnimation.fillMode=kCAFillModeForwards;
    rightAnimation.keyPath = @"path";
    rightAnimation.duration = 0.25;
    if (_isSelect) {
        rightAnimation.fromValue = (__bridge id _Nullable)([self creatBezierPath_select_right].CGPath);
        rightAnimation.toValue = (__bridge id _Nullable)([self creatBezierPath_unselect_right].CGPath);
    }else{
        rightAnimation.fromValue = (__bridge id _Nullable)([self creatBezierPath_unselect_right].CGPath);
        rightAnimation.toValue = (__bridge id _Nullable)([self creatBezierPath_select_right].CGPath);
    }
    
    [_rightLayer addAnimation:rightAnimation forKey:@"right"];
    _isSelect = !_isSelect;

}


///------------------------------ | 创建播放按钮动画 🔚


///------------------------------ | 图片动画
- (void)initView{
    
    [self initImageView];
    
    [self startAnimationForFirstView];
    [self startAnimationForSecondView];
    [self startAnimationForThirdView];
}

- (void)initImageView{
    
    _fristView = [[UIView alloc] initWithFrame:CGRectMake(120, 70, 50, 50)];
    
    UIImageView *imageView1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"xingxing1"]];
    imageView1.tag = 1;
    imageView1.frame = CGRectMake(0, 0, 50, 50);
    [_fristView addSubview:imageView1];
    
    UIImageView *imageView2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"biaoqian2"]];
    imageView2.tag = 2;
    imageView2.layer.anchorPoint = CGPointMake(35.5/ 50.0, 16/ 50.0);//设置锚点
    imageView2.frame = _fristView.bounds;
    [_fristView addSubview:imageView2];
    
    UIImageView *imageView3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"xingxing2"]];
    imageView3.tag = 3;
    imageView3.frame = CGRectMake(0, 0, 50, 50);
    [_fristView addSubview:imageView3];
    
    [self.view addSubview:_fristView];
    
    _secondView = [[UIView alloc] initWithFrame:CGRectMake(200, 70, 50, 50)];
    
    UIImageView *imageView4 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"biaoqian1"]];
    imageView4.tag = 4;
    imageView4.frame = CGRectMake(0, 0, 50, 50);
    [_secondView addSubview:imageView4];
    
    UIImageView *imageView5 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"qipao2"]];
    imageView5.tag = 5;
    imageView5.layer.anchorPoint = CGPointMake(30/50.0, 20/50.0);

    imageView5.frame = CGRectMake(0, 0, 50, 50);
    [_secondView addSubview:imageView5];
    
    [self.view addSubview:_secondView];
    
    
    _thirdView = [[UIView alloc] initWithFrame:CGRectMake(175, 100, 100, 100)];
    
    UIImageView *imageView6 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"biaoqian3"]];
    imageView6.tag = 6;
    imageView6.frame = CGRectMake(0, 0, 100, 100);
    imageView6.layer.anchorPoint = CGPointMake(50/100.0, 20/100.0);
    [_thirdView addSubview:imageView6];
    
    [self.view addSubview:_thirdView];
    
  
}
- (void)startAnimationForFirstView{
    
    CABasicAnimation *animation2 = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation2.duration = 1.5; // 持续时间
    animation2.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation2.repeatCount = HUGE_VALF; // 重复次数
    animation2.fromValue =  [NSNumber numberWithFloat:-M_PI/ 10.0];// 起始角度
    animation2.toValue = [NSNumber numberWithFloat:M_PI/ 10.0]; // 终止角度
    animation2.autoreverses = YES;
    UIImageView *imageView2 = [_fristView viewWithTag:2];
    [imageView2.layer addAnimation:animation2 forKey:nil];
    
    
    CABasicAnimation *animation1 = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation1.duration = 1.5; // 持续时间
    animation1.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation1.repeatCount = HUGE_VALF; // 重复次数
    animation1.fromValue = @1 ;
    animation1.toValue = @0.1; // 终止角度
    animation1.autoreverses = YES;
    UIImageView *imageView1 = [_fristView viewWithTag:1];
    [imageView1.layer addAnimation:animation1 forKey:nil];
    
    CABasicAnimation *animation3 = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation3.duration = 1.5; // 持续时间
    animation3.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation3.repeatCount = HUGE_VALF; // 重复次数
    animation3.fromValue = @0.1 ;
    animation3.toValue = @1;
    animation3.autoreverses = YES;
    UIImageView *imageView3 = [_fristView viewWithTag:3];
    [imageView3.layer addAnimation:animation3 forKey:nil];
    
}
- (void)startAnimationForSecondView{
    
    UIImageView *qipao = [_secondView viewWithTag:5];
    
    CABasicAnimation *animation1 = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation1.duration = 0.4;
    animation1.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    animation1.repeatCount = HUGE_VALF;
    animation1.fromValue = [NSNumber numberWithFloat:-M_PI/ 12.0];
    animation1.toValue = [NSNumber numberWithFloat:0];
    animation1.fillMode = kCAFillModeForwards;
    animation1.removedOnCompletion = NO;
    
    
    CABasicAnimation *animation2 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation2.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    animation2.duration = 0.4;
    animation2.repeatCount = 1;
    animation2.fromValue =  @0.9;// 起始角度
    animation2.toValue = @1; // 终止角度
    animation2.fillMode = kCAFillModeForwards;
    animation2.removedOnCompletion = NO;
    
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.repeatCount = HUGE_VALF;
    animationGroup.duration = 0.4;
    animationGroup.autoreverses = YES;
    animationGroup.animations = @[animation1,animation2];
    
    [qipao.layer addAnimation:animationGroup forKey:nil];
    
    
}
- (void)startAnimationForThirdView{
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.duration = 1;
    animation.repeatCount = HUGE_VALF;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.autoreverses = YES;//原路返回重复
    animation.fromValue = [NSNumber numberWithFloat:-M_PI/ 10.0];
    animation.toValue = [NSNumber numberWithFloat:M_PI/ 10.0];
    
    UIImageView *biaoqian3 = [_thirdView viewWithTag:6];
    [biaoqian3.layer addAnimation:animation forKey:nil];
}
///------------------------------- | 图片动画 🔚

- (void)pathCoerAnimation{
    
    
    UIBezierPath *path1 = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(100, 200, 50, 50) cornerRadius:25.0];
    
    CAShapeLayer *pathLayer1 = [CAShapeLayer layer];
    pathLayer1.path = path1.CGPath;
    //pathLayer.fillColor = [UIColor clearColor].CGColor;
    pathLayer1.strokeColor = [UIColor redColor].CGColor;
    pathLayer1.lineWidth = 3;
    
    
    UIBezierPath *path2 = [UIBezierPath bezierPath];
    [path2 moveToPoint:CGPointMake(250, 250)];
    [path2 addLineToPoint:CGPointMake(300, 250)];
    [path2 addLineToPoint:CGPointMake(300, 300)];
    [path2 addLineToPoint:CGPointMake(250, 300)];
    //[path2 addLineToPoint:CGPointMake(250, 250)];
    [path2 closePath];
    
    CAShapeLayer *pathLayer2 = [CAShapeLayer layer];
    pathLayer2.path = path1.CGPath;
    //pathLayer.fillColor = [UIColor clearColor].CGColor;
    pathLayer2.strokeColor = [UIColor blueColor].CGColor;
    pathLayer2.lineWidth = 5;

    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"path"];
    animation.removedOnCompletion = NO;
    animation.fillMode=kCAFillModeForwards;
    animation.duration = 10;
    animation.repeatCount = 1000;
    animation.autoreverses = YES;
    animation.fromValue = (__bridge id _Nullable)(path1.CGPath);
    animation.toValue = (__bridge id _Nullable)(path2.CGPath);
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    
    [pathLayer2 addAnimation:animation forKey:nil];
    [self.view.layer addSublayer:pathLayer2];

}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
