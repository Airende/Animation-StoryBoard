//
//  C_cViewController.m
//  StoryboardDome
//
//  Created by airende on 16/8/24.
//  Copyright © 2016年 airende. All rights reserved.
//

#import "C_cViewController.h"


@interface C_cViewController ()
@property (weak, nonatomic) IBOutlet UIView *layerView;
@property (weak, nonatomic) IBOutlet UIButton *changeButton;

@property (nonatomic, strong) CALayer * colorLayer;
@property (nonatomic, strong) CALayer * imageLayer;



@property (nonatomic, strong) UIImageView * imageView;
@property (nonatomic, strong) NSArray * imageArray;

@property (nonatomic, strong) UIImageView * ballView;
@property (nonatomic, strong) NSTimer * timer;

@property (nonatomic, assign) NSTimeInterval duration;
@property (nonatomic, assign) NSTimeInterval timeOffset;
@property (nonatomic, strong) id fromValue;
@property (nonatomic, strong) id toValue;

@end

@implementation C_cViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    _colorLayer = [CALayer layer];
    _colorLayer.frame = CGRectMake(50, 10, 100, 100);
    _colorLayer.backgroundColor = [UIColor purpleColor].CGColor;
    
    [self.layerView.layer addSublayer:_colorLayer];
    
    /*
        创建一个移动动画
     1.使用 UIBezierPath(贝赛尔曲线) 创建一个曲线路线
     2.使用 CAShapeLayer 设置线的属性
     3.使用 CALayer 加载一张图片
     4.使用 CAKeyframeAnimation 创建一个动画 <CALayer对象方法>
     
     */
    
    //创建路径
    UIBezierPath *bezierPath = [[UIBezierPath alloc] init];
    [bezierPath moveToPoint:CGPointMake(0, 450)];
    [bezierPath addCurveToPoint:CGPointMake(370, 500) controlPoint1:CGPointMake(350, 200) controlPoint2:CGPointMake(300, 600)]; //一个曲线
    
    //路径样式
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = bezierPath.CGPath;
    shapeLayer.fillColor = [UIColor clearColor].CGColor; //填充色<默认黑色>
    shapeLayer.strokeColor = [UIColor blueColor].CGColor; //线色
    shapeLayer.lineWidth = 2;
    [self.view.layer addSublayer:shapeLayer];
    
    //动画本体
    _imageLayer = [CALayer layer];          //一个可以加动画的对象
    _imageLayer.frame = CGRectMake(0, 0, 45, 45);
    _imageLayer.position = CGPointMake(0, 450);
    _imageLayer.backgroundColor = [UIColor yellowColor].CGColor;
//    imageLayer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"A_2"].CGImage);
    [self.view.layer addSublayer:_imageLayer];
    
    //移动动画
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"position";     //动画操作对象
    animation.duration = 4;
    animation.repeatCount = 9;
    animation.keyTimes = @[@0.2 ,@0.8 ,@1];
    animation.path = bezierPath.CGPath;  //动画路线
    animation.rotationMode = kCAAnimationRotateAuto;  //方向
    [_imageLayer addAnimation:animation forKey:@"move"];
    
    //颜色变化
    CABasicAnimation *basicAnimation = [CABasicAnimation animation];
    basicAnimation.keyPath = @"backgroundColor";
    basicAnimation.duration = 4;
    basicAnimation.repeatCount = 9;
    basicAnimation.toValue = (__bridge id _Nullable)([UIColor redColor].CGColor);
    basicAnimation.delegate = self;
    [_imageLayer addAnimation:basicAnimation forKey:nil];
    
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.animations = @[animation,basicAnimation];
    animationGroup.duration = 4;
    animation.repeatCount = 9;
    [_imageLayer addAnimation:animationGroup forKey:@"changeColor"];
    
    
    
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(40, 480, 250,250 )];
    self.imageView.image = [UIImage imageNamed:@"A_3"];
    
    [self.view addSubview:_imageView];
    self.imageArray = @[[UIImage imageNamed:@"A_1"],
                        [UIImage imageNamed:@"A_2"],
                        [UIImage imageNamed:@"A_3"],
                        [UIImage imageNamed:@"A_4"],
                        [UIImage imageNamed:@"A_5"]];
    
    //复杂动画，缓冲
    UIImage *ballImage = [UIImage imageNamed:@"C_1"];
    self.ballView = [[UIImageView alloc] initWithImage:ballImage];
    self.ballView.frame = CGRectMake(350, 64, 50, 50);
    [self.view addSubview:_ballView];
    
    [self animationBall];
    
}



- (IBAction)changeButton:(id)sender {
    
    //动画1: 变色
    CGFloat red = arc4random() / (CGFloat)INT_MAX;
    CGFloat green = arc4random() / (CGFloat)INT_MAX;
    CGFloat blue = arc4random() / (CGFloat)INT_MAX;
    UIColor *color = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
    
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"backgroundColor";
//    animation.fillMode = kCAFillModeForwards;
    animation.toValue = (__bridge id _Nullable)(color.CGColor);
    animation.delegate = self;
    [_colorLayer addAnimation:animation forKey:nil];
    
    //动画2： 过渡
    CATransition *transition = [CATransition animation];
    transition.type = kCATransitionFade;
    [self.imageView.layer addAnimation:transition forKey:nil];
    UIImage *image = self.imageView.image;
    NSUInteger index = [self.imageArray indexOfObject:image];
    index = (index + 1) % [self.imageArray count];
    self.imageView.image = self.imageArray[index];
    
    //动画3：移除移动动画
//    [_imageLayer removeAllAnimations];
    
}

- (void)animationDidStop:(CABasicAnimation *)anim finished:(BOOL)flag {
    //set the backgroundColor property to match animation toValue [CATransaction begin];
    [CATransaction setDisableActions:YES];
//    self.colorLayer.backgroundColor = (__bridge CGColorRef)anim.toValue;
    [CATransaction commit];
}


float interpolate(float from, float to, float time)
{
    return (to - from) * time + from;
}

float quadraticEaseInOut(float t)
{
    return (t < 0.5)? (2 * t * t): (-2 * t * t) + (4 * t) - 1;
}

float bounceEaseOut(float t)
{
    if (t < 4/11.0) {
        return (121 * t * t)/16.0;
    } else if (t < 8/11.0) {
        return (363/40.0 * t * t) - (99/10.0 * t) + 17/5.0;
    } else if (t < 9/10.0) {
        return (4356/361.0 * t * t) - (35442/1805.0 * t) + 16061/1805.0;
    }
    return (54/5.0 * t * t) - (513/25.0 * t) + 268/25.0;
}

- (void)animationBall{
    
    /*   方案二   利用数学计算
     
    NSValue *fromValue = [NSValue valueWithCGPoint:CGPointMake(375, 32)];
    NSValue *toValue = [NSValue valueWithCGPoint:CGPointMake(375, 268)];
    CFTimeInterval duration = 1.0;
    //generate keyframes
    NSInteger numFrames = duration * 60;
    NSMutableArray *frames = [NSMutableArray array];
    for (int i = 0; i < numFrames; i++) {
        float time = 1 / (float)numFrames * i;
        time = bounceEaseOut(time);
        [frames addObject:[self interpolateFromValue:fromValue toValue:toValue time:time]];
    }
     
    */
    
    
    /*方案一、二
    CAKeyframeAnimation *keyAnimation = [CAKeyframeAnimation animation];
    keyAnimation.keyPath = @"position";
    keyAnimation.duration = 1;
    keyAnimation.delegate = self;
    */
    
    
    //*方案三  时间帧
    self.duration = 1.0;
    self.timeOffset = 0.0;
    self.fromValue = [NSValue valueWithCGPoint:CGPointMake(375, 32)];
    self.toValue = [NSValue valueWithCGPoint:CGPointMake(375, 268)];
    [self.timer invalidate];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1/60.0 target:self selector:@selector(step:) userInfo:nil repeats:YES];
    //*/
    
    
    /* 方案二
     
    keyAnimation.values = frames;
     
     */
    
    /*  方案一   简单除暴
     
     keyAnimation.values = @[[NSValue valueWithCGPoint:CGPointMake(375, 32)],
                            [NSValue valueWithCGPoint:CGPointMake(375, 268)],
                            [NSValue valueWithCGPoint:CGPointMake(375, 140)],
                            [NSValue valueWithCGPoint:CGPointMake(375, 268)],
                            [NSValue valueWithCGPoint:CGPointMake(375, 220)],
                            [NSValue valueWithCGPoint:CGPointMake(375, 268)],
                            [NSValue valueWithCGPoint:CGPointMake(375, 250)],
                            [NSValue valueWithCGPoint:CGPointMake(375, 268)]
                            ];
    
    keyAnimation.timingFunctions = @[
                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]
                                     ];
    
    keyAnimation.keyTimes = @[@0.0, @0.3, @0.5, @0.7, @0.8, @0.9, @0.95, @1.0];
     */
    
    
    self.ballView.layer.position = CGPointMake(375, 268);
    /*方案一、二
    [self.ballView.layer addAnimation:keyAnimation forKey:nil];
     */
}

- (id)interpolateFromValue:(id)fromValue toValue:(id)toValue time:(float)time{
    
    if ([fromValue isKindOfClass:[NSValue class]]) {
        //get type
        const char *type = [fromValue objCType];
        if (strcmp(type, @encode(CGPoint)) == 0) {
            CGPoint from = [fromValue CGPointValue];
            CGPoint to = [toValue CGPointValue];
            CGPoint result = CGPointMake(interpolate(from.x, to.x, time),
                                         interpolate(from.y, to.y, time));
            return [NSValue valueWithCGPoint:result];
            }
        }
    
    return (time < 0.5)? fromValue: toValue;
}


- (void)step:(NSTimer *)step
{
    //update time offset
    self.timeOffset = MIN(self.timeOffset + 1/60.0, self.duration);
    //get normalized time offset (in range 0 - 1)
    float time = self.timeOffset / self.duration;
    //apply easing
    time = bounceEaseOut(time);

    id position = [self interpolateFromValue:self.fromValue
                                 toValue:self.toValue
                                    time:time];
    //move ball view to new position
    self.ballView.center = [position CGPointValue];
    //stop the timer if we've reached the end of the animation
    if (self.timeOffset >= self.duration) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //replay animation on tap
    [self animationBall];
}

@end
