//
//  BaseTBViewController.m
//  StoryboardDome
//
//  Created by airende on 16/8/8.
//  Copyright © 2016年 airende. All rights reserved.
//

#import "BaseTBViewController.h"

@interface BaseTBViewController ()<UITabBarControllerDelegate>

@end

@implementation BaseTBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.delegate = self;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    
    //set up crossfade transition
    CATransition *transition = [CATransition animation];
//    transition.duration = 3;
    transition.type = kCATransitionFade;
    //apply transition to tab bar controller's view
    [self.view.layer addAnimation:transition forKey:nil];
    
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
