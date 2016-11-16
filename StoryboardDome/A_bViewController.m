//
//  A_bViewController.m
//  StoryboardDome
//
//  Created by airende on 16/8/8.
//  Copyright © 2016年 airende. All rights reserved.
//

#import "A_bViewController.h"
#import "BlockView.h"


#define H [UIScreen mainScreen].bounds.size.height
#define W [UIScreen mainScreen].bounds.size.width

typedef void(^BlockName) ();//BlockName 就是block的名字


@interface A_bViewController ()<BlockViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewHeight;

@property (nonatomic, copy) BlockName block;


@end

@implementation A_bViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.block = ^{
        NSLog(@"TypeBlock 下的结果");
    };
    
    //!-----------1---------------------------
    //定义一个block
    //! 无参 无返回值
    void (^printBlock)() = ^(){
        NSLog(@"123");
    };
    
    printBlock();//123
    
    //! 有参 无返回值
    void (^printNumberBlock)(int) = ^(int num){
        NSLog(@"入参为 %d",num);
    };
    
    printNumberBlock(9);//9
    
    //! 有返回 无入参
    int (^sumBlock)() = ^(){
        return 9+8;
    };
    
    int sum = sumBlock();
    NSLog(@"sumBlock = %d",sum);//17
    
    //! 有返回 有入参
    int (^sumWithTwoBlock)(int,int) = ^(int num1,int num2 ){
        
        return num1 + num2;
    };
    
    int all = sumWithTwoBlock(3,9);
    NSLog(@"sumWithTwoBlock = %d",all);//11
    
    ///结论
    /*!
     （1）在类中，定义一个Block变量，就像定义一个函数；
     
     （2）Block可以定义在方法内部，也可以定义在方法外部；
     
     （3）只有调用Block时候，才会执行其{}体内的代码；
     
     */
    //!-----------2---------------------------
    BlockView *view = [[[NSBundle mainBundle]loadNibNamed:@"BlockView" owner:nil options:nil] firstObject];
    view.frame = CGRectMake(0, 64, W, 100);
    
    //----  delegate
    view.delegate = self;
    
    //----  block
    view.blockButton = ^{
        
        NSLog(@"block将按钮事件传出");
    };
    
    [self.scrollView addSubview:view];
    
    //!-----------3---------------------------
    
}

//定义在方法外的 Block
int (^myBlock)() = ^{
    return 3;
};

//按钮方法通过代理出来
- (void)delegateButton{
    NSLog(@"BlockView的按钮方法代理出来了");
}



- (void)updateViewConstraints{
    [super updateViewConstraints];
    
    self.viewHeight.constant = H * 3;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)pushToDetail:(UIButton *)sender {
//    [self performSegueWithIdentifier:@"toDetail" sender:nil];
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
